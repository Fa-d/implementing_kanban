import 'package:flutter/material.dart';

class SingleLabelObject {
  String title;
  Color color;

  SingleLabelObject({
    @required this.title,
    @required this.color,
  });
}

class PopupLoc {
  Offset offset;
  LayerLink link;
  // OverlayEntry overlayEntry;

  PopupLoc({
    @required this.offset,
     // @required this.link,
    // @required this.overlayEntry,
  });
}
