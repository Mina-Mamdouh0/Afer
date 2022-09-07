class UserModule {
  String? firstName;
  String? secondName;
  int? phone;
  bool? premium;
  String? profileUrl;
  String? email;
  String? uid;
  String? pass;
  Map? FirstSubjects;
  Map? SecondSubjects;
  Map? thirdSubjects;
  Map? fourthSubjects;
  Map? fiftySubjects;
  Map? sixSubjects;
  Map? sevenSubjects;
  String? semester;
  UserModule(
      {
        this.firstName,
        this.secondName,
        this.email,
        this.uid,
        this.phone,
        this.premium,
        this.FirstSubjects,
        this.SecondSubjects,
        this.thirdSubjects,
        this.fourthSubjects,
        this.fiftySubjects,
        this.sixSubjects,
        this.profileUrl,
        this.pass,
        this.sevenSubjects,
        this.semester,

      });
  UserModule.fromJson(Map<String, dynamic> json)
  {
    firstName = json['firstName'];
    secondName = json['secondName'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    premium = json['premium'];
    FirstSubjects = json['FirstSubjects'];
    SecondSubjects = json['SecondSubjects'];
    thirdSubjects = json['thirdSubjects'];
    fourthSubjects = json['fourthSubjects'];
    fiftySubjects = json['fiftySubjects'];
    sevenSubjects = json['sevenSubjects'];
    sixSubjects = json['sixSubjects'];
    profileUrl = json['profileUrl'];
    pass = json['password'];
    semester = json['semester'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'phone': phone,
      'uid': uid,
      'premium': premium,
      'FirstSubjects': FirstSubjects,
      'SecondSubjects': SecondSubjects,
      'thirdSubjects': thirdSubjects,
      'fourthSubjects': fourthSubjects,
      'fiftySubjects': fiftySubjects,
      'sixSubjects': sixSubjects,
      'profileUrl': profileUrl,
      'password': pass,
      'sevenSubjects': sevenSubjects,
      'semester': semester,
    };
  }
}
