class Subject {
  String? name;
  String? id;
  String? teacherName;
  String? urlPhotoTeacher;
  String? academicYear;

  Subject({
    this.name,
    this.id,
    this.teacherName,
    this.urlPhotoTeacher,
    this.academicYear,
  });
  Subject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    teacherName = json['teacherName'];
    urlPhotoTeacher = json['urlPhotoTeacher'];
    academicYear = json['AcademicYear'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'teacherName': teacherName,
      'urlPhotoTeacher': urlPhotoTeacher,
      "AcademicYear": academicYear,
    };
  }
}
