
# Flutter Getting Started Guide
#### _By Alice Molin and Julia Johnstone_
<br>

## Installing flutter
Before we get started you first have to install flutter on your computer. This process can be different depending on the operative system you are using and the platform you are working on.

To install flutter to your machine, follow this guide: [Install flutter](https://docs.flutter.dev/get-started/install).

## The basics of flutter
The core layout mechanism of flutter are widgets, almost everything you see (and don't see) in a flutter project are built of combined widgets. Each widget has their own set of parameters and they can always be seen when hovering over the widget. To nest widgets you often set the inner widget as a child to the outer one.

We divide the widgets into two different types, **Stateless** and **Stateful**. If a widget can change due to user interaction for example, it is stateful.

A stateful widget is implemented by two classes instead of one like the stateless widget. A subclass of `StatefulWidget` and a sublass of `State`. The State class contains the mutable state and the widgets `build()` method. This method is called everytime the `setState()` is called, telling the framework to redraw the widget.

## A simple layout
Let's create a simple Flutter layout. We will start off by importing the material package. This package contains the Material Design for the widgets in Flutter. Then we create a Stateful Widget as seen below.

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('I\'m an App'),
        ),
        body: Center(
          child: Text('This is a body'),
        ),
      ),
    );
  }
}
```
This will give you an empty white screen with a centered text. There will also be an appbar at the top. The Scaffold instantiates our main structure of the application.

<br />

Now we add some components to the body. We wrap the `Text()` widget in a `Column()` widget and add a second child which is a `Row()` widget. These two new widgets take in a list of widgets as children. We then add buttons to the row to make them lay beside eachother in a horizontal line. The `SizedBox()` widgets are only for setting space between the visible components.

```dart
....
 body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text('I can change color!'),
            SizedBox(height:50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                ElevatedButton(
                  child: Text("Text color"),
                  onPressed: null,
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  child: Text("Next page"),
                  onPressed: null,
                ),
              ],
            ),
          ],)
        )
...
```
<br />

## Interaction with listener/callbacks functions
Nice! Now we can add some functionality to the first button. We will add a simple callback function that can modify the color of the `Text()` widget. This is done in the onPressed parameter where we add a `setState()` function. The function tweek the value of a boolean that stores the state of the button.

```dart
...
     ElevatedButton(
                    child: Text("Text color"),
                    onPressed: () {
                      setState(() {
                        isButtonPressed = !isButtonPressed;
                      });
                    },
                  ),
...
```

In the `Text()` widget we add a TextStyle and implement a short if-statement for the color parameter.

```dart
...
Text('I can change color!',
                  style: TextStyle(
                      color: isButtonPressed ? Colors.orange : Colors.blue))
...
```
<br />

## Navigation between different pages
For the second button we add a `Navigator()`, this is for routing to another page in the application. We will not build the second page but we have a dummy `SecondRoute()` in the code below just for reference. There is a couple different routing options but in this example we used `MaterialPageRoute()`, it uses a platform specific animation as default.

```dart
...
     ElevatedButton(
                      child: Text("Next page"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondRoute()),
                        );
                      }),
...
```
When we navigate with the command `push` we create a stack of pages, so the current page is on top of the stack. To navigate back to a previous page we want to `pop` the page off the stack to avoid creating messy stacks that are no longer traceable. To do this you apply this code snippet to the desired widget in `SecondRoute()`.

```dart
...
onPressed: () {
  Navigator.pop(context);
}
...
```
Happy coding!