abstract class BaseQuestionEntity {
  int get index;
  String? get title;
  String? get scenario;
  String get questionText;
  List<String>? get images;
  List<String> get options;
  String? get explanation;
  int get marks;
  int get correctIndex;
  Object get type;
}
