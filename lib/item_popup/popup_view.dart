import 'package:flutter/material.dart';
import 'package:implementing_kanban/item_popup/left_side.dart';
import 'package:implementing_kanban/item_popup/right_side_popup.dart';

popUpTest(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              // key: _formKey,
              child: Row(
                children: [
                  LeftSidePopUp(),
                  RightSidePopup(),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
