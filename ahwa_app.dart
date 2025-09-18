import 'dart:io';
import 'repositories/order_repository.dart';
import 'services/order_service.dart';
import 'services/report_service.dart';
import 'services/menu_service.dart';

class SmartAhwaManager {
  final OrderService _orderService;
  final DailySalesReportService _reportService;
  final AhwaMenuService _menuService;

  factory SmartAhwaManager.create() {
    final repository = OrderRepository();
    return SmartAhwaManager._internal(
      OrderService(repository),
      DailySalesReportService(repository),
      AhwaMenuService(),
    );
  }

  SmartAhwaManager._internal(
    this._orderService,
    this._reportService,
    this._menuService,
  );

  Future<void> run() async {
    print('Welcome to Smart Ahwa Manager');

    while (true) {
      _showMainMenu();
      final choice = _getChoice();

      switch (choice) {
        case 1:
          await _addNewOrder();
          break;
        case 2:
          await _viewPendingOrders();
          break;
        case 3:
          await _completeOrder();
          break;
        case 4:
          await _showDailyReport();
          break;
        case 5:
          print('Salama! Closing the ahwa');
          return;
        default:
          print('❌ Invalid choice. Try again.');
      }

      print('\nPress Enter to continue...');
      stdin.readLineSync();
    }
  }

  void _showMainMenu() {
    print('\n📋 Main Menu:');
    print('1. 📝 Add New Order');
    print('2. 👀 View Pending Orders');
    print('3. ✅ Complete Order');
    print('4. 📊 Daily Sales Report');
    print('5. 🚪 Exit');
    print('');
  }

  int _getChoice() {
    stdout.write('Choose option (1-5): ');
    final input = stdin.readLineSync();
    return int.tryParse(input ?? '') ?? 0;
  }

  String _getString(String prompt) {
    stdout.write('$prompt: ');
    return stdin.readLineSync() ?? '';
  }

  Future<void> _addNewOrder() async {
    print('\n☕ Adding New Order');
    print('=' * 25);

    final customerName = _getString('Customer name');
    if (customerName.isEmpty) {
      print('❌ Customer name is required!');
      return;
    }

    _menuService.displayMenu();
    stdout.write(
      'Choose drink (1-${_menuService.getAvailableDrinks().length}): ',
    );
    final drinkChoice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    final selectedDrink = _menuService.getDrinkByIndex(drinkChoice - 1);
    if (selectedDrink == null) {
      print('❌ Invalid drink choice!');
      return;
    }

    final specialInstructions = _getString('Special instructions (optional)');

    try {
      final order = await _orderService.createOrder(
        customerName: customerName,
        drink: selectedDrink,
        specialInstructions: specialInstructions,
      );

      print('\n✅ Order created successfully!');
      print('Order ID: ${order.id}');
      print('Customer: ${order.customer.name}');
      print('Drink: ${order.drink.name}');
      if (specialInstructions.isNotEmpty) {
        print('Special Instructions: $specialInstructions');
      }
      print('Total Price: ${order.totalPrice.toStringAsFixed(2)} ₪');
    } catch (e) {
      print('❌ Error creating order: $e');
    }
  }

  Future<void> _viewPendingOrders() async {
    print('\n📋 Pending Orders');
    print('=' * 20);

    final pendingOrders = await _orderService.getPendingOrders();

    if (pendingOrders.isEmpty) {
      print('No pending orders');
      return;
    }

    for (final order in pendingOrders) {
      print('\nOrder: ${order.id}');
      print('Customer: ${order.customer.name}');
      print('Drink: ${order.drink.name}');
      if (order.specialInstructions.isNotEmpty) {
        print('Instructions: ${order.specialInstructions}');
      }
      print('Price: ${order.totalPrice.toStringAsFixed(2)} ₪');
      print('Ordered: ${_formatTime(order.createdAt)}');
      print('-' * 30);
    }
  }

  Future<void> _completeOrder() async {
    print('\n✅ Complete Order');
    print('=' * 18);

    final pendingOrders = await _orderService.getPendingOrders();

    if (pendingOrders.isEmpty) {
      print('No pending orders to complete!');
      return;
    }

    print('Pending Orders:');
    for (int i = 0; i < pendingOrders.length; i++) {
      final order = pendingOrders[i];
      print(
        '${i + 1}. ${order.customer.name} - ${order.drink.name} (${order.id})',
      );
    }

    stdout.write('\nChoose order to complete (1-${pendingOrders.length}): ');
    final choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (choice < 1 || choice > pendingOrders.length) {
      print('❌ Invalid choice!');
      return;
    }

    final selectedOrder = pendingOrders[choice - 1];

    try {
      await _orderService.completeOrder(selectedOrder.id);
      print('✅ Order ${selectedOrder.id} completed successfully!');
      print(
        'Customer ${selectedOrder.customer.name} can enjoy her ${selectedOrder.drink.name}!',
      );
    } catch (e) {
      print('❌ Error completing order: $e');
    }
  }

  Future<void> _showDailyReport() async {
    print('\n📊 Generating Daily Report...');
    print('=' * 35);

    try {
      final report = await _reportService.generateReport();
      print(report);

      final stats = await _orderService.getSimpleStats();
      print('\n📈 Quick Stats:');
      print('Total Orders Today: ${stats['total']}');
      print('Pending: ${stats['pending']}');
      print('Completed: ${stats['completed']}');
    } catch (e) {
      print('❌ Error generating report: $e');
    }
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
