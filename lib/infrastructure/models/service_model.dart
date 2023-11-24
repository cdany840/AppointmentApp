class ServiceModel {
    String? uidBusiness;
    String? serviceName;
    String? serviceDescription;
    String? serviceDuration;
    String? image;
    double? servicePrice;

    ServiceModel({
        this.uidBusiness,
        this.serviceName,
        this.serviceDescription,
        this.serviceDuration,
        this.image,
        this.servicePrice,
    });

    factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        uidBusiness: json["uid_Business"],
        serviceName: json["service_name"],
        serviceDescription: json["service_Description"],
        serviceDuration: json["service_duration"],
        image: json["image"],
        servicePrice: json["service_price"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "uid_Business": uidBusiness,
        "service_name": serviceName,
        "service_Description": serviceDescription,
        "service_duration": serviceDuration,
        "image": image,
        "service_price": servicePrice,
    };
}
