import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:implementing_kanban/kaban_main/kanban_item.dart';
import 'package:implementing_kanban/kaban_main/kanban_list.dart';
import 'package:implementing_kanban/kaban_main/kanban_main_view.dart';
import 'package:implementing_kanban/kaban_main/kanban_view_controller.dart';
import 'package:implementing_kanban/popups/item_popups/popup_view.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';

import 'board_item_object.dart';
import 'board_list_object.dart';

class BoardViewExample extends StatefulHookWidget {
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
  var overlayProv ;
  @override
  Widget build(BuildContext context) {
    overlayProv = useProvider(currentOverlayCheck.state);
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
                        popUpTest(context, overlayProv);
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
}
