import 'package:json_annotation/json_annotation.dart';
import '../../domain/unit_entity.dart';
part 'unit_model.g.dart';

@JsonSerializable()
class UnitModel extends UnitEntity {
  UnitModel({
    required super.id,
    required super.index,
    required super.title,
    required super.image,
    required super.colorIndex,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return _$UnitModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UnitModelToJson(this);
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
