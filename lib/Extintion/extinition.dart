extension ispassword on String {
  bool get isPassword {
    if (this.length >= 8&&this.contains(RegExp(r'[A-Z]'))&&this.contains(RegExp(r'[a-z]'))&&this.contains(RegExp(r'[0-9]'))) {
      return false;
    }
  else return true;

  }
}
extension isemail on String {
  bool get isEmail {
    if (this.contains(RegExp(r'@'))&&this.contains(RegExp(r'\.'))) {
      return false;
    }
  else return true;

  }
}
extension isphone on String {
  bool get isPhoneNumber {
    if (this.length == 11&&this.contains(RegExp(r'[0-9]'))&&this.startsWith('01')) {
      return false;
    }
  else return true;

  }
}