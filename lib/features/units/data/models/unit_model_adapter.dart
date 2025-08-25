import 'package:hive/hive.dart';

import 'unit_model.dart';

class UnitModelAdapter extends TypeAdapter<UnitModel> {
  @override
  final int typeId = 1;

  @override
  UnitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return UnitModel(
      id: fields[0] as String,
      index: fields[1] as int,
      title: fields[2] as String,
      image: fields[3] as String,
      colorIndex: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UnitModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.colorIndex);
  }
}
