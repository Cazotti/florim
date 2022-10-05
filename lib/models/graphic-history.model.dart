import './currency.model.dart';

class GraphicHistory {
  Currency currency;
  DateTime date;
  double quantity;
  double value;
  String type;

  GraphicHistory({
    required this.currency,
    required this.date,
    required this.quantity,
    required this.type,
    required this.value,
  });
}
