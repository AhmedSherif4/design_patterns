
import '../observer.dart';

class StockTickerModel {
  final StockTicker stockTicker;

  bool subscribed = false;

  StockTickerModel({
    required this.stockTicker,
  });

  void toggleSubscribed() {
    subscribed = !subscribed;
  }

}
