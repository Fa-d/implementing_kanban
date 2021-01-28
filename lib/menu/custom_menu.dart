import 'package:flutter/material.dart';
import 'package:implementing_kanban/cards_specifications_models/label_models.dart';

class SimpleAccountMenu extends StatefulWidget {
  final BorderRadius borderRadius;

  final ValueChanged<int> onChange;
  final double width;
  final String buttonText;

  const SimpleAccountMenu({
    Key key,
    this.buttonText,
    this.borderRadius,
    this.onChange,
    this.width,
  }) : super(key: key);

  @override
  _SimpleAccountMenuState createState() => _SimpleAccountMenuState();
}

class _SimpleAccountMenuState extends State<SimpleAccountMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey _key;
  bool isMenuOpen = false;
  Offset buttonPosition;
  Size buttonSize;
  OverlayEntry _anotherOne;
  BorderRadius _borderRadius;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _anotherOne.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _anotherOne = _anotherEntryBuilder();
    Overlay.of(context).insert(_anotherOne);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: _borderRadius,
      ),
      child: FlatButton(
        onPressed: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
        child: Text(widget.buttonText),
      ),
    );
  }

  OverlayEntry _anotherEntryBuilder() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        top: buttonPosition.dy + buttonSize.height,
        left: buttonPosition.dx,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              LayoutBuilder(builder: (
                BuildContext context,
                BoxConstraints constraints,
              ) {
                print(constraints.maxWidth);
                return SizedBox(
                  child: LabelsModel(),
                  width: buttonSize.width * 5,
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
