import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  CarouselWidget({
    Key? key,
    required this.itemList,
    required this.height,
    required this.viewportFraction,
  }) : super(key: key);

  List<Widget> itemList;
  double height;
  double viewportFraction;

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    int count = widget.itemList.length;

    return Column(children: <Widget>[
      SizedBox(
        // you may want to use an aspect ratio here for tablet support
        height: widget.height,
        child: PageView.builder(
          // store this controller in a State to save the carousel scroll position
          padEnds: false,
          controller: PageController(viewportFraction: widget.viewportFraction),
          itemCount: count,
          itemBuilder: (BuildContext context, int itemIndex) {
            int index = itemIndex;
            return _buildCarouselItem(context, index);
          },
        ),
      )
    ]);
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget _buildCarouselItem(BuildContext context, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.5),
        child: widget.itemList[index]);
  }
}
