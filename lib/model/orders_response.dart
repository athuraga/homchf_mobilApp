// import 'package:homchf_restaurant_side/retrofit/api_client.dart';
// import 'package:homchf_restaurant_side/retrofit/api_header.dart';
// import 'package:homchf_restaurant_side/retrofit/base_model.dart';
// import 'package:homchf_restaurant_side/retrofit/server_error.dart';

// Future<BaseModel<OrdersResponse>> getOrders() async {
//   OrdersResponse response;
//   try {
//     response = await ApiClient(ApiHeader().dioData()).orders();
//   } catch (error, stacktrace) {
//     print("Exception occur: $error stackTrace: $stacktrace");
//     return BaseModel()..setException(ServerError.withError(error: error));
//   }
//   return BaseModel()..data = response;
// }

class OrdersResponse {
  bool? success;
  List<OrdersResponseData>? data;

  OrdersResponse({this.success, this.data});

  OrdersResponse.fromJson(dynamic json) {
    success = json["success"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(OrdersResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrdersResponseData {
  int? id;
  String? orderId;
  int? vendorId;
  int? userId;
  dynamic deliveryPersonId;
  String? date;
  String? time;
  String? paymentType;
  dynamic paymentToken;
  String? paymentStatus;
  int? amount;
  int? adminCommission;
  int? vendorAmount;
  String? deliveryType;
  dynamic promoCodeId;
  int? promoCodePrice;
  dynamic vendorDiscountId;
  int? vendorDiscountPrice;
  dynamic addressId;
  dynamic deliveryCharge;
  String? orderStatus;
  String? orderSchedule;

  dynamic cancelBy;
  dynamic cancelReason;
  String? tax;
  String? orderStartTime;
  String? orderEndTime;
  String? userName;
  String? userPhone;
  String? userAddress;
  DeliveryPerson? deliveryPerson;
  String? vendorAddress;
  List<OrderItems>? orderItems;

  OrdersResponseData(
      {this.id,
      this.orderId,
      this.vendorId,
      this.userId,
      this.deliveryPersonId,
      this.date,
      this.time,
      this.paymentType,
      this.paymentToken,
      this.paymentStatus,
      this.amount,
      this.adminCommission,
      this.vendorAmount,
      this.deliveryType,
      this.promoCodeId,
      this.promoCodePrice,
      this.vendorDiscountId,
      this.vendorDiscountPrice,
      this.addressId,
      this.deliveryCharge,
      this.orderStatus,
      this.orderSchedule,
      this.cancelBy,
      this.cancelReason,
      this.tax,
      this.orderStartTime,
      this.orderEndTime,
      this.userName,
      this.userAddress,
      this.deliveryPerson,
      this.userPhone,
      this.vendorAddress,
      this.orderItems});

  OrdersResponseData.fromJson(dynamic json) {
    id = json["id"];
    orderId = json["order_id"];
    vendorId = json["vendor_id"];
    userId = json["user_id"];
    deliveryPersonId = json["delivery_person_id"];
    date = json["date"];
    time = json["time"];
    paymentType = json["payment_type"];
    paymentToken = json["payment_token"];
    paymentStatus = json["payment_status"];
    amount = json["amount"];
    adminCommission = json["admin_commission"];
    vendorAmount = json["vendor_amount"];
    deliveryType = json["delivery_type"];
    promoCodeId = json["promocode_id"];
    promoCodePrice = json["promocode_price"];
    vendorDiscountId = json["vendor_discount_id"];
    vendorDiscountPrice = json["vendor_discount_price"];
    addressId = json["address_id"];
    deliveryCharge = json["delivery_charge"];
    orderStatus = json["order_status"];
    orderSchedule = json["order_schedule"];

    cancelBy = json["cancel_by"];
    cancelReason = json["cancel_reason"];
    tax = json["tax"];
    orderStartTime = json["order_start_time"];
    orderEndTime = json["order_end_time"];
    userName = json["user_name"];
    userPhone = json["user_phone"];
    vendorAddress = json["vendorAddress"];
    userAddress = json["userAddress"];
    deliveryPerson = json["delivery_person"] != null
        ? DeliveryPerson.fromJson(json["delivery_person"])
        : null;
    if (json["orderItems"] != null) {
      orderItems = [];
      json["orderItems"].forEach((v) {
        orderItems?.add(OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["order_id"] = orderId;
    map["vendor_id"] = vendorId;
    map["user_id"] = userId;
    map["delivery_person_id"] = deliveryPersonId;
    map["date"] = date;
    map["time"] = time;
    map["payment_type"] = paymentType;
    map["payment_token"] = paymentToken;
    map["payment_status"] = paymentStatus;
    map["amount"] = amount;
    map["admin_commission"] = adminCommission;
    map["vendor_amount"] = vendorAmount;
    map["delivery_type"] = deliveryType;
    map["promocode_id"] = promoCodeId;
    map["promocode_price"] = promoCodePrice;
    map["vendor_discount_id"] = vendorDiscountId;
    map["vendor_discount_price"] = vendorDiscountPrice;
    map["address_id"] = addressId;
    map["delivery_charge"] = deliveryCharge;
    map["order_status"] = orderStatus;
    map["order_schedule"] = orderSchedule;

    map["cancel_by"] = cancelBy;
    map["cancel_reason"] = cancelReason;
    map["tax"] = tax;
    map["order_start_time"] = orderStartTime;
    map["order_end_time"] = orderEndTime;
    map["user_name"] = userName;
    map["user_phone"] = userPhone;
    map["vendorAddress"] = vendorAddress;
    map["userAddress"] = userAddress;
    if (deliveryPerson != null) {
      map["delivery_person"] = deliveryPerson?.toJson();
    }
    if (orderItems != null) {
      map["orderItems"] = orderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderItems {
  int? id;
  int? orderId;
  int? item;
  int? price;
  int? qty;
  dynamic customization;
  String? createdAt;
  String? updatedAt;
  String? itemName;

  OrderItems(
      {this.id,
      this.orderId,
      this.item,
      this.price,
      this.qty,
      this.customization,
      this.createdAt,
      this.updatedAt,
      this.itemName});

  OrderItems.fromJson(dynamic json) {
    id = json["id"];
    orderId = json["order_id"];
    item = json["item"];
    price = json["price"];
    qty = json["qty"];
    customization = json["custimization"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    itemName = json["itemName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["order_id"] = orderId;
    map["item"] = item;
    map["price"] = price;
    map["qty"] = qty;
    map["custimization"] = customization;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["itemName"] = itemName;
    return map;
  }
}

// class Custimization {
//   String? mainMenu;
//   OrderResponseData? data;

//   Custimization({this.mainMenu, this.data});

//   Custimization.fromJson(Map<String, dynamic> json) {
//     mainMenu = json['main_menu'];
//     data = json['data'] != null
//         ? new OrderHistoryData.fromJson(json['data'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['main_menu'] = this.mainMenu;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

class DeliveryPerson {
  String? firstName;
  String? lastName;
  String? contact;

  DeliveryPerson({this.firstName, this.lastName, this.contact});

  DeliveryPerson.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    contact = json["contact"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["contact"] = contact;
    return map;
  }
}

class Vendor {
  int? id;
  int? userId;
  String? name;
  String? vendorLogo;
  String? emailId;
  String? image;
  String? password;
  String? contact;
  String? cuisineId;
  String? address;
  String? lat;
  String? lang;
  String? mapAddress;
  String? minOrderAmount;
  String? forTwoPerson;
  String? avgDeliveryTime;
  String? licenseNumber;
  String? adminComissionType;
  String? adminComissionValue;
  String? vendorType;
  String? timeSlot;
  String? tax;
  Null deliveryTypeTimeSlot;
  int? isExplorer;
  int? isTop;
  int? vendorOwnDriver;
  Null paymentOption;
  int? status;
  String? vendorLanguage;
  String? createdAt;
  String? updatedAt;
  List<Cuisine>? cuisine;
  double? rate;
  int? review;

  Vendor(
      {this.id,
      this.userId,
      this.name,
      this.vendorLogo,
      this.emailId,
      this.image,
      this.password,
      this.contact,
      this.cuisineId,
      this.address,
      this.lat,
      this.lang,
      this.mapAddress,
      this.minOrderAmount,
      this.forTwoPerson,
      this.avgDeliveryTime,
      this.licenseNumber,
      this.adminComissionType,
      this.adminComissionValue,
      this.vendorType,
      this.timeSlot,
      this.tax,
      this.deliveryTypeTimeSlot,
      this.isExplorer,
      this.isTop,
      this.vendorOwnDriver,
      this.paymentOption,
      this.status,
      this.vendorLanguage,
      this.createdAt,
      this.updatedAt,
      this.cuisine,
      this.rate,
      this.review});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    vendorLogo = json['vendor_logo'];
    emailId = json['email_id'];
    image = json['image'];
    password = json['password'];
    contact = json['contact'];
    cuisineId = json['cuisine_id'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    mapAddress = json['map_address'];
    minOrderAmount = json['min_order_amount'];
    forTwoPerson = json['for_two_person'];
    avgDeliveryTime = json['avg_delivery_time'];
    licenseNumber = json['license_number'];
    adminComissionType = json['admin_comission_type'];
    adminComissionValue = json['admin_comission_value'];
    vendorType = json['vendor_type'];
    timeSlot = json['time_slot'];
    tax = json['tax'];
    deliveryTypeTimeSlot = json['delivery_type_timeSlot'];
    isExplorer = json['isExplorer'];
    isTop = json['isTop'];
    vendorOwnDriver = json['vendor_own_driver'];
    paymentOption = json['payment_option'];
    status = json['status'];
    vendorLanguage = json['vendor_language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['cuisine'] != null) {
      cuisine = [];
      json['cuisine'].forEach((v) {
        cuisine!.add(new Cuisine.fromJson(v));
      });
    }
    rate = json['rate'].toDouble();
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['vendor_logo'] = this.vendorLogo;
    data['email_id'] = this.emailId;
    data['image'] = this.image;
    data['password'] = this.password;
    data['contact'] = this.contact;
    data['cuisine_id'] = this.cuisineId;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['map_address'] = this.mapAddress;
    data['min_order_amount'] = this.minOrderAmount;
    data['for_two_person'] = this.forTwoPerson;
    data['avg_delivery_time'] = this.avgDeliveryTime;
    data['license_number'] = this.licenseNumber;
    data['admin_comission_type'] = this.adminComissionType;
    data['admin_comission_value'] = this.adminComissionValue;
    data['vendor_type'] = this.vendorType;
    data['time_slot'] = this.timeSlot;
    data['tax'] = this.tax;
    data['delivery_type_timeSlot'] = this.deliveryTypeTimeSlot;
    data['isExplorer'] = this.isExplorer;
    data['isTop'] = this.isTop;
    data['vendor_own_driver'] = this.vendorOwnDriver;
    data['payment_option'] = this.paymentOption;
    data['status'] = this.status;
    data['vendor_language'] = this.vendorLanguage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cuisine != null) {
      data['cuisine'] = this.cuisine!.map((v) => v.toJson()).toList();
    }
    data['rate'] = this.rate;
    data['review'] = this.review;
    return data;
  }
}

class Cuisine {
  String? name;
  String? image;

  Cuisine({this.name, this.image});

  Cuisine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Data {
  String? name;
  String? price;

  Data({this.name, this.price});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class UserAddress {
  String? lat;
  String? lang;
  String? address;

  UserAddress({this.lat, this.lang, this.address});

  UserAddress.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lang = json['lang'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['address'] = this.address;
    return data;
  }
}
