class OrderStatusModel {
  String customer;
  String orderdate;
  String handdate;
  String status;

  OrderStatusModel(this.customer, this.orderdate, this.handdate, this.status);

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    orderdate = json['orderdate'];
    handdate = json['handdate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['orderdate'] = this.orderdate;
    data['handdate'] = this.handdate;
    data['status'] = this.status;
    return data;
  }
}