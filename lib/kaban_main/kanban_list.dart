import 'package:flutter/widgets.dart';

import 'kanban_item.dart';
import 'kanban_main_view.dart';

typedef void OnDropList(
  int listIndex,
  int oldListIndex,
);
typedef void OnTapList(int index);
typedef void OnStartDragList(int listIndex);

class KanbanList extends StatefulWidget {
  final List<Widget> header;
  final Widget footer;
  final List<KanbanItem> items;
  final Color backgroundColor;
  final Color headerBackgroundColor;
  final KanbanMainViewState kanbanMainView;
  final OnDropList onDropList;
  final OnTapList onTapList;
  final OnStartDragList onStartDragList;
  final bool draggable;
  final int index;

  KanbanList({
    Key key,
    this.header,
    this.footer,
    this.items,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.kanbanMainView,
    this.onDropList,
    this.onTapList,
    this.onStartDragList,
    this.draggable = true,
    this.index,
  }) : super(key: key);

  @override
  KanbanListState createState() => KanbanListState();
}

class KanbanListState extends State<KanbanList>
    with AutomaticKeepAliveClientMixin {
  List<KanbanItemState> itemStates = <KanbanItemState>[];
  ScrollController kanbanListController = new ScrollController();

  void onDropList(int listIndex) {
    if (widget.onDropList != null) {
      widget.onDropList(listIndex, widget.kanbanMainView.startListIndex);
    }
    widget.kanbanMainView.draggedListIndex = null;
    if (widget.kanbanMainView.mounted) {
      widget.kanbanMainView.setState(() {});
    }
  }

  void _startDrag(Widget item, BuildContext context) {
    if (widget.kanbanMainView != null && widget.draggable) {
      if (widget.onStartDragList != null) {
        widget.onStartDragList(widget.index);
      }
      widget.kanbanMainView.startListIndex = widget.index;
      widget.kanbanMainView.height = context.size.height;
      widget.kanbanMainView.draggedListIndex = widget.index;
      widget.kanbanMainView.draggedItemIndex = null;
      widget.kanbanMainView.draggedItem = item;
      widget.kanbanMainView.onDropList = onDropList;
      widget.kanbanMainView.run();
      if (widget.kanbanMainView.mounted) {
        widget.kanbanMainView.setState(() {});
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = new List<Widget>();
    if (widget.header != null) {
      Color headerBackgroundColor = Color.fromARGB(255, 255, 255, 255);
      if (widget.headerBackgroundColor != null) {
        headerBackgroundColor = widget.headerBackgroundColor;
      }
      listWidgets.add(GestureDetector(
          onTap: () {
            if (widget.onTapList != null) {
              widget.onTapList(widget.index);
            }
          },
          onTapDown: (otd) {
            if (widget.draggable) {
              RenderBox object = context.findRenderObject();
              Offset pos = object.localToGlobal(Offset.zero);
              widget.kanbanMainView.initialX = pos.dx;
              widget.kanbanMainView.initialY = pos.dy;

              widget.kanbanMainView.rightListX = pos.dx + object.size.width;
              widget.kanbanMainView.leftListX = pos.dx;
            }
          },
          onTapCancel: () {},
          onLongPress: () {
            if (!widget.kanbanMainView.widget.isSelecting && widget.draggable) {
              _startDrag(widget, context);
            }
          },
          child: Container(
            color: widget.headerBackgroundColor,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.header),
          )));
    }
    if (widget.items != null) {
      listWidgets.add(Container(
          child: Flexible(
              fit: FlexFit.loose,
              child: new ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                controller: kanbanListController,
                itemCount: widget.items.length,
                itemBuilder: (ctx, index) {
                  if (widget.items[index].kanbanList == null ||
                      widget.items[index].index != index ||
                      widget.items[index].kanbanList.widget.index !=
                          widget.index ||
                      widget.items[index].kanbanList != this) {
                    widget.items[index] = new KanbanItem(
                      kanbanList: this,
                      item: widget.items[index].item,
                      draggable: widget.items[index].draggable,
                      index: index,
                      onDropItem: widget.items[index].onDropItem,
                      onTapItem: widget.items[index].onTapItem,
                      onDragItem: widget.items[index].onDragItem,
                      onStartDragItem: widget.items[index].onStartDragItem,
                    );
                  }
                  if (widget.kanbanMainView.draggedItemIndex == index &&
                      widget.kanbanMainView.draggedListIndex == widget.index) {
                    return Opacity(
                      opacity: 0.0,
                      child: widget.items[index],
                    );
                  } else {
                    return widget.items[index];
                  }
                },
              ))));
    }

    if (widget.footer != null) {
      listWidgets.add(widget.footer);
    }

    Color backgroundColor = Color.fromARGB(255, 255, 255, 255);

    if (widget.backgroundColor != null) {
      backgroundColor = widget.backgroundColor;
    }
    if (widget.kanbanMainView.listStates.length > widget.index) {
      widget.kanbanMainView.listStates.removeAt(widget.index);
    }
    widget.kanbanMainView.listStates.insert(widget.index, this);

    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: listWidgets,
        ));
  }
}
