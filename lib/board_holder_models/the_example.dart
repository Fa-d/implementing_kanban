import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:implementing_kanban/kaban_main/kanban_item.dart';
import 'package:implementing_kanban/kaban_main/kanban_list.dart';
import 'package:implementing_kanban/kaban_main/kanban_main_view.dart';
import 'package:implementing_kanban/kaban_main/kanban_view_controller.dart';
import 'package:implementing_kanban/menu/custom_menu.dart';

import 'board_item_object.dart';
import 'board_list_object.dart';

class BoardViewExample extends StatefulWidget {
  @override
  _BoardViewExampleState createState() => _BoardViewExampleState();
}

class _BoardViewExampleState extends State<BoardViewExample> {
  List<BoardListObject> _listData = [
    BoardListObject(title: "List title 1", items: <BoardItemObject>[
      new BoardItemObject(title: 'sdf'),
      new BoardItemObject(title: 'sdf'),
      new BoardItemObject(title: 'sdf'),
      new BoardItemObject(title: 'sdf')
    ]),
    BoardListObject(title: "List title 2"),
    BoardListObject(title: "List title 3")
  ];

  KanbanViewController boardViewController = new KanbanViewController();

  @override
  Widget build(BuildContext context) {
    List<KanbanList> _lists = <KanbanList>[];
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(
        _listData[i],
        context,
      ));
    }
    return KanbanMainView(
      lists: _lists,
      kanbanViewController: boardViewController,
    );
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return KanbanItem(
      onStartDragItem: (int listIndex, int itemIndex, KanbanItemState state) {},
      onDropItem: (int listIndex, int itemIndex, int oldListIndex,
          int oldItemIndex, KanbanItemState state) {
        var item = _listData[oldListIndex].items[oldItemIndex];
        _listData[oldListIndex].items.removeAt(oldItemIndex);
        _listData[listIndex].items.insert(itemIndex, item);
      },
      onTapItem: (int listIndex, int itemIndex, KanbanItemState state) async {},
      item: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(itemObject.title),
        ),
      ),
    );
  }

  Widget _createBoardList(BoardListObject list, BuildContext context) {
    List<KanbanItem> items = <KanbanItem>[];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]));
    }

    return KanbanList(
      onStartDragList: (int listIndex) {},
      onTapList: (int listIndex) async {},
      onDropList: (int listIndex, int oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex, list);
      },
      headerBackgroundColor: Colors.green[500],
      backgroundColor: Colors.lightGreen,
      header: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              list.title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
      footer: footer_check
          ? SizedBox(
              height: 50,
              width: 290,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.grey[200],
                    onPressed: () {
                      setState(() {
                        // popUpTest(context);
                        footer_check = false;
                      });
                    },
                    child: Text("New Card"),
                  )),
            )
          : SizedBox(
              height: 50,
              width: 290,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Enter card name'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Icon(Icons.check),
                      onTap: () {
                        print("Submission clicked");
                        popUpTest(context);
                        // setState(() {
                        //   footer_check = true;
                        // });
                      },
                    ),
                  )
                ],
              ),
            ),
      items: items,
    );
  }

  bool footer_check = true;

  popUpTest(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Form(
                // key: _formKey,
                child: Row(
                  children: [
                    Column(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.book),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                  ),
                                  Text(
                                    "The name of the board",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text("In List"),
                                    FlatButton(
                                      onPressed: () {},
                                      child: Text("TODO's"),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: TextFormField(),
                        // ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                                child: Text("Submitß"),
                                onPressed: () {
                                  // if (_formKey.currentState.validate()) {
                                  //   _formKey.currentState.save();}
                                }),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.blueAccent[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Text("Add to card"),
                            Text("Actions"),
                            Text("PowerUps"),
                            FlatButton(
                              onPressed: () {},
                              child: Theme(
                                data: ThemeData(
                                  iconTheme: IconThemeData(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Container(
                                  child: SimpleAccountMenu(
                                    icons: [
                                      Icon(Icons.person),
                                      Icon(Icons.settings),
                                      Icon(Icons.credit_card),
                                    ],
                                    iconColor: Colors.white,
                                    onChange: (index) {
                                      print(index);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
