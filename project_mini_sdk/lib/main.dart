import 'package:flutter/material.dart';
import 'package:project_carousel/carousel/carousel.dart';
import 'package:project_carousel/infocard/infocard.dart';
import 'package:project_carousel/item.dart';
import 'package:project_carousel/leaderboard/leaderboard.dart';
import 'package:project_carousel/movie_list.dart';

void main() {
  runApp(MyApp());
}

List<Item> itemList = movies;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie page',
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
    List<InfoCardWidget> cardList = [];

    for (int i = 0; i < itemList.length; i++) {
      cardList.add(InfoCardWidget(
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
                child: LeaderBoardWidget(
                  itemList: itemList,
                  categoryList: ["Action"],
                )),
            SizedBox(height: 30),
          ]),
        ));
  }
}