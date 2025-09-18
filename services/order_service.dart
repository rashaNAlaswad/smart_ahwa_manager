import '../models/order.dart';
import '../models/drink.dart';
import '../repositories/order_repository.dart';

class OrderService {
  final OrderRepository _repository;

  OrderService(this._repository);

  Future<Order> createOrder({
    required String customerName,
    required Drink drink,
    String specialInstructions = '',
    bool isRegularCustomer = false,
  }) async {
    final order = Order.create(
      customerName: customerName,
      drink: drink,
      specialInstructions: specialInstructions,
      isRegularCustomer: isRegularCustomer,
    );

    await _repository.saveOrder(order);
    return order;
  }

  Future<void> completeOrder(String orderId) async {
    final order = await _repository.getOrderById(orderId);
    if (order != null) {
      order.markCompleted();
      await _repository.updateOrder(order);
    }
  }

  Future<List<Order>> getPendingOrders() async {
    return await _repository.getPendingOrders();
  }

  Future<Map<String, int>> getSimpleStats() async {
    final allOrders = await _repository.getAllOrders();
    final pendingOrders = await _repository.getPendingOrders();
    final completedOrders = await _repository.getCompletedOrders();

    return {
      'total': allOrders.length,
      'pending': pendingOrders.length,
      'completed': completedOrders.length,
    };
  }
}
