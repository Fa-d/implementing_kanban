import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

import 'models/label_object.dart';

class LabelUI extends HookWidget {
  final LayerLink link;
  final Offset offset;
  final OverlayEntry overlayEntry;

  LabelUI({Key key, this.link, this.offset, this.overlayEntry})
      : super(key: key);
  final labelText = TextEditingController();
  Offset tapPosition;

  @override
  Widget build(BuildContext context) {
    final colorSel = useProvider(selectedColorOfLabel.state);
    final overlayProv = useProvider(currentOverlayCheck.state);
    final page = useProvider(currentPopup.state);
    final selectedLabelsProv = useProvider(selectedLabels.state);
    final subPopupLocProv = useProvider(subPopupLocation.state);

    void _onDragUpdateHandler(
        DragUpdateDetails details, OverlayEntry overlayEntry) {
      print("${details.globalPosition.dx} : ${details.globalPosition.dy}");
      context.read(subPopupLocation).setOffsetVal(PopupLoc(
            offset: Offset(
              details.globalPosition.dx,
              details.globalPosition.dy,
            ),
          ));
      overlayEntry.markNeedsBuild();
    }

    return CompositedTransformFollower(
      offset: subPopupLocProv.offset,
      link: link,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) =>
            _onDragUpdateHandler(details, overlayEntry),
        onVerticalDragUpdate: (details) =>
            _onDragUpdateHandler(details, overlayEntry),
        child: Material(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey[250],
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      page
                          ? Container()
                          : IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                context
                                    .read(currentPopup)
                                    .setCurrentPopup(true);
                              },
                            ),
                      Text(
                        "Add",
                        style: TextStyle(fontSize: 17),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          overlayProv.remove();
                        },
                      ),
                    ],
                  ),
                  page
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "LABELS",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...selectedLabelsProv
                                  .map(
                                    (e) => colorRowLabelUnit(e.color, e.title),
                                  )
                                  .toList(),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: FlatButton(
                                  onPressed: () {
                                    context
                                        .read(currentPopup)
                                        .setCurrentPopup(false);
                                  },
                                  child: Text(
                                    "Create a new label",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            ColorPicker(
                              color: colorSel,
                              onColorChanged: (Color color) => context
                                  .read(selectedColorOfLabel)
                                  .setColor(color),
                              heading: Text(
                                'Select color',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              subheading: Text(
                                'Select color shade',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                controller: labelText,
                                decoration: InputDecoration(
                                  fillColor: colorSel,
                                  filled: true,
                                  hintText: "The name of card",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorSel),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.format_paint_outlined,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: FlatButton(
                                onPressed: () {
                                  context
                                      .read(currentPopup)
                                      .setCurrentPopup(true);
                                  // context.read(popupBackButton).backEnabled(false);
                                  context.read(selectedLabels).addToLabel(
                                        SingleLabelObject(
                                          title: labelText.text,
                                          color: colorSel,
                                        ),
                                      );
                                },
                                child: Text("Add"),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  colorRowLabelUnit(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        tileColor: color,
        leading: SizedBox(
          width: 10,
          height: 10,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.edit),
          ),
        ),
        title: Text(text),
      ),
    );
  }
}
