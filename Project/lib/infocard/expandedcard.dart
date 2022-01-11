import 'package:flutter/material.dart';
import 'package:project_carousel/item.dart';
import 'infocard.dart';

// ignore: must_be_immutable
class ExpandedCardWidget extends StatefulWidget {
  ExpandedCardWidget({
    Key? key,
    required this.items,
    required this.item_val,
    this.height = 330,
    this.width = 300,
    // required this.mainCategory,
    // required this.secondCategory
  }) : super(key: key);

  List<Item> items;
  int item_val;
  double height;
  double width;
  // String mainCategory;
  // String secondCategory;

  @override
  _ExpandedCardWidgetState createState() => _ExpandedCardWidgetState();
}

class _ExpandedCardWidgetState extends State<ExpandedCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
          child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (InfoCardWidget.expanded == false) {
              InfoCardWidget.expanded = true;
            } else if (InfoCardWidget.expanded == true) {
              InfoCardWidget.expanded = false;
            }
          });
          print(InfoCardWidget.expanded);
        },
        child: SizedBox(
            width: widget.width * 3.5,
            height: widget.height * 3.5,
            child: AspectRatio(
                aspectRatio: 5 / 6,
                child: Card(
                    color: widget.items[widget.item_val].backgroundColor ?? Color(0xfffc9c9c9),
                    elevation: 2,
                    child: Padding(
                        padding: EdgeInsets.all(9),
                        child: Column(children: <Widget>[
                          Flexible(
                              flex: 5,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Image.asset(
                                      widget.items[widget.item_val].image))),
                          SizedBox(height: 10),
                          Flexible(
                              flex: 1,
                              child: Text(widget.items[widget.item_val].name,
                                  style: TextStyle(color: widget.items[widget.item_val].textColor ?? Colors.white, fontSize: 20))),
                          SizedBox(height: 10),
                          Flexible(
                              flex: 1,
                              child: Text(
                                  widget.items[widget.item_val].category,
                                  style: TextStyle(color: widget.items[widget.item_val].textColor ?? Colors.white, fontSize: 20))),
                          SizedBox(height: 10),
                          Flexible(
                              flex: 1,
                              child: Text(
                                  widget.items[widget.item_val].extendedInfo1,
                                  style: TextStyle(color: widget.items[widget.item_val].textColor ?? Colors.white, fontSize: 20))),
                        ]))))),
        // This trailing comma makes auto-formatting nicer for build methods.
      )),
    ); //or any other widget bu
  }
}

// InkWell(
//         // onTap: () {
//         //   Navigator.pop(context);
//         //   setState(() {
//         //     if (widget.expanded == false) {
//         //       widget.expanded = true;
//         //     } else if (widget.expanded == true) {
//         //       widget.expanded = false;
//         //     }
//         //   });
//         // },
//         child: 