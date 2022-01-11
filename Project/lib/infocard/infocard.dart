import 'package:flutter/material.dart';
import 'package:project_carousel/item.dart';
import 'minaturecard.dart';
import 'expandedcard.dart';

// ignore: must_be_immutable
class InfoCardWidget extends StatefulWidget {

  InfoCardWidget({
    Key? key,
    required this.items,
    required this.item_val,
    this.height = 140,
    this.width = 120,
    this.textColor = Colors.white,

    // required this.mainCategory,
    // required this.secondCategory
  }) : super(key: key);
  List<Item> items;
  static bool expanded = false;
  int item_val;
  double height;
  double width;
  Color textColor;
  // String mainCategory;
  // String secondCategory;

  @override
  _InfoCardWidgetState createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<InfoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (InfoCardWidget.expanded == false) {
            InfoCardWidget.expanded = true;
          } else if (InfoCardWidget.expanded == true) {
            InfoCardWidget.expanded = false;
          }
        });
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, slideTransition, curvedAnimation) =>
                ExpandedCardWidget(
                  items: widget.items,
                  item_val: widget.item_val,
                  height: widget.height,
                  width: widget.width,
                )));
        print(InfoCardWidget.expanded);
      },
      child: MinatureCardWidget(
        items: widget.items,
        item_val: widget.item_val,
        height: widget.height,
        width: widget.width,
      ),
    );
  }

  // Widget isExpanded() {
  //   if (expanded == false) {
  //     return MinatureCardWidget(
  //       items: widget.items,
  //       // mainCategory: "Top movies",
  //       // secondCategory: "Top comedy",
  //     );
  //   }
  //   if (expanded == true) {
  //     return ExpandedCardWidget(
  //       items: widget.items,
  //     );
  //   } else {
  //     return Container(height: 0);
  //   }
  // }
}
