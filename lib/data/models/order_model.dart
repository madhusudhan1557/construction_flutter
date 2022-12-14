class OrderModel {
  final String itemname;
  final String brandname;
  final String suppliername;
  final double quantity;
  String? status;
  final double rate;
  final String unit;

  OrderModel({
    required this.itemname,
    required this.brandname,
    required this.suppliername,
    required this.quantity,
    this.status,
    required this.rate,
    required this.unit,
  });
}
