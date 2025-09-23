class ReportModel {
  final String problem;
  final String? userId;

  ReportModel({required this.problem, this.userId});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      problem: json['problem'] as String? ?? '',
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'problem': problem, 'userId': userId};
  }
}
