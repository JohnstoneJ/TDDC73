import 'package:flutter/material.dart';

class Item {
  Item(
      {required this.name,
        required this.compareValue,
        this.image = '../assets/images/movie_image.png',
        required this.category,
        this.extendedInfo1 = 'MORE INFOr',
        this.extendedInfo2 = '',
        this.backgroundColor,
        this.textColor,
      });

  String image; //Ändras sedan till någon annan typ
  String name;
  double compareValue;
  String category;
  Color ? backgroundColor;
  Color ? textColor;
  String extendedInfo1;
  String extendedInfo2;
}