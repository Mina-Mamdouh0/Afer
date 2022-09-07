class Pdf {
  String? linkPdf;
  String? description;

  Pdf(
      {this.linkPdf,
        this.description,
      });
  Pdf.fromJson(Map<String, dynamic> json)
  {
    linkPdf = json['link'];
    description = json['description'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkPdf,
      'description': description,
    };
  }
}
