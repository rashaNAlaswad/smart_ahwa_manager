abstract class Drink {
  String get name;
  double get basePrice;

  double calculatePrice() {
    return basePrice;
  }
}

class Shai extends Drink {
  @override
  double get basePrice => 3.0;

  @override
  String get name => 'Shai';
}

class TurkishCoffee extends Drink {
  @override
  double get basePrice => 10.0;

  @override
  String get name => 'Turkish Coffee';
}

class HibiscusTea extends Drink {
  @override
  double get basePrice => 4.0;

  @override
  String get name => 'Hibiscus Tea';
}
