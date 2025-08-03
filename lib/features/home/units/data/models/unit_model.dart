import 'package:bio_app/features/home/units/domain/unit_entity.dart';

class UnitModel extends UnitEntity {
  UnitModel({
    required super.id,
    required super.number,
    required super.title,
    required super.image,
    required super.colorList,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int,
      number: json['number'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      colorList: List<int>.from(json['colorList']),
    );
  }
}
