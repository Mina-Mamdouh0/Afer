class Photo {
  String? linkPhoto;
  String? description;
  bool? isPaid;
  String? point;
  String? id;
  Photo(
      {this.linkPhoto,
        this.description,
         this.isPaid,
         this.point,
        this.id,
      });
  Photo.fromJson( json)
  {
    linkPhoto = json['link'];
    description = json['description'];
    isPaid = json['isPaid']??false;
    point = json['point']??"0";
    id = json['id'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkPhoto,
      'description': description,
      'isPaid': isPaid,
      'point': point,
      'id': id,
    };
  }
}
