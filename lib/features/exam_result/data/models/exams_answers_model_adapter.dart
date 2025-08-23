import 'package:hive/hive.dart';

class ExamsAnswersModel {
  final Map<String, int> answers;
  final DateTime timestamp; 
  final String id;

  ExamsAnswersModel({
    required this.answers,
    required this.timestamp,
    required this.id,
  });
}

class ExamsAnswersModelAdapter extends TypeAdapter<ExamsAnswersModel> {
  @override
  final int typeId = 8; 

  @override
  ExamsAnswersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ExamsAnswersModel(
      answers: (fields[0] as Map).cast<String, int>(),
      timestamp: fields[1] as DateTime,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExamsAnswersModel obj) {
    writer
      ..writeByte(3) 
      ..writeByte(0)
      ..write(obj.answers)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.id);
  }
}
