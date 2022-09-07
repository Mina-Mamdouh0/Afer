class Photo {
  String? linkPhoto;
  String? description;

  Photo(
      {this.linkPhoto,
        this.description,
      });
  Photo.fromJson(Map<String, dynamic> json)
  {
    linkPhoto = json['link'];
    description = json['description'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkPhoto,
      'description': description,
    };
  }
}
