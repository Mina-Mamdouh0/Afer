class Pdf {
  String? linkPdf;
  String? description;
  bool ?isPaid;
  String? point;
  String? id;
  Pdf(
      {this.linkPdf,
        this.description,
         this.isPaid,
         this.point,
        this.id,
      });
  Pdf.fromJson( json)
  {
    linkPdf = json['link'];
    description = json['description'];
    isPaid = json['isPaid'];
    point = json['point'];
    id = json['id'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkPdf,
      'description': description,
      'isPaid': isPaid,
      'point': point,
      'id': id,
    };
  }
}
