enum OrderStatus {
  pending,
  inProgress,
  completed;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.inProgress:
        return 'In Progress';
      case OrderStatus.completed:
        return 'Completed';
    }
  }

  bool get isActive =>
      this == OrderStatus.pending || this == OrderStatus.inProgress;
}
