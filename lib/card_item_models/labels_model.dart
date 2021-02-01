import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

class LabelModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colorSel = useProvider(selectedColorOfLabel.state);
    final overlayProv = useProvider(currentOverlayCheck.state);
    final page = useProvider(currentPopup.state);
    // final popupBackButton = useProvider(popupBackButtonEnabled.state);
    return Material(
        child: Container(
            color: Colors.grey[250],
            width: 400,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  page
                      ? Container()
                      : IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            context.read(currentPopup).setCurrentPopup(true);

                          }),
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
                            color_row(Colors.red),
                            color_row(Colors.greenAccent),
                            color_row(Colors.blue),
                            color_row(Colors.orangeAccent),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                                child: FlatButton(
                                    onPressed: () {
                                      context
                                          .read(currentPopup)
                                          .setCurrentPopup(false);
                                      // context
                                      //     .read(popupBackButton)
                                      //     .backEnabled(true);
                                    },
                                    child: Text(
                                      "Create a new label",
                                      style: TextStyle(fontSize: 16),
                                    )))
                          ]))
                  : SingleChildScrollView(
                      child: Column(children: [
                      ColorPicker(
                        color: colorSel,
                        onColorChanged: (Color color) =>
                            context.read(selectedColorOfLabel).setColor(color),
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
                                  )))),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: FlatButton(
                        onPressed: () {
                          context.read(currentPopup).setCurrentPopup(true);
                          // context.read(popupBackButton).backEnabled(false);
                        },
                        child: Text("Add"),
                      )),
                      SizedBox(
                        height: 20,
                      )
                    ])),
            ])));
  }

  color_row(Color color) {
    return ListTile(
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
      title: Text("some text"),
    );
  }
}
