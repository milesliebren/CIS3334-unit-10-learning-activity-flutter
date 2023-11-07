// pizza.dart
class Pizza {
  String toppings;
  double price;
  String size;

  Pizza({required this.toppings, required this.size}) : price = 0.0;

  double calculatePrice() {
    final PIZZA_PRICES = [7.99, 9.99, 12.99, 14.99];
    final PIZZA_SIZES = ["Small", "Medium", "Large", "X-Large"];
    int sizeIndex = PIZZA_SIZES.indexOf(size);
    return sizeIndex >= 0 && sizeIndex < PIZZA_PRICES.length
        ? PIZZA_PRICES[sizeIndex]
        : 0.0;
  }

  double getPrice() {
    return calculatePrice();
  }
}