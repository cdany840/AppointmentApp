// * Using Regex methods and Dart extension methods

extension Redex on String {
  
  bool get isValidEmail {
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  bool get isValidName{
    RegExp nameRegex = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    return nameRegex.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp = RegExp(r'^(?=.*[a-zA-Z0-9])[a-zA-Z0-9]{9,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    RegExp phoneRegex = RegExp(r'^(\+\d{1,3}\s?)?[\d\s-]{10}$');
    return phoneRegex.hasMatch(this);
  }

  bool get isValidAddress{    
    RegExp addressRegex = RegExp(r'^(?:\d+\s)?[A-Za-z0-9\sáéíóúüÁÉÍÓÚÜÑñ.,-]+ \d+[A-Za-z]?$');
    return addressRegex.hasMatch(this);
  }

  bool get isValidPrice{
    RegExp priceRegex = RegExp(r'^\d+([.,]\d{1,2})?$');
    return priceRegex.hasMatch(this);
  }

  bool get isValidHour{
    RegExp priceRegex = RegExp(r'^(0[0-9]|09):([1-5][0-9])$');
    return priceRegex.hasMatch(this);
  }

  bool get isValidApartment{
    RegExp apartmentRegex = RegExp(r'^[a-zA-Zá-úÁ-Ú0-9\- ]+$');
    return apartmentRegex.hasMatch(this);
  }
}