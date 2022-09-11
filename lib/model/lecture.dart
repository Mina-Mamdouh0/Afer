class Lecture{
  String ?lectureName;
  String ?lectureDescription;
 Lecture({this.lectureName, this.lectureDescription});
 Lecture.fromJson(Map<String, dynamic> json) {
    lectureName = json['Name'];
    lectureDescription = json['Description'];
  }
  Map<String, dynamic> toJson() {
   return {
      'Name': lectureName,
      'Description': lectureDescription,
    };

  }
}