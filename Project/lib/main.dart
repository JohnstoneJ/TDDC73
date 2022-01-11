import 'package:flutter/material.dart';
import 'package:project_carousel/carousel/carousel.dart';
import 'package:project_carousel/infocard/infocard.dart';
import 'package:project_carousel/item.dart';
import 'package:project_carousel/leaderboard/leaderboard.dart';

void main() {
  runApp(MyApp());
}

List<Item> itemList = [
  Item(name: "The Gentlemen", compareValue: 9, category: "Action"),
  Item(name: "Pulp Fiction", compareValue: 7, category: "Crime"),
  Item(name: "Forrest Gump", compareValue: 8, category: "Drama"),
  Item(name: "Inception", compareValue: 9, category: "Action"),
  Item(name: "Blood Diamond", compareValue: 8, category: "Drama"),
  Item(
      name: "Once Upon a Time in Hollywood",
      compareValue: 8,
      category: "Drama"),
  Item(name: "Stranger Than Fiction", compareValue: 6, category: "Drama"),
  Item(name: "1917", compareValue: 9, category: "Action"),
  Item(
      name: "Spider-Man: Into the Spider-Verse",
      compareValue: 8,
      category: "Action"),
  Item(name: "The Shawshank Redemption", compareValue: 9, category: "Drama"),
  Item(name: "Coco", compareValue: 8, category: "Family"),
  Item(name: "Avengers: Infinity War", compareValue: 8, category: "Action"),
  Item(name: "The Prestige", compareValue: 7, category: "Drama"),
  Item(name: "Intouchables", compareValue: 9, category: "Drama"),
  Item(name: "The Departed", compareValue: 8, category: "Action"),
  Item(name: "Interstellar", compareValue: 7, category: "Drama"),
  Item(name: "Seven", compareValue: 9, category: "Crime"),
  Item(name: "American History X", compareValue: 9, category: "Drama"),
  Item(name: "Spirited Away", compareValue: 10, category: "Family"),
];

class MyApp extends StatelessWidget {
  /*List<Item> itemList = [
  /*  Item(padding: 3.5, borderRadius: 40.0,),
    Item(padding: 50.0, borderRadius: 3.0),
    Item(padding: 3.5, ),
    Item(padding: 3.5, borderRadius: 10.0, color:Colors.orange),
    Item(padding: 3.5, borderRadius: 4.0),
    Item(padding: 3.5, borderRadius: 4.0),
    Item(padding: 3.5, borderRadius: 4.0),*/

  ];*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Carousel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    List<InfoCardWidget> cardList = [];

    for (int i = 0; i < itemList.length; i++) {
      cardList.add
        (InfoCardWidget(
          items: itemList,
          item_val: i,
        ));
    }

    return Scaffold(
        body: Center(
      child: Column(children: <Widget>[
        CarouselWidget(
          itemList: cardList,
          height: 200,
          viewportFraction: 0.15,
        ),
        SizedBox(height: 15),
        Expanded(
        child:LeaderBoardWidget(itemList: itemList, categoryList: ["Action"],)),SizedBox(height: 30),
      ]),
    ));
  }
}
