class OrderStatisticsModel {
  dynamic allOrders;
  dynamic ordersDelivered;
  dynamic totalPrice;

  OrderStatisticsModel({this.allOrders, this.ordersDelivered, this.totalPrice});

  factory OrderStatisticsModel.fromJson(Map<String, dynamic> json) {
    return OrderStatisticsModel(
      allOrders: json['all_orders'],
      ordersDelivered: json['orders_delivered'],
      totalPrice: json['total_price'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all_orders'] = this.allOrders;
    data['orders_delivered'] = this.ordersDelivered;
    data['total_price'] = this.totalPrice;

    return data;
  }
}
