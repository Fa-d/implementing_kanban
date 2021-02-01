import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implementing_kanban/card_item_models/labels_model.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

class ButtonModels extends StatefulHookWidget {
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
        child: Text(
          widget.buttonName,
        ),
      ),
    );
  }

  Future Popup_button(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: buttonPosition.dy + buttonSize.height,
        left: buttonPosition.dx + (buttonSize.width / 2),
        child: LabelModel(),
      );
    });
    overlayState.insert(overlayEntry);
    context.read(currentOverlayCheck).setOverlayEntry(overlayEntry);
  }
}
