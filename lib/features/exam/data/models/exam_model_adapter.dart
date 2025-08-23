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
      endTime: fields[4] as DateTime,
      passPercentage: fields[5] as double,
      isPublished: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExamModel obj) {
    writer
      ..writeByte(7) 
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.lesson)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.passPercentage)
      ..writeByte(6)
      ..write(obj.isPublished);
  }
}
