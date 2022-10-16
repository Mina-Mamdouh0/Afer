import 'package:afer/model/Subject.dart';

extension ispassword on String {
  bool get isPassword {
    if (length >= 8 ) {
      return false;
    } else {
      return true;
    }
  }
}

extension isemail on String {
  bool get isEmail {
    if (contains(RegExp(r'@')) && contains(RegExp(r'\.'))) {
      return false;
    } else {
      return true;
    }
  }
}

extension isphone on String {
  bool get isPhoneNumber {
    if (length == 11 && contains(RegExp(r'[0-9]')) && startsWith('01')) {
      return false;
    } else {
      return true;
    }
  }
}

extension IsEqutaple on Subject {
  isEqutaple(Subject subject) {
    if (subject.id == id && subject.name == name && subject.academicYear == academicYear&&subject.teacherName==teacherName&&urlPhotoTeacher==urlPhotoTeacher) {
      return true;
    } else {
      return false;
    }
  }
}
