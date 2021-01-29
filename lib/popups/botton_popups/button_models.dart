import 'package:flutter/material.dart';
import 'package:implementing_kanban/card_item_models/labels_model.dart';

class ButtonModels extends StatefulWidget {
  final String buttonName;

  ButtonModels({Key key, @required this.buttonName}) : super(key: key);

  @override
  _ButtonModelsState createState() => _ButtonModelsState();
}

class _ButtonModelsState extends State<ButtonModels> {
  Offset buttonPosition;
  GlobalKey _key;
  Size buttonSize;
  OverlayEntry overlayEntry;

  @override
  void initState() {
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () {
        findButton();
        Popup_button(context);
      },
      child: Container(
        color: Colors.grey[200],
        child: Text(widget.buttonName),
      ),
    );
  }

  Future Popup_button(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: buttonPosition.dy + buttonSize.height,
        left: buttonPosition.dx + (buttonSize.width / 2),
        child: LabelsModel(),
      );
    });
    overlayState.insert(overlayEntry);
  }

  LabelsModel() {
    return Material(
      child: Container(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Text("Add to ${widget.buttonName}"),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    overlayEntry.remove();
                  },
                )
              ],
            ),
            LabelModel(),
          ],
        ),
      ),
    );
  }
}
