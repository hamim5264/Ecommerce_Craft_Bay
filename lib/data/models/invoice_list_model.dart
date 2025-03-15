class InvoiceListModel {
  int? id;
  String? total;
  String? vat;
  String? payable;
  String? cusDetails;
  String? shipDetails;
  String? tranId;
  String? valId;
  String? deliveryStatus;
  String? paymentStatus;
  int? userId;
  String? createdAt;
  String? updatedAt;

  InvoiceListModel({
    this.id,
    this.total,
    this.vat,
    this.payable,
    this.cusDetails,
    this.shipDetails,
    this.tranId,
    this.valId,
    this.deliveryStatus,
    this.paymentStatus,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListModel(
      id: json['id'],
      total: json['total']?.toString(),
      vat: json['vat']?.toString(),
      payable: json['payable']?.toString(),
      cusDetails: json['cus_details'],
      shipDetails: json['ship_details'],
      tranId: json['tran_id'],
      valId: json['val_id'],
      deliveryStatus: json['delivery_status'],
      paymentStatus: json['payment_status'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'vat': vat,
      'payable': payable,
      'cus_details': cusDetails,
      'ship_details': shipDetails,
      'tran_id': tranId,
      'val_id': valId,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
