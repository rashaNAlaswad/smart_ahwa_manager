import '../models/order_status.dart';
import '../repositories/order_repository.dart';

class DailySalesReportService {
  final OrderRepository _repository;

  DailySalesReportService(this._repository);

  Future<Map<String, dynamic>> getDailySalesData() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final allOrders = await _repository.getAllOrders();
    final todaysOrders = allOrders
        .where(
          (order) =>
              order.createdAt.isAfter(startOfDay) &&
              order.createdAt.isBefore(endOfDay),
        )
        .toList();

    final completedOrders = todaysOrders
        .where((order) => order.status == OrderStatus.completed)
        .toList();

    final totalRevenue = completedOrders.fold<double>(
      0,
      (sum, order) => sum + order.totalPrice,
    );

    return {
      'date': today.toIso8601String().split('T')[0],
      'totalOrders': todaysOrders.length,
      'completedOrders': completedOrders.length,
      'totalRevenue': totalRevenue,
      'averageOrderValue': completedOrders.isEmpty
          ? 0.0
          : totalRevenue / completedOrders.length,
    };
  }

  Future<String> generateReport() async {
    final data = await getDailySalesData();
    final buffer = StringBuffer();

    buffer.writeln('Daily Sales Report - ${data['date']}');
    buffer.writeln('=' * 40);
    buffer.writeln('Total Orders: ${data['totalOrders']}');
    buffer.writeln('Completed Orders: ${data['completedOrders']}');
    buffer.writeln(
      'Total Revenue: ${data['totalRevenue'].toStringAsFixed(2)} ₪',
    );
    buffer.writeln(
      'Average Order Value: ${data['averageOrderValue'].toStringAsFixed(2)} ₪',
    );

    return buffer.toString();
  }
}
