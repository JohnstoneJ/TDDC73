import 'package:flutter/material.dart';
import 'package:project_carousel/item.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class MinatureCardWidget extends StatefulWidget {
  MinatureCardWidget({
    Key? key,
    required this.items,
    required this.item_val,
    this.height = 140,
    this.width = 120,
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
  _MinatureCardWidgetState createState() => _MinatureCardWidgetState();
}

class _MinatureCardWidgetState extends State<MinatureCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AspectRatio(
          aspectRatio: 5 / 6,
          child: Card(
              color: widget.items[widget.item_val].backgroundColor ?? Color(0xfffc9c9c9),
              elevation: 2,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(children: <Widget>[
                    Expanded(
                    flex:4,
                        child: SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                                widget.items[widget.item_val].image))),
                    Expanded( child:Container(
                      width: double.infinity,
                        child: Center(child: AutoSizeText(widget.items[widget.item_val].name,
                            style: TextStyle(color: widget.items[widget.item_val].textColor ?? Colors.white,  fontSize: 25), minFontSize: 6, stepGranularity: 1, wrapWords: false))))
                  ])))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
