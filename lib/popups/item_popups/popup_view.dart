import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:implementing_kanban/card_item_models/checklist_model.dart';
import 'package:implementing_kanban/popups/botton_popups/button_models.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

popUpTest(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, stateState) {
        return AlertDialog(
          scrollable: true,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftSidePopUp(context, stateState),
              rightSidePopup(context),
            ],
          ),
        );
      });
    },
  );
}

leftSidePopUp(BuildContext context, setState) {
  var _controller = TextEditingController();
  return Consumer(builder: (context, watch, _) {
    final descripText = watch(descriptionEditor);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.book),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                  ),
                  Text(
                    "The name of the board",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Text("In List"),
                    FlatButton(
                      onPressed: () {},
                      child: Text("TODO's"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Text(
          "Description",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        descripText.getTrueOrFalse()
            ? GestureDetector(
                onTap: () {
                  setState(() {});

                  context.read(descriptionEditor).setTrueOrFalse(false);
                },
                child: Text("Write your description"),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: '1',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(12.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});

                        context.read(descriptionEditor).setTrueOrFalse(true);
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Comment"),
            FlatButton(
              onPressed: () {},
              child: Text("Show Details"),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(child: Text("Submitß"), onPressed: () {}),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
        ),
      ],
    );
  });
}

rightSidePopup(BuildContext context) => Container(
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

_addToCard() => [
      SizedBox(height: 10),
      ButtonModels(buttonName: "Labels"),
      SizedBox(height: 10),
      CheckListModel(buttonName: "CheckList"),
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
