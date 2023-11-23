class BusinessModel {
  String? uidUser;
  String? businessName;
  String? brandName;
  String? businessAddress;
  String? apartmentOffice;
  int? businessPhone;
  String? businessEmail;
  String? businessType;
  String? location;
  String? image;

  BusinessModel({
    this.uidUser,
    this.businessName,
    this.brandName,
    this.businessAddress,
    this.apartmentOffice,
    this.businessPhone,
    this.businessEmail,
    this.businessType,
    this.location,
    this.image,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
      uidUser: json["uid_user"],
      businessName: json["business_name"],
      brandName: json["brand_name"],
      businessAddress: json["business_address"],
      apartmentOffice: json["apartment_office"],
      businessPhone: json["business_phone"],
      businessEmail: json["business_email"],
      businessType: json["business_type"],
      location: json["location"],
      image: json["image"],
  );

  Map<String, dynamic> toJson() => {
      "uid_user": uidUser,
      "business_name": businessName,
      "brand_name": brandName,
      "business_address": businessAddress,
      "apartment_office": apartmentOffice,
      "business_phone": businessPhone,
      "business_email": businessEmail,
      "business_type": businessType,
      "location": location,
      "image": image,
  };
}