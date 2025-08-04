
class UnitEntity {
  final int id;
  final String title;
  final String image;
  final int colorIndex;

  UnitEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.colorIndex,
  });

  String get displayNumber => _getDisplayNumberFromId(id);

  String _getDisplayNumberFromId(int id) {
    const numbers = [
      'الأول',
      'الثاني',
      'الثالث',
      'الرابع',
      'الخامس',
      'السادس',
      'السابع',
      'الثامن',
      'التاسع',
      'العاشر',
    ];
    return id >= 0 && id < numbers.length ? numbers[id] : 'غير معروف';
  }
}
