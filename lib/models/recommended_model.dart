class RecommendedModel {
  String id;
  String type;
  String posterPath;

  RecommendedModel(
      {required this.id, required this.type, required this.posterPath});

  factory RecommendedModel.fromJson(Map<String, dynamic> json) {
    return RecommendedModel(
        id: json['_id'], type: json['type'], posterPath: json['posterPath']);
  }
}
