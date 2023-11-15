// * Using Regex methods and Dart extension methods

extension Redex on String {
  
  bool get isValidEmail {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(this);
  }

  bool get isValidName{
    RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    RegExp phoneRegex = RegExp(r'^(\+\d{1,3}\s?)?[\d\s-]{10}$');
    return phoneRegex.hasMatch(this);
  }

  bool get isValidAddress{
    RegExp addressRegex = RegExp(r'^\d*\s*(?:[A-Za-z]+\s*\d*|[A-Za-z]+)$');
    return addressRegex.hasMatch(this);
  }
}