import 'package:flutter/material.dart';

class Item {
  Item({
    required this.name,
    required this.compareValue,
    this.image = '../assets/images/movie_image.png',
    required this.category,
    this.extendedInfo1 = 'MORE INFO',
    this.extendedInfo2 = '',
    this.backgroundColor,
    this.textColor,
  });

  String image;
  String name;
  double compareValue;
  String category;
  Color? backgroundColor;
  Color? textColor;
  String extendedInfo1;
  String extendedInfo2;
}
