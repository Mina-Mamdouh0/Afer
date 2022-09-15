class Video {
  String? linkVideo;
  String? description;
  bool? isPaid;
  String? point;
  String? id;
  Video(
      {this.linkVideo,
        this.description,
         this.isPaid,
         this.point,
        this.id,
      });
  Video.fromJson( json)
  {
    linkVideo = json['link'];
    description = json['description'];
    isPaid = json['isPaid']??false;
    point = json['point']??"0";
    id = json['id'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkVideo,
      'description': description,
      'isPaid': isPaid,
      'point': point,
      'id': id,
    };
  }
}
