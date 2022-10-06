class Notes {
  String? uid;
  String ?notes;
  String ?date;

  Notes({ this.uid,  this.notes,  this.date});
   Notes.fromJson(json){
    uid=json["uid"];
    notes=json["notes"];
    date=json["data"];
   }
 Map<String,dynamic> toMap(){
     return {
       "uid":uid,
       "notes":notes,
       "data":date
  };
}
}