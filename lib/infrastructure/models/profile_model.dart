class ProfileModel {
    String? idUser;
    String? name;
    String? surnames;
    int? phoneNumber;
    DateTime? birthdayDate;
    String? gender;

    ProfileModel({
        this.idUser,
        this.name,
        this.surnames,
        this.phoneNumber,
        this.birthdayDate,
        this.gender,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        idUser: json["iduser"],
        name: json["name"],
        surnames: json["surnames"],
        phoneNumber: json["phone_number"],
        birthdayDate: json["birthday_date"] == null ? null : DateTime.parse(json["birthday_date"]),
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "iduser": idUser,
        "name": name,
        "surnames": surnames,
        "phone_number": phoneNumber,
        "birthday_date": birthdayDate?.toIso8601String(),
        "gender": gender,
    };
}
