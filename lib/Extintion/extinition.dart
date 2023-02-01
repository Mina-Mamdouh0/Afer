import 'package:afer/model/subject.dart';

extension Password on String {
  bool get isPassword {
    if (length >= 8 ) {
      return false;
    } else {
      return true;
    }
  }
}

extension Email on String {
  bool get isEmail {
    if (contains(RegExp(r'@')) && contains(RegExp(r'\.'))) {
      return false;
    } else {
      return true;
    }
  }
}

extension Phone on String {
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
