# Smart Ahwa Manager

A console-based Flutter application for managing ahwa (coffee shop) operations. Built with SOLID principles and core OOP concepts.

## Features

- ☕ Add new customer orders with drink selection and special instructions
- 📋 View pending orders with detailed information
- ✅ Mark orders as completed
- 📊 Generate daily sales reports with revenue and statistics

## App Structure

```
smart_ahwa_manager/
├── main.dart                   # Application entry point
├── ahwa_app.dart               # Main console UI application
├── models/
│   ├── customer.dart           # Customer data model
│   ├── drink.dart              # Abstract drink class and implementations
│   ├── order.dart              # Order management with status tracking
│   └── order_status.dart       # Order status enumeration
├── repositories/
│   └── order_repository.dart   # Data access layer for orders
└── services/
    ├── menu_service.dart       # Menu management service
    ├── order_service.dart      # Business logic for order operations
    └── report_service.dart     # Daily sales reporting service
```

## SOLID Principles Implementation

### 1. Single Responsibility Principle (SRP)
The `DailySalesReportService` class has a single responsibility: generating daily sales reports. It only handles sales data aggregation and report formatting, without mixing concerns like order management or user interface logic. Similarly, `OrderService` focuses solely on order-related business operations, and `AhwaMenuService` handles only menu display and drink selection. This separation ensures that changes to one area don't affect other parts of the system.

### 2. Open/Closed Principle (OCP)
The `Drink` abstract class demonstrates this principle perfectly. The system is open for extension (new drink types can be easily added by extending the base class) but closed for modification (existing drink implementations don't need to change when new drinks are added). The `AhwaMenuService` can accommodate new drink types without requiring modifications to its core functionality.

## Core OOP Concepts

### Inheritance and Polymorphism
The drink hierarchy (`Shai`, `TurkishCoffee`, `HibiscusTea`) demonstrates inheritance by extending the abstract `Drink` class. Polymorphism is evident in how the `Order` class can work with any drink type through the common interface, calculating prices dynamically based on each drink's specific implementation.

### Encapsulation
The `Order` class encapsulates order state management by making status private (`_status`) and providing controlled access through public methods like `markCompleted()`. The menu service protects internal drinks list with `List.unmodifiable()`. This prevents external code from directly manipulating internal state, ensuring data integrity.

### Abstraction
Abstract classes like `Drink` hide implementation details while exposing only essential functionality. The service layer abstracts business logic from UI concerns, making the code more flexible and easier to understand.


## How to Run

1. Navigate to the project directory:
   ```bash
   cd smart_ahwa_manager
   ```

2. Run the application:
   ```bash
   dart run main.dart
   ```

3. Follow the interactive menu prompts to manage your ahwa!

## Screenshots

### Main Menu & Add Order
<img width="400" alt="Main Menu and Add Order Flow" src="https://github.com/user-attachments/assets/4d27aa40-902a-4c22-aa4d-ea790a989904" />

### Pending Orders
<img width="400" alt="View Pending Orders" src="https://github.com/user-attachments/assets/e32ad962-280e-473b-90c0-4afdacc56182" />

### Order Management
<img width="400" alt="View and Complete Orders" src="https://github.com/user-attachments/assets/c95f9a63-c537-4821-a288-6d4cd99877b5" />

### Daily Sales Report
<img width="400" alt="Daily Sales Report" src="https://github.com/user-attachments/assets/a3d7990c-a95a-410a-a2d1-0223c0af90d8" />






