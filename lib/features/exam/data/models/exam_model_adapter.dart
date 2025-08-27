import 'package:hive/hive.dart';

import 'exam_model.dart';

class ExamModelAdapter extends TypeAdapter<ExamModel> {
  @override
  final int typeId = 5; 

  @override
  ExamModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ExamModel(
      id: fields[0] as String,
      title: fields[1] as String,
      unit: fields[2] as String,
      lesson: fields[3] as String,
      startTime: fields[4] as DateTime,
      endTime: fields[5] as DateTime,
      passPercentage: fields[6] as double,
      isPublished: fields[7] as bool,
      isResultPublished: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExamModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.lesson)      
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.passPercentage)
      ..writeByte(7)
      ..write(obj.isPublished)
      ..writeByte(8)
      ..write(obj.isResultPublished);
  }
}
