import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:implementing_kanban/popups/botton_popups/button_models.dart';

class RightSidePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      ),
    );
  }

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
}
