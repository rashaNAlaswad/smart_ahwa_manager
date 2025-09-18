import '../models/drink.dart';

class AhwaMenuService {
  final List<Drink> _drinks = [];

  AhwaMenuService() {
    _initializeDefaultMenu();
  }

  void _initializeDefaultMenu() {
    _drinks.addAll([Shai(), TurkishCoffee(), HibiscusTea()]);
  }

  List<Drink> getAvailableDrinks() => List.unmodifiable(_drinks);

  void displayMenu() {
    print('\n☕ Ahwa Menu ☕');
    print('=' * 30);
    for (int i = 0; i < _drinks.length; i++) {
      print(
        '${i + 1}. ${_drinks[i].name} - ${_drinks[i].basePrice.toStringAsFixed(1)} ₪',
      );
    }
    print('=' * 30);
  }

  Drink? getDrinkByIndex(int index) {
    if (index >= 0 && index < _drinks.length) {
      return _drinks[index];
    }
    return null;
  }
}
