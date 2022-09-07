class Subject{
  String? name;
  String? AcademicYear;
  String? Semester;
  bool? firstWeek;
  bool? secondWeek;
  bool? thirdWeek;
  bool? fourthWeek;
  bool? fiftyWeek;
  bool? sixWeek;
  Subject(
      {this.name,
      this.AcademicYear,
      this.Semester,
      this.firstWeek,
      this.secondWeek,
      this.thirdWeek,
      this.fourthWeek,
      this.fiftyWeek,
      this.sixWeek});
  Subject.fromJson(Map<String, dynamic> json){
    name = json['name'];
    AcademicYear = json['AcademicYear'];
    Semester = json['Semester'];
    firstWeek = json['first week'];
    secondWeek = json['second week'];
    thirdWeek = json['third week'];
    fourthWeek = json['fourth week'];
    fiftyWeek = json['fifty week'];
    sixWeek = json['six week'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'name': name,
      'AcademicYear': AcademicYear,
      'Semester': Semester,
      'first week': firstWeek??false,
      'second week': secondWeek??false,
      'third week': thirdWeek??false,
      'fourth week': fourthWeek??false,
      'fifty week': fiftyWeek??false,
      'six week': sixWeek??false
    };
  }
}