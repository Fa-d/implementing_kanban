import 'package:flutter/widgets.dart';

import 'kanban_list.dart';

typedef void OnDropItem(
  int listIndex,
  int itemIndex,
  int oldListIndex,
  int oldItemIndex,
  KanbanItemState state,
);
typedef void OnTapItem(
  int listIndex,
  int itemIndex,
  KanbanItemState state,
);
typedef void OnStartDragItem(
  int listIndex,
  int itemIndex,
  KanbanItemState state,
);
typedef void OnDragItem(
  int oldListIndex,
  int oldItemIndex,
  int newListIndex,
  int newItemIndex,
  KanbanItemState state,
);

class KanbanItem extends StatefulWidget {
  final KanbanListState kanbanList;
  final Widget item;
  final int index;
  final OnDropItem onDropItem;
  final OnTapItem onTapItem;
  final OnStartDragItem onStartDragItem;
  final OnDragItem onDragItem;
  final bool draggable;

  KanbanItem({
    Key key,
    this.item,
    this.index,
    this.onDropItem,
    this.onTapItem,
    this.onStartDragItem,
    this.draggable = true,
    this.onDragItem,
    this.kanbanList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KanbanItemState();
}

class KanbanItemState extends State<KanbanItem>
    with AutomaticKeepAliveClientMixin {
  double height;
  double width;

  @override
  bool get wantKeepAlive => true;

  void onDropItem(int listIndex, int itemIndex) {
    if (widget.onDropItem != null) {
      widget.onDropItem(
          listIndex,
          itemIndex,
          widget.kanbanList.widget.kanbanMainView.startListIndex,
          widget.kanbanList.widget.kanbanMainView.startItemIndex,
          this);
    }
    widget.kanbanList.widget.kanbanMainView.draggedItemIndex = null;
    widget.kanbanList.widget.kanbanMainView.draggedListIndex = null;
    if (widget.kanbanList.widget.kanbanMainView.listStates[listIndex].mounted) {
      widget.kanbanList.widget.kanbanMainView.listStates[listIndex]
          .setState(() {});
    }
  }

  void _startDrag(Widget item, BuildContext context) {
    if (widget.kanbanList.widget.kanbanMainView != null) {
      widget.kanbanList.widget.kanbanMainView.onDropItem = onDropItem;
      if (widget.kanbanList.mounted) {
        widget.kanbanList.setState(() {});
      }
      widget.kanbanList.widget.kanbanMainView.draggedItemIndex = widget.index;
      widget.kanbanList.widget.kanbanMainView.height = context.size.height;
      widget.kanbanList.widget.kanbanMainView.draggedListIndex =
          widget.kanbanList.widget.index;
      widget.kanbanList.widget.kanbanMainView.startListIndex =
          widget.kanbanList.widget.index;
      widget.kanbanList.widget.kanbanMainView.startItemIndex = widget.index;
      widget.kanbanList.widget.kanbanMainView.draggedItem = item;
      if (widget.onStartDragItem != null) {
        widget.onStartDragItem(
            widget.kanbanList.widget.index, widget.index, this);
      }
      widget.kanbanList.widget.kanbanMainView.run();
      if (widget.kanbanList.widget.kanbanMainView.mounted) {
        widget.kanbanList.widget.kanbanMainView.setState(() {});
      }
    }
  }

  void afterFirstLayout(BuildContext context) {
    try {
      height = context.size.height;
      width = context.size.width;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    if (widget.kanbanList.itemStates.length > widget.index) {
      widget.kanbanList.itemStates.removeAt(widget.index);
    }
    widget.kanbanList.itemStates.insert(widget.index, this);
    return GestureDetector(
      onTapDown: (otd) {
        if (widget.draggable) {
          RenderBox object = context.findRenderObject();
          Offset pos = object.localToGlobal(Offset.zero);
          RenderBox box = widget.kanbanList.context.findRenderObject();
          Offset listPos = box.localToGlobal(Offset.zero);
          widget.kanbanList.widget.kanbanMainView.leftListX = listPos.dx;
          widget.kanbanList.widget.kanbanMainView.topListY = listPos.dy;
          widget.kanbanList.widget.kanbanMainView.topItemY = pos.dy;
          widget.kanbanList.widget.kanbanMainView.bottomItemY =
              pos.dy + object.size.height;
          widget.kanbanList.widget.kanbanMainView.bottomListY =
              listPos.dy + box.size.height;
          widget.kanbanList.widget.kanbanMainView.rightListX =
              listPos.dx + box.size.width;

          widget.kanbanList.widget.kanbanMainView.initialX = pos.dx;
          widget.kanbanList.widget.kanbanMainView.initialY = pos.dy;
        }
      },
      onTapCancel: () {},
      onTap: () {
        if (widget.onTapItem != null) {
          widget.onTapItem(
            widget.kanbanList.widget.index,
            widget.index,
            this,
          );
        }
      },
      onLongPress: () {
        if (!widget.kanbanList.widget.kanbanMainView.widget.isSelecting &&
            widget.draggable) {
          _startDrag(widget, context);
        }
      },
      child: widget.item,
    );
  }
}
