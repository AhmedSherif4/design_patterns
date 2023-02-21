import 'ingredient_base.dart';

class Burger {
  final List<Ingredient> _ingredients = [];
  double _price = 0;

  void addIngredient(Ingredient ingredient) {
    _ingredients.add(ingredient);
  }

  String getFormattedIngredients() {
    return _ingredients.map((x) => x.getName()).join(', ');
  }

  String getFormattedAllergens() {
    Set<String> allergens = <String>{};

    for (var x in _ingredients) {
      allergens.addAll(x.getAllergens());
    }

    return allergens.join(', ');
  }

  String getFormattedPrice() {
    return '\$${_price.toStringAsFixed(2)}';
  }

  void setPrice(double price) {
    _price = price;
  }
}
