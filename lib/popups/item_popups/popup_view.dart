import 'package:flutter/material.dart';


import 'left_side.dart';
import 'right_side_popup.dart';


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
                  SingleChildScrollView(child: RightSidePopup()),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}