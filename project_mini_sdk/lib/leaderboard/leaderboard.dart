// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:project_carousel/item.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Custom Widget containing varied nr of leaderboards with different categories
// Uses the custom class Item in its lists
// Could be stateless since nothing changes during runtime
// ignore: must_be_immutable
class LeaderBoardWidget extends StatefulWidget {
  // Constructor
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
  Color? textColor;
  Color? color;
  Color? backgroundColor;
  Color? titleColor;
  String title;
  int maxRows;

  @override
  _LeaderBoardWidgetState createState() => _LeaderBoardWidgetState();
}

// Function to sort list of items based on their "comparevalue" and return sorted list
List<Item> sortList(String category, List<Item> list) {
  if (category == "Top") {
    list.sort((b, a) => a.compareValue.compareTo(b.compareValue));
  } else {
    list = list.where((f) => f.category == category).toList();
    list.sort((b, a) => a.compareValue.compareTo(b.compareValue));
  }
  return list;
}

// Object in the leaderboard widget, returns one separate row in the leaderboard
class LeaderBoardObject extends StatelessWidget {
  final int index;
  final double score;
  final Item item;
  final Color? color;
  final Color? textColor;

// Constructor
  LeaderBoardObject(
      this.index, this.score, this.item, this.color, this.textColor);
  Widget build(BuildContext context) {
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
                  child: Text('$index',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor ?? Colors.white),
                      textDirection: TextDirection.ltr),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: AutoSizeText(item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: textColor ?? Colors.white),
                      minFontSize: 6,
                      stepGranularity: 2.0,
                      wrapWords: false,
                      maxLines: 4,
                      textDirection: TextDirection.ltr),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: FittedBox(
                      child: MediaQuery(
                        data: new MediaQueryData(),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xfff5c517),
                          child: FittedBox(
                            child: Text('$score',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.ltr),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Unique Leaderboard in the leaderboard widget based on given category
// ignore: must_be_immutable
class LeaderBoard extends StatelessWidget {
  final String category;
  List<Item> list;
  final Color? color;
  final Color? textColor;
  final int maxRows;

  // Constructor
  LeaderBoard(
      this.category, this.list, this.color, this.textColor, this.maxRows);
  Widget build(BuildContext context) {
    list = sortList(category, list);

    // Set the nr of rows in the leaderboard using given variable maxRows
    int count = list.length;
    if (count > maxRows) {
      count = maxRows;
    }
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(category, // Title/category of the unique leaderboard
              style: TextStyle(color: textColor ?? Colors.white),
              textDirection: TextDirection.ltr),
          if (count == 0)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text("No items found in this category",
                  textDirection: TextDirection.ltr),
            ),
          Expanded(
            child: new Directionality(
              textDirection: TextDirection.ltr,
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: count,
                itemBuilder: (BuildContext context, int i) {
                  Item item = list[i];
                  int index = i + 1;
                  double score = item.compareValue;
                  // Return one leaderboard object on each row in the listview
                  return LeaderBoardObject(
                      index, score, item, color, textColor);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Build the complete leaderboard widget
class _LeaderBoardWidgetState extends State<LeaderBoardWidget> {
  @override
  Widget build(BuildContext context) {
    // Always set one category to top, also if category list is null
    if (widget.categoryList == null) {
      widget.categoryList = ["Top"];
    } else {
      widget.categoryList!.insert(0, "Top");
    }

    List<Widget> leaderBoards = []; // List of the leaderboards
    // Create each leaderboard based on category list
    for (int i = 0; i < widget.categoryList!.length; i++) {
      leaderBoards.add(LeaderBoard(widget.categoryList![i], widget.itemList,
          widget.color, widget.textColor, widget.maxRows));
    }
    // Return the full leaderboard widget
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
            Text(widget.title, // Title given to the widget
                style: TextStyle(
                  color: widget.titleColor ?? Color(0xfff333333),
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.ltr),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              // Create all the unique leaderboards from the list
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[for (var item in leaderBoards) item],
              ),
            ),
          ],
        ),
      ),
    );
  }
}