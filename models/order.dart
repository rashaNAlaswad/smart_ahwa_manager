import 'drink.dart';
import 'customer.dart';
import 'order_status.dart';

class Order {
  final String id;
  final Customer customer;
  final Drink drink;
  final String specialInstructions;
  final DateTime createdAt;
  final double totalPrice;
  OrderStatus _status;

  Order({
    required this.id,
    required this.customer,
    required this.drink,
    this.specialInstructions = '',
    DateTime? createdAt,
    OrderStatus status = OrderStatus.pending,
  }) : createdAt = createdAt ?? DateTime.now(),
       _status = status,
       totalPrice = drink.calculatePrice();

  OrderStatus get status => _status;

  void markCompleted() {
    _status = OrderStatus.completed;
  }

  factory Order.create({
    required String customerName,
    required Drink drink,
    String specialInstructions = '',
    bool isRegularCustomer = false,
  }) {
    final customer = Customer(name: customerName, isRegular: isRegularCustomer);

    return Order(
      id: _generateOrderId(),
      customer: customer,
      drink: drink,
      specialInstructions: specialInstructions,
    );
  }

  static String _generateOrderId() {
    return 'ORD_${DateTime.now().millisecondsSinceEpoch}';
  }
}
