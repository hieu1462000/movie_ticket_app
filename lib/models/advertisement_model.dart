class AdvertisementModel {
  String id;
  String title;
  String description;
  String posterPath;

  AdvertisementModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.posterPath});

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        posterPath: json['posterPath']);
  }
}
