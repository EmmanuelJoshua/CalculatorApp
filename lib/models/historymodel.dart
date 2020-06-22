class HistoryModel{
  String expression;
  String notes;
  String image;

  HistoryModel({this.expression, this.notes, this.image});

  factory HistoryModel.fromJson(Map<String, dynamic> json){
    return HistoryModel(
      expression: '',
      notes: '',
      image: ''
    );
  }

  Map<String, dynamic> toJson() => {
    'expression': expression,
    'notes': notes,
    'image': image
  };

}