import 'package:flutter/material.dart';
import 'package:implementing_kanban/menu/button_models.dart';

class RightSidePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 5,
            ),
            Text("Add To Card"),
            ..._addToCard(),
            SizedBox(height: 20),
            Text("PowerUps"),
            SizedBox(height: 20),
            Text("Actions"),
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
