class HomeScreenModel {
  dynamic pending;
  dynamic confirmed;
  dynamic processing;
  dynamic outForDelivery;
  dynamic delivered;
  dynamic canceled;
  dynamic returned;
  dynamic failed;
  dynamic totalPrice;
  dynamic pendingPrice;
  dynamic deliveredPrice;
  dynamic wallet;
  HomeScreenModel(
      {this.pending,
      this.confirmed,
      this.processing,
      this.outForDelivery,
      this.delivered,
      this.canceled,
      this.returned,
      this.totalPrice,
      this.pendingPrice,
      this.deliveredPrice,
      this.wallet,
      this.failed});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    outForDelivery = json['out_for_delivery'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    returned = json['returned'];
    failed = json['failed'];
    totalPrice = json['total_price'];
    pendingPrice = json['pending_price'];
    deliveredPrice = json['delivered_price'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['out_for_delivery'] = this.outForDelivery;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['returned'] = this.returned;
    data['failed'] = this.failed;
    data['total_price'] = this.totalPrice;
    data['pending_price'] = this.pendingPrice;
    data['delivered_price'] = this.deliveredPrice;
    data['wallet'] = this.wallet;
    return data;
  }
}
