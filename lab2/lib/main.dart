import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

//For dividing the cardNumber in parts of four digits
class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboration 2',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Laboration 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cardNumber = "####  ####  ####  ####";
  String m_expiryDate = 'MM';
  String y_expiryDate = 'YY';
  String cardHolderName = 'FULL NAME';
  String cvvCode = '';
  var MonthSelected = 'Month';
  var YearSelected = 'Year';
  var months = [
    'Month',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  var years = [
    'Year',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030'
  ];

  var cardLogo = [
    "assets/images/visa.png",
    "assets/images/mastercard.png",
    "assets/images/amex.png"
  ];

  int cardType = 0;
  int cvvLength = 3;
  int cardNumberLength = 16;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(children: <Widget>[
          // The containers in the background
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Color.fromRGBO(255, 230, 230, 1),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 130, right: 30.0, left: 30.0),
                    child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: () {
                          Form.of(primaryFocus.context).save();
                        },
                        child: ListView(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Card Number'),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    cardNumberLength + 3),
                                FilteringTextInputFormatter.digitsOnly,
                                new CustomInputFormatter()
                              ],
                              onSaved: (String value) {
                                setState(() {
                                  cvvLength = 3;
                                  cardNumberLength = 16;
                                  cardNumber = value;
                                  if (cardNumber.isEmpty) {
                                    cardNumber = "####  ####  ####  ####";
                                    cardType = 0; //VISA

                                  } else {
                                    if (cardNumber[0] == '4') {
                                      cardType = 0; //VISA

                                    } else if (cardNumber[0] == '5') {
                                      cardType = 1; //MASTERCARD

                                    } else if (cardNumber.length > 1) {
                                      if (cardNumber[0] == '3' &&
                                          (cardNumber[1] == '4' ||
                                              cardNumber[1] == '7')) {
                                        cardType = 2; //AMEX
                                        cardNumberLength = 15;
                                        cvvLength = 4;
                                      }
                                    }
                                  }
                                });
                              },
                              onTap: () {
                                if (!cardKey.currentState.isFront) {
                                  //null safety

                                  cardKey.currentState.toggleCard();
                                }
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(labelText: 'Name'),
                              onSaved: (String value) {
                                setState(() {
                                  cardHolderName = value;
                                  if (cardHolderName.isEmpty) {
                                    cardHolderName = "FULL NAME";
                                  }
                                });
                              },
                              onTap: () {
                                if (!cardKey.currentState.isFront) {
                                  //null safety

                                  cardKey.currentState.toggleCard();
                                }
                              },
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                  child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  // menuMaxHeight: 300,
                                  items:
                                      // ignore: non_constant_identifier_names
                                      months.map((String M_dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: M_dropDownStringItem,
                                      child: Text(M_dropDownStringItem),
                                      //    alignment: AlignmentDirectional.center,
                                    );
                                  }).toList(),
                                  // ignore: non_constant_identifier_names
                                  onChanged: (String M_newValueSelected) {
                                    dropDownListItemChangedMonth(
                                        M_newValueSelected);
                                    m_expiryDate = M_newValueSelected;
                                    if (M_newValueSelected == 'Month') {
                                      m_expiryDate = "MM";
                                    }
                                  },
                                  onTap: () {
                                    if (!cardKey.currentState.isFront) {
                                      //null safety

                                      cardKey.currentState.toggleCard();
                                    }
                                  },
                                  value: MonthSelected,
                                ),
                              )),
                              Expanded(
                                  child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  //  menuMaxHeight: 300,
                                  items:
                                      // ignore: non_constant_identifier_names
                                      years.map((String Y_dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: Y_dropDownStringItem,
                                      child: Text(Y_dropDownStringItem),
                                      //  alignment: AlignmentDirectional.center,
                                    );
                                  }).toList(),
                                  // ignore: non_constant_identifier_names
                                  onChanged: (String Y_newValueSelected) {
                                    dropDownListItemChangedYear(
                                        Y_newValueSelected);
                                    y_expiryDate =
                                        Y_newValueSelected[2] + YearSelected[3];
                                    if (Y_newValueSelected == 'Year') {
                                      y_expiryDate = "YY";
                                    }
                                  },
                                  onTap: () {
                                    if (!cardKey.currentState.isFront) {
                                      //null safety

                                      cardKey.currentState.toggleCard();
                                    }
                                  },
                                  value: YearSelected,
                                ),
                              )),
                              Expanded(
                                  child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: 'CVV'),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(cvvLength),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onSaved: (String value) {
                                  setState(() {
                                    cvvCode = value;
                                    if (cvvCode.isEmpty) {
                                      cvvCode = "";
                                    }
                                  });
                                },
                                onTap: () {
                                  if (cardKey.currentState.isFront) {
                                    //null safety

                                    cardKey.currentState.toggleCard();
                                  }
                                },
                              ))
                            ])
                          ],
                        )),
                  ))
            ],
          ),
//**************************************KORTET*****************************************//
          SizedBox(
            height: 240.0,
            child: FlipCard(
              key: cardKey,
              fill: Fill
                  .fillBack, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.HORIZONTAL, // default
              front: Container(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 5.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Stack(children: <Widget>[
                        Container(
                            //For the background image
                            decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/21.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                        Container(
                            //For the overlaying icons and texts
                            color: Colors.red.withOpacity(0.2),
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/chip.png",
                                          height: 40,
                                        ),
                                        Image.asset(
                                          cardLogo[cardType],
                                          height: 40,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      cardNumber,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          cardHolderName.toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.white),
                                        ),
                                        // Text(
                                        //   expiryDate,
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 17,
                                        //       color: Colors.white),
                                        // )
                                        Text(
                                          m_expiryDate + '/' + y_expiryDate,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ])),
                ),
              ),
              back: Container(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 5.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Stack(children: <Widget>[
                        Container(
                            //For the background image
                            decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/21.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                        Container(
                            color: Colors.red.withOpacity(0.2),
                            //For the overlaying icons and texts
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    color: Colors.black.withOpacity(0.8),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    height: 40),
                                Row(children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          color: Colors.grey,
                                          height: 35)),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 20, 0),
                                          color: Colors.white,
                                          height: 35,
                                          child: Text(
                                            "*" * cvvCode.length,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.black),
                                          )))
                                ]),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        230, 0, 5, 10),
                                    height: 40,
                                    child: Image.asset(
                                      cardLogo[cardType],
                                      height: 40,
                                    )),
                              ],
                            )),
                      ])),
                ),
              ),
            ),
          ),
        ]),
      ),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }

  void dropDownListItemChangedMonth(String newItem) {
    setState(() {
      this.MonthSelected = newItem;
    });
  }

  void dropDownListItemChangedYear(String newItem) {
    setState(() {
      this.YearSelected = newItem;
    });
  }
}
