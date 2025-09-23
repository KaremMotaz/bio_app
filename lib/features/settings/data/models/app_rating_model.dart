class AppRatingModel {
  final double? rating;
  final String? userId;

  AppRatingModel({this.rating, this.userId});

  factory AppRatingModel.fromJson(Map<String, dynamic> json) {
    return AppRatingModel(
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rating': rating ?? 0.0, 'userId': userId};
  }
}
