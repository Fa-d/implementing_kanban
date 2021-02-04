import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implementing_kanban/card_item_models/labels_model.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

class ButtonModels extends HookWidget {
  ButtonModels({Key key, @required this.buttonName}) : super(key: key);
  final String buttonName;
  final LayerLink layerLink = LayerLink();
  OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    final subPopupLocProv = useProvider(subPopupLocation.state);
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        onTapDown: (details) {
          OverlayState overlayState = Overlay.of(context);
          overlayEntry = OverlayEntry(builder: (context) {
            return Positioned(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/2,
              top: subPopupLocProv.offset.dy,
              left: subPopupLocProv.offset.dx,
              child: LabelUI(link: layerLink, overlayEntry: overlayEntry),
            );
          });
          overlayState.insert(overlayEntry);
          context.read(currentOverlayCheck).setOverlayEntry(overlayEntry);
        },
        child: Container(
          color: Colors.grey[200],
          child: Text(
            buttonName,
          ),
        ),
      ),
    );
  }
}
