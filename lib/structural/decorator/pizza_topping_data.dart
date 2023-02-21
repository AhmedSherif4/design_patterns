class PizzaToppingData {
  final String label;
  bool selected = false;

  PizzaToppingData(this.label);

  void setSelected({required bool isSelected}) {
    selected = isSelected;
  }
}
