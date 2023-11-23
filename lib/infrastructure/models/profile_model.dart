class ProfileModel {
    String? uidUser;
    String? name;
    String? surnames;
    String? image;
    int? phoneNumber;
    DateTime? birthdayDate;
    String? gender;

    ProfileModel({
        this.uidUser,
        this.name,
        this.surnames,
        this.image,
        this.phoneNumber,
        this.birthdayDate,
        this.gender,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        uidUser: json["uid_user"],
        name: json["name"],
        surnames: json["surnames"],
        image: json["image"],
        phoneNumber: json["phone_number"],
        birthdayDate: json["birthday_date"] == null ? null : DateTime.parse(json["birthday_date"]),
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "uid_user": uidUser,
        "name": name,
        "surnames": surnames,
        "image": image,
        "phone_number": phoneNumber,
        "birthday_date": birthdayDate?.toIso8601String(),
        "gender": gender,
    };
}
