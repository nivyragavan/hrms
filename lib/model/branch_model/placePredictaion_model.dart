class PlacePredictionModel{
  String? placeId;
  String? mainText;
  String? secondaryText;
  PlacePredictionModel({this.placeId,this.mainText,this.secondaryText});

  PlacePredictionModel.fromJson(Map<String , dynamic> json){
    placeId = json["place_id"];
    mainText = json["structured_formatting"]["main_text"];
    secondaryText = json["structured_formatting"]["secondary_text"];
  }
}