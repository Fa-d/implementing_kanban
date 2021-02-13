import 'package:flutter/material.dart';

class CheckListModel extends StatelessWidget {
  CheckListModel({Key key, @required this.buttonName}) : super(key: key);
  final String buttonName;
  OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return GestureDetector(
      onTapDown: (details) {
        OverlayState overlayState = Overlay.of(context);
        overlayEntry = OverlayEntry(
          builder: (context) {
            return Positioned(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2,
              child: Material(
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
                        Text(
                          "Add",
                          style: TextStyle(fontSize: 17),
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            overlayEntry.remove();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add To Check List",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: _controller,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Create a new label",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
        overlayState.insert(overlayEntry);
      },
      child: Container(
        color: Colors.grey[200],
        child: Text(
          buttonName,
        ),
      ),
    );
  }
}
