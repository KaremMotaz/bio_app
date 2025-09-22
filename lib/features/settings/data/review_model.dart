class ReviewModel {
  final String content;
  final double rating;
  final String? userId;

  ReviewModel({
    required this.content,
    required this.rating,
    this.userId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      content: json['content'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'rating': rating, 'userId': userId};
  }
}
