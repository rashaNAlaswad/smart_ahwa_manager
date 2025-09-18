import '../models/order.dart';
import '../models/order_status.dart';

class OrderRepository {
  final List<Order> _orders = [];

  Future<List<Order>> getAllOrders() async {
    return _orders;
  }

  Future<List<Order>> getPendingOrders() async {
    return _orders
        .where((order) => order.status == OrderStatus.pending)
        .toList();
  }

  Future<List<Order>> getCompletedOrders() async {
    return _orders
        .where((order) => order.status == OrderStatus.completed)
        .toList();
  }

  Future<Order?> getOrderById(String id) async {
    for (final order in _orders) {
      if (order.id == id) return order;
    }
    return null;
  }

  Future<void> saveOrder(Order order) async {
    _orders.add(order);
  }

  Future<void> updateOrder(Order order) async {
    for (int i = 0; i < _orders.length; i++) {
      if (_orders[i].id == order.id) {
        _orders[i] = order;
        break;
      }
    }
  }
}
