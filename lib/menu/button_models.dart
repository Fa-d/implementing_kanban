import 'package:flutter/material.dart';

import 'custom_menu.dart';

class ButtonModels extends StatelessWidget {
  final String buttonName;

  ButtonModels({@required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
      onPressed: () {},
      child:Container(
          child: SimpleAccountMenu(
            onChange: (index) {
              print(index);
            },
            buttonText: buttonName,
          ),
        ),

    );
  }
}
