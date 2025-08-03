import '../../../../../core/theming/assets_data.dart';
import 'package:flutter/material.dart';

class UnitModel {
  final String number;
  final String title;
  final String image;
  final List<Color> colorList;

  UnitModel({
    required this.number,
    required this.title,
    required this.image,
    required this.colorList,
  });
  static final List<UnitModel> units = [
    UnitModel(
      number: "الأول",
      title: "التركيب والوظيفة في الكائنات الحية",
      image: AssetsData.brain,
      colorList: [const Color(0xffFF79A2), const Color(0xffFFC9D9)],
    ),
    UnitModel(
      number: "الثاني",
      title: "البيولوجيا الجزيئية",
      image: AssetsData.dna,
      colorList: [const Color(0xffDB65BE), const Color(0xffFFDAF9)],
    ),
    UnitModel(
      number: "الثالث",
      title: "البيئة والأحياء وعلوم الأرض",
      image: AssetsData.earth,
      colorList: [const Color(0xff96CD83), const Color(0xffE4F185)],
    ),
  ];
}
