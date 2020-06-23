class HistoryModel {
  String expression;
  String notes;
  String image;

  HistoryModel({this.expression, this.notes, this.image});

   HistoryModel.map(Map<String, dynamic> obj) {
     this.expression = obj['username'];
     this.notes = obj['password'];
     this.image = obj['id'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["expression"] = expression;


    if (notes != null || image != null) {
      map["notes"] = notes;
      map["image"] = image;
    }else{
      map["notes"] = 'No notes yet';
      map["image"] = 'null';
    }
    return map;
  }

  HistoryModel.fromMap(Map<String, dynamic> map) {
    this.expression = map["expression"];
    this.notes = map["notes"];
    this.image = map["image"];
  }
}
