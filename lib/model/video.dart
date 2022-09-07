class Video {
  String? linkVideo;
  String? description;

  Video(
      {this.linkVideo,
        this.description,
      });
  Video.fromJson(Map<String, dynamic> json)
  {
    linkVideo = json['link'];
    description = json['description'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkVideo,
      'description': description,
    };
  }
}
