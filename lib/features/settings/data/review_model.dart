class ReviewModel {
  final double rating;
  final String? userId;

  ReviewModel({required this.rating, this.userId});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rating': rating, 'userId': userId};
  }
}
