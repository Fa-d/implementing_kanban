import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

import 'models/attatchment_object.dart';

class AtatchmentModel extends StatefulHookWidget {
  AtatchmentModel({Key key, @required this.buttonName}) : super(key: key);
  final String buttonName;



  @override
  State<StatefulWidget> createState() => _AnotherClass();

}

class _AnotherClass extends State<AtatchmentModel> {
  OverlayEntry overlayEntry;
  var nameController = TextEditingController();
  var linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        OverlayState overlayState = Overlay.of(context);
        overlayEntry = OverlayEntry(
          builder: (context) {
            return Positioned(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2,
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                          Text("${widget.buttonName}"),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              overlayEntry.remove();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(12.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: linkController,
                        decoration: InputDecoration(
                          hintText: 'Enter the link',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(12.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          context.read(attatchmentLists).addToAttatchment(
                            AttatchmentModels(
                              name: nameController.text,
                              link: linkController.text,
                            ),
                          );
                          overlayEntry.remove();
                          setState(() {

                          });
                        },
                        child: Text("Add this link"),

                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
        overlayState.insert(overlayEntry);
      },
      child: Text("Add your attatchment"),
    );
  }
}
