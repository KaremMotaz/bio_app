import '../../domain/unit_entity.dart';

class UnitModel extends UnitEntity {
  UnitModel({
    required super.id,
    required super.index,
    required super.title,
    required super.image,
    required super.colorIndex,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      index: json['index'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: json['colorIndex'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'title': title,
      'image': image,
      'colorIndex': colorIndex,
    };
  }

  UnitEntity toEntity() => UnitEntity(
    index: index,
    title: title,
    image: image,
    colorIndex: colorIndex,
    id: id,
  );

  factory UnitModel.fromEntity(UnitEntity e) => UnitModel(
    index: e.index,
    title: e.title,
    image: e.image,
    colorIndex: e.colorIndex,
    id: e.id,
  );
}
