class Restaurant {
  Restaurant({
    required this.shopId,
    required this.shopName,
    required this.shopDesc,
    required this.deliveryTime,
    required this.rate,
    required this.address,
    required this.lat,
    required this.lng,
    required this.logoUrl,
    required this.bannerUrl,
    required this.cityId,
    required this.foodId,
    required this.foodName,
    required this.foodDesc,
    required this.foodDetails,
    required this.imageUrl,
    required this.count,
    required this.foodDeliveryTime,
    required this.fromDate,
    required this.toDate,
    required this.price,
    required this.discount,
    required this.priceWithDiscount,
  });

  String shopId;
  String shopName;
  String shopDesc;
  String deliveryTime;
  String rate;
  String address;
  String lat;
  String lng;
  String logoUrl;
  String bannerUrl;
  String cityId;
  String foodId;
  String foodName;
  String foodDesc;
  String foodDetails;
  String imageUrl;
  String count;
  String foodDeliveryTime;
  DateTime fromDate;
  DateTime toDate;
  String price;
  String discount;
  String priceWithDiscount;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    shopId: json["shopId"],
    shopName: json["shopName"],
    shopDesc: json["shopDesc"],
    deliveryTime: json["deliveryTime"],
    rate: json["rate"],
    address: json["address"],
    lat: json["lat"],
    lng: json["lng"],
    logoUrl: json["logoUrl"],
    bannerUrl: json["bannerUrl"],
    cityId: json["cityId"],
    foodId: json["foodId"],
    foodName: json["foodName"],
    foodDesc: json["foodDesc"],
    foodDetails: json["foodDetails"],
    imageUrl: json["imageUrl"],
    count: json["count"],
    foodDeliveryTime: json["foodDeliveryTime"],
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    price: json["price"],
    discount: json["discount"],
    priceWithDiscount: json["priceWithDiscount"],
  );

  Map<String, dynamic> toJson() => {
    "shopId": shopId,
    "shopName": shopName,
    "shopDesc": shopDesc,
    "deliveryTime": deliveryTime,
    "rate": rate,
    "address": address,
    "lat": lat,
    "lng": lng,
    "logoUrl": logoUrl,
    "bannerUrl": bannerUrl,
    "cityId": cityId,
    "foodId": foodId,
    "foodName": foodName,
    "foodDesc": foodDesc,
    "foodDetails": foodDetails,
    "imageUrl":imageUrl,
    "count": count,
    "foodDeliveryTime": foodDeliveryTime,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
    "price": price,
    "discount": discount,
    "priceWithDiscount": priceWithDiscount,
  };
}