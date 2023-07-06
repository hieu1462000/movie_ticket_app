class SnackModel {
  String id;
  String title;
  int price;
  String description;
  String posterPath;

  SnackModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.posterPath});

  factory SnackModel.fromJson(Map<String, dynamic> json) {
    return SnackModel(
        id: json['_id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        posterPath: json['posterPath']);
  }
}
