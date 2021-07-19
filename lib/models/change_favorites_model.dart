class ChangeFavoritesModel{

  bool statues;
  String message;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    statues = json['statues'];
    message = json['message'];
  }
}