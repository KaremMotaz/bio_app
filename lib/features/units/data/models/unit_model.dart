import 'package:bio_app/features/units/domain/unit_entity.dart';

class UnitModel extends UnitEntity {
  UnitModel({
    required super.id,
    required super.title,
    required super.image,
    required super.colorIndex,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: json['colorIndex'] as int,
    );
  }
}

