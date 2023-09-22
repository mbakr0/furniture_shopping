

import 'package:flutter/material.dart';
import '../theme/color_schemes.g.dart';

class MainIconModel{
  String name;
  String path;
  Color color;
  Color fillColor;
  Color textColor;

  MainIconModel({
    this.textColor = const Color(0x60999999),
    this.fillColor = const Color(0x60999999),
    this.color = tertiaryContainer,
    required this.name,
    required this.path
});

  static List<MainIconModel> getMainIconModel(){
    List<MainIconModel> mainIconModels = [];
    mainIconModels.add(
      MainIconModel(name: "Popular", path: "assets/icons/star.png")
    );
    mainIconModels.add(
    MainIconModel(name: "Chair", path: "assets/icons/chair.png")
    );
    mainIconModels.add(
    MainIconModel(name: "Table", path: "assets/icons/table.png")
    );
    mainIconModels.add(
    MainIconModel(name: "Sofa", path: "assets/icons/sofa.png")
    );
    mainIconModels.add(
    MainIconModel(name: "Bed", path: "assets/icons/bed.png")
    );
    mainIconModels.add(
    MainIconModel(name: "Lamp", path: "assets/icons/lamb.png")
    );
    return mainIconModels;
  }


}