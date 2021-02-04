import 'package:flutter/material.dart';
import 'package:implementing_kanban/popups/botton_popups/button_models.dart';

popUpTest(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            scrollable: true,
            content: Row(children: [
              leftSidePopUp(context),
              rightSidePopup(context),
            ]));
      });
}

leftSidePopUp(BuildContext context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            Row(children: [
              Icon(Icons.book),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
              ),
              Text("The name of the board",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))
            ]),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(children: [
                  Text("In List"),
                  FlatButton(
                    onPressed: () {},
                    child: Text("TODO's"),
                  )
                ]))
          ])),
      Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(child: Text("Submitß"), onPressed: () {}),
          )),
      Container(
        width: MediaQuery.of(context).size.width / 3.5,
      )
    ]);

rightSidePopup(BuildContext context) => Container(
    color: Colors.grey[50],
    child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
          ),
          Text(
            "Add To Card",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          ..._addToCard(),
          SizedBox(height: 20),
          Text(
            "PowerUps",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          ButtonModels(buttonName: "TimeTracker"),
          SizedBox(height: 20),
          Text(
            "Actions",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          ..._actions(),
        ])));

_addToCard() => [
      SizedBox(height: 10),
      ButtonModels(buttonName: "Labels"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "CheckList"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Due Date"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Attatchment"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Cover"),
    ];

_actions() => [
      SizedBox(height: 10),
      ButtonModels(buttonName: "Move"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Copy"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Make Template"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Archive"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Delete"),
      SizedBox(height: 10),
      ButtonModels(buttonName: "Share"),
      SizedBox(height: 10)
    ];
