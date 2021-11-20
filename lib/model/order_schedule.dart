class OrderSchedule {
  List<OrderScheduleData>? data;
  bool? success;

  OrderSchedule({this.data, this.success});

  OrderSchedule.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new OrderScheduleData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class OrderScheduleData {
  String? orderSchedule;
  int? id;

  OrderScheduleData({this.orderSchedule, this.id});

  OrderScheduleData.fromJson(Map<String, dynamic> json) {
    orderSchedule = json['order_schedule'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_schedule'] = this.orderSchedule;
    data['id'] = this.id;
    return data;
  }
}
