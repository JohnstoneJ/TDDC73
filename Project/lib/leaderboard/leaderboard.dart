// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:project_carousel/item.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class LeaderBoardWidget extends StatefulWidget {
  static const Color _titleColor = Color(0xfff333333);
  LeaderBoardWidget(
      {Key? key,
      required this.itemList,
      this.categoryList,
      this.height = 300,
      this.width = 500,
      this.maxRows = 10,
      this.textColor,
        this.backgroundColor,
      this.color,
      this.titleColor,
      this.title = "Leaderboard"})
      : super(key: key);

  List<Item> itemList;
  List<String>? categoryList;
  double height;
  double width;
  Color ? textColor;
  Color ? color;
  Color ? backgroundColor;
  Color ? titleColor;
  String title;
  int maxRows;

  @override
  _LeaderBoardWidgetState createState() => _LeaderBoardWidgetState();
}

List<Item> sortList(String category, List<Item> list) {
  if (category == "Top") {
    list.sort((b, a) => a.compareValue.compareTo(b.compareValue));
  } else {
    list = list.where((f) => f.category == category).toList();
    list.sort((b, a) => a.compareValue.compareTo(b.compareValue));
  }
  return list;
}

Widget leaderboardObject(
    int index, double score, Item item, Color ? color, Color ? textColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: color ?? Color(0xfff2c2c2c),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: FittedBox(
                child: Text(
                  '$index',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: textColor ?? Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: AutoSizeText(
                  item.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: textColor ?? Colors.white),
                  minFontSize: 6,
                  stepGranularity: 2.0,
                  wrapWords: false,
                  maxLines: 4,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xfff5c517),
                    child: FittedBox(
                      child: Text(
                        '$score',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget leaderBoard(String category, List<Item> list, Color ? color,
    Color ? textColor, int maxRows) {
  list = sortList(category, list);
  int count = list.length;
  if (count > maxRows) {
    count = maxRows;
  }

  return Expanded(
    child: Column(
      children: <Widget>[
        Text(
          category,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
        if (count == 0)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text("No items found in this category"),
          ),
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: count,
            itemBuilder: (BuildContext context, int i) {
              Item item = list[i];
              int index = i + 1;
              double score = item.compareValue;
              return leaderboardObject(index, score, item, color, textColor);
            },
          ),
        ),
      ],
    ),
  );
}

class _LeaderBoardWidgetState extends State<LeaderBoardWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.categoryList == null) {
      widget.categoryList = ["Top"];
    } else {
      widget.categoryList!.insert(0, "Top");
    }
    List<Widget> leaderBoards = [];

    for (int i = 0; i < widget.categoryList!.length; i++) {
      leaderBoards.add(leaderBoard(widget.categoryList![i], widget.itemList,
          widget.color, widget.textColor, widget.maxRows));
    }
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Color(0xfffc9c9c9),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: widget.titleColor ?? Color(0xfff333333),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                children: <Widget>[for (var item in leaderBoards) item],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
