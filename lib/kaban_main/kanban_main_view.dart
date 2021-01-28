import 'package:flutter/widgets.dart';
import 'package:implementing_kanban/kaban_main/kanban_list.dart';
import 'package:implementing_kanban/kaban_main/kanban_view_controller.dart';

typedef void OnDropBottomWidget(
  int listIndex,
  int itemIndex,
  double percentX,
);

typedef void OnDropItem(
  int listIndex,
  int itemIndex,
);
typedef void OnDropList(int listIndex);

class KanbanMainView extends StatefulWidget {
  final List<KanbanList> lists;
  final double width;
  Widget middleWidget;
  double bottomPadding;
  bool isSelecting;
  KanbanViewController kanbanViewController;
  int dragDelay;

  Function(bool) itemInMiddleWidget;
  OnDropBottomWidget onDropItemInMiddleWidget;

  KanbanMainView({
    Key key,
    this.lists,
    this.width = 300,
    this.middleWidget,
    this.bottomPadding,
    this.isSelecting = false,
    this.kanbanViewController,
    this.dragDelay = 50,
    this.itemInMiddleWidget,
    this.onDropItemInMiddleWidget,
  }) : super(key: key);

  @override
  KanbanMainViewState createState() => KanbanMainViewState();
}

class KanbanMainViewState extends State<KanbanMainView>
    with AutomaticKeepAliveClientMixin {
  Widget draggedItem;
  int draggedItemIndex;
  int draggedListIndex;
  double dx;
  double dxInit;
  double dy;
  double dyInit;
  double offsetX;
  double offsetY;
  double initialX = 0;
  double initialY = 0;
  double rightListX;
  double leftListX;
  double topListY;
  double bottomListY;
  double topItemY;
  double bottomItemY;
  double height;
  int startListIndex;
  int startItemIndex;
  bool canDrag = true;

  ScrollController kanbanMainViewController = new ScrollController();
  List<KanbanListState> listStates = <KanbanListState>[];


  OnDropItem onDropItem;
  OnDropList onDropList;

  bool isScrolling = false;

  bool _isInWidget = false;

  GlobalKey _middleWidgetKey = GlobalKey();

  var pointer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if(widget.kanbanViewController != null){
      widget.kanbanViewController.state = this;
    }
  }
  void moveDown() {
    topItemY += listStates[draggedListIndex].itemStates[draggedItemIndex + 1].height;
    bottomItemY += listStates[draggedListIndex].itemStates[draggedItemIndex + 1].height;
    var item = widget.lists[draggedListIndex].items[draggedItemIndex];
    widget.lists[draggedListIndex].items.removeAt(draggedItemIndex);
    var itemState = listStates[draggedListIndex].itemStates[draggedItemIndex];
    listStates[draggedListIndex].itemStates.removeAt(draggedItemIndex);
    widget.lists[draggedListIndex].items.insert(++draggedItemIndex, item);
    listStates[draggedListIndex].itemStates.insert(draggedItemIndex, itemState);
    if(listStates[draggedListIndex].mounted) {
      listStates[draggedListIndex].setState(() {});
    }
  }

  void moveUp() {
    topItemY -= listStates[draggedListIndex].itemStates[draggedItemIndex - 1].height;
    bottomItemY -= listStates[draggedListIndex].itemStates[draggedItemIndex - 1].height;
    var item = widget.lists[draggedListIndex].items[draggedItemIndex];
    widget.lists[draggedListIndex].items.removeAt(draggedItemIndex);
    var itemState = listStates[draggedListIndex].itemStates[draggedItemIndex];
    listStates[draggedListIndex].itemStates.removeAt(draggedItemIndex);
    widget.lists[draggedListIndex].items.insert(--draggedItemIndex, item);
    listStates[draggedListIndex].itemStates.insert(draggedItemIndex, itemState);
    if(listStates[draggedListIndex].mounted) {
      listStates[draggedListIndex].setState(() {});
    }
  }

  void moveListRight() {
    var list = widget.lists[draggedListIndex];
    var listState = listStates[draggedListIndex];
    widget.lists.removeAt(draggedListIndex);
    listStates.removeAt(draggedListIndex);
    draggedListIndex++;
    widget.lists.insert(draggedListIndex, list);
    listStates.insert(draggedListIndex, listState);
    canDrag = false;
    if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
      int tempListIndex = draggedListIndex;
      kanbanMainViewController
          .animateTo(draggedListIndex * widget.width, duration: new Duration(milliseconds: 50), curve: Curves.ease)
          .whenComplete(() {
        RenderBox object = listStates[tempListIndex].context.findRenderObject();
        Offset pos = object.localToGlobal(Offset.zero);
        leftListX = pos.dx;
        rightListX = pos.dx + object.size.width;
        Future.delayed(new Duration(milliseconds: widget.dragDelay), () {
          canDrag = true;
        });
      });
    }
    if(mounted){
      setState(() {});
    }
  }

  void moveRight() {
    var item = widget.lists[draggedListIndex].items[draggedItemIndex];
    var itemState = listStates[draggedListIndex].itemStates[draggedItemIndex];
    widget.lists[draggedListIndex].items.removeAt(draggedItemIndex);
    listStates[draggedListIndex].itemStates.removeAt(draggedItemIndex);
    if(listStates[draggedListIndex].mounted) {
      listStates[draggedListIndex].setState(() {});
    }
    draggedListIndex++;
    double closestValue = 10000;
    draggedItemIndex = 0;
    for (int i = 0; i < listStates[draggedListIndex].itemStates.length; i++) {
      if (listStates[draggedListIndex].itemStates[i].mounted && listStates[draggedListIndex].itemStates[i].context != null) {
        RenderBox box = listStates[draggedListIndex].itemStates[i].context.findRenderObject();
        Offset pos = box.localToGlobal(Offset.zero);
        var temp = (pos.dy - dy + (box.size.height / 2)).abs();
        if (temp < closestValue) {
          closestValue = temp;
          draggedItemIndex = i;
          dyInit = dy;
        }
      }
    }
    widget.lists[draggedListIndex].items.insert(draggedItemIndex, item);
    listStates[draggedListIndex].itemStates.insert(draggedItemIndex, itemState);
    canDrag = false;
    if(listStates[draggedListIndex].mounted) {
      listStates[draggedListIndex].setState(() {});
    }
    if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
      int tempListIndex = draggedListIndex;
      int tempItemIndex = draggedItemIndex;
      kanbanMainViewController
          .animateTo(draggedListIndex * widget.width, duration: new Duration(milliseconds: 50), curve: Curves.ease)
          .whenComplete(() {
        RenderBox object = listStates[tempListIndex].context.findRenderObject();
        Offset pos = object.localToGlobal(Offset.zero);
        leftListX = pos.dx;
        rightListX = pos.dx + object.size.width;
        RenderBox box = listStates[tempListIndex].itemStates[tempItemIndex].context.findRenderObject();
        Offset itemPos = box.localToGlobal(Offset.zero);
        topItemY = itemPos.dy;
        bottomItemY = itemPos.dy + box.size.height;
        Future.delayed(new Duration(milliseconds: widget.dragDelay), () {
          canDrag = true;
        });
      });
    }
    if(mounted){
      setState(() { });
    }
  }

  void moveListLeft() {
    var list = widget.lists[draggedListIndex];
    var listState = listStates[draggedListIndex];
    widget.lists.removeAt(draggedListIndex);
    listStates.removeAt(draggedListIndex);
    draggedListIndex--;
    widget.lists.insert(draggedListIndex, list);
    listStates.insert(draggedListIndex, listState);
    canDrag = false;
    if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
      int tempListIndex = draggedListIndex;
      kanbanMainViewController
          .animateTo(draggedListIndex * widget.width, duration: new Duration(milliseconds: widget.dragDelay), curve: Curves.ease)
          .whenComplete(() {
        RenderBox object = listStates[tempListIndex].context.findRenderObject();
        Offset pos = object.localToGlobal(Offset.zero);
        leftListX = pos.dx;
        rightListX = pos.dx + object.size.width;
        Future.delayed(new Duration(milliseconds: widget.dragDelay), () {
          canDrag = true;
        });
      });
    }
    if(mounted) {
      setState(() {});
    }
  }

  void moveLeft() {
    var item = widget.lists[draggedListIndex].items[draggedItemIndex];
    var itemState = listStates[draggedListIndex].itemStates[draggedItemIndex];
    widget.lists[draggedListIndex].items.removeAt(draggedItemIndex);
    listStates[draggedListIndex].itemStates.removeAt(draggedItemIndex);
    if(listStates[draggedListIndex].mounted) {
      listStates[draggedListIndex].setState(() {});
    }
    draggedListIndex--;
    double closestValue = 10000;
    draggedItemIndex = 0;
    for (int i = 0; i < listStates[draggedListIndex].itemStates.length; i++) {
      if (listStates[draggedListIndex].itemStates[i].mounted && listStates[draggedListIndex].itemStates[i].context != null) {
        RenderBox box = listStates[draggedListIndex].itemStates[i].context.findRenderObject();
        Offset pos = box.localToGlobal(Offset.zero);
        var temp = (pos.dy - dy + (box.size.height / 2)).abs();
        if (temp < closestValue) {
          closestValue = temp;
          draggedItemIndex = i;
          dyInit = dy;
        }
      }
    }
    widget.lists[draggedListIndex].items.insert(draggedItemIndex, item);
    listStates[draggedListIndex].itemStates.insert(draggedItemIndex, itemState);
    canDrag = false;
    if(listStates[draggedListIndex].mounted) {
      listStates[draggedListIndex].setState(() {});
    }
    if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
      int tempListIndex = draggedListIndex;
      int tempItemIndex = draggedItemIndex;
      kanbanMainViewController
          .animateTo(draggedListIndex * widget.width, duration: new Duration(milliseconds: 50), curve: Curves.ease)
          .whenComplete(() {
        RenderBox object = listStates[tempListIndex].context.findRenderObject();
        Offset pos = object.localToGlobal(Offset.zero);
        leftListX = pos.dx;
        rightListX = pos.dx + object.size.width;
        RenderBox box = listStates[tempListIndex].itemStates[tempItemIndex].context.findRenderObject();
        Offset itemPos = box.localToGlobal(Offset.zero);
        topItemY = itemPos.dy;
        bottomItemY = itemPos.dy + box.size.height;
        Future.delayed(new Duration(milliseconds: widget.dragDelay), () {
          canDrag = true;
        });
      });
    }
    if(mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("dy:${dy}");
    print("topListY:${topListY}");
    print("bottomListY:${bottomListY}");
    List<Widget> stackWidgets = <Widget>[
      ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: widget.lists.length,
        scrollDirection: Axis.horizontal,
        controller: kanbanMainViewController,
        itemBuilder: (BuildContext context, int index) {
          if (widget.lists[index].kanbanMainView == null) {
            widget.lists[index] = KanbanList(
              items: widget.lists[index].items,
              headerBackgroundColor: widget.lists[index].headerBackgroundColor,
              backgroundColor: widget.lists[index].backgroundColor,
              footer: widget.lists[index].footer,
              header: widget.lists[index].header,
              kanbanMainView: this,
              draggable: widget.lists[index].draggable,
              onDropList: widget.lists[index].onDropList,
              onTapList: widget.lists[index].onTapList,
              onStartDragList: widget.lists[index].onStartDragList,
            );
          }
          if (widget.lists[index].index != index) {
            widget.lists[index] = KanbanList(
              items: widget.lists[index].items,
              headerBackgroundColor: widget.lists[index].headerBackgroundColor,
              backgroundColor: widget.lists[index].backgroundColor,
              footer: widget.lists[index].footer,
              header: widget.lists[index].header,
              kanbanMainView: this,
              draggable: widget.lists[index].draggable,
              index: index,
              onDropList: widget.lists[index].onDropList,
              onTapList: widget.lists[index].onTapList,
              onStartDragList: widget.lists[index].onStartDragList,
            );
          }

          var temp = Container(
              width: widget.width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, widget.bottomPadding ?? 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Expanded(child: widget.lists[index])],
              ));
          if (draggedListIndex == index && draggedItemIndex == null) {
            return Opacity(
              opacity: 0.0,
              child: temp,
            );
          } else {
            return temp;
          }
        },
      )
    ];
    bool isInBottomWidget = false;
    if (dy != null) {
      if (MediaQuery.of(context).size.height - dy < 80) {
        isInBottomWidget = true;
      }
    }
    if(widget.itemInMiddleWidget != null && _isInWidget != isInBottomWidget) {
      widget.itemInMiddleWidget(isInBottomWidget);
      _isInWidget = isInBottomWidget;
    }
    if (initialX != null &&
        initialY != null &&
        offsetX != null &&
        offsetY != null &&
        dx != null &&
        dy != null &&
        height != null &&
        widget.width != null) {
      if (canDrag && dxInit != null && dyInit != null && !isInBottomWidget) {
        if (draggedItemIndex != null && draggedItem != null && topItemY != null && bottomItemY != null) {
          //dragging item
          if (0 <= draggedListIndex - 1 && dx < leftListX + 45) {
            //scroll left
            if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
              kanbanMainViewController.animateTo(kanbanMainViewController.position.pixels - 5,
                  duration: new Duration(milliseconds: 10), curve: Curves.ease);
              if(listStates[draggedListIndex].mounted) {
                RenderBox object = listStates[draggedListIndex].context
                    .findRenderObject();
                Offset pos = object.localToGlobal(Offset.zero);
                leftListX = pos.dx;
                rightListX = pos.dx + object.size.width;
              }
            }
          }
          if (widget.lists.length > draggedListIndex + 1 && dx > rightListX - 45) {
            //scroll right
            if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
              kanbanMainViewController.animateTo(kanbanMainViewController.position.pixels + 5,
                  duration: new Duration(milliseconds: 10), curve: Curves.ease);
              if(listStates[draggedListIndex].mounted) {
                RenderBox object = listStates[draggedListIndex].context
                    .findRenderObject();
                Offset pos = object.localToGlobal(Offset.zero);
                leftListX = pos.dx;
                rightListX = pos.dx + object.size.width;
              }
            }
          }
          if (0 <= draggedListIndex - 1 && dx < leftListX) {
            //move left
            moveLeft();
          }
          if (widget.lists.length > draggedListIndex + 1 && dx > rightListX) {
            //move right
            moveRight();
          }
          if (dy < topListY + 70) {
            //scroll up
            if (listStates[draggedListIndex].kanbanListController != null &&
                listStates[draggedListIndex].kanbanListController.hasClients && !isScrolling) {
              isScrolling = true;
              double pos = listStates[draggedListIndex].kanbanListController.position.pixels;
              listStates[draggedListIndex].kanbanListController.animateTo(
                  listStates[draggedListIndex].kanbanListController.position.pixels - 5,
                  duration: new Duration(milliseconds: 10),
                  curve: Curves.ease).whenComplete((){

                pos -= listStates[draggedListIndex].kanbanListController.position.pixels;
                if(initialY == null)
                  initialY = 0;
//                if(widget.kanbanMainViewController != null) {
//                  initialY -= pos;
//                }
                isScrolling = false;
                if(topItemY != null) {
                  topItemY += pos;
                }
                if(bottomItemY != null) {
                  bottomItemY += pos;
                }
                if(mounted){
                  setState(() { });
                }
              });
            }
          }
          if (0 <= draggedItemIndex - 1 &&
              dy < topItemY - listStates[draggedListIndex].itemStates[draggedItemIndex - 1].height / 2) {
            //move up
            moveUp();
          }
          double tempBottom = bottomListY;
          if(widget.middleWidget != null){
            if(_middleWidgetKey.currentContext != null) {
              RenderBox _box = _middleWidgetKey.currentContext
                  .findRenderObject();
              tempBottom = _box.size.height;
              print("tempBottom:${tempBottom}");
            }
          }
          if (dy > tempBottom - 70) {
            //scroll down

            if (listStates[draggedListIndex].kanbanListController != null &&
                listStates[draggedListIndex].kanbanListController.hasClients) {
              isScrolling = true;
              double pos = listStates[draggedListIndex].kanbanListController.position.pixels;
              listStates[draggedListIndex].kanbanListController.animateTo(
                  listStates[draggedListIndex].kanbanListController.position.pixels + 5,
                  duration: new Duration(milliseconds: 10),
                  curve: Curves.ease).whenComplete((){
                pos -= listStates[draggedListIndex].kanbanListController.position.pixels;
                if(initialY == null)
                  initialY = 0;
//                if(widget.kanbanMainViewController != null) {
//                  initialY -= pos;
//                }
                isScrolling = false;
                if(topItemY != null) {
                  topItemY += pos;
                }
                if(bottomItemY != null) {
                  bottomItemY += pos;
                }
                if(mounted){
                  setState(() {});
                }
              });
            }
          }
          if (widget.lists[draggedListIndex].items.length > draggedItemIndex + 1 &&
              dy > bottomItemY + listStates[draggedListIndex].itemStates[draggedItemIndex + 1].height / 2) {
            //move down
            moveDown();
          }
        } else {
          //dragging list
          if (0 <= draggedListIndex - 1 && dx < leftListX + 45) {
            //scroll left
            if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
              kanbanMainViewController.animateTo(kanbanMainViewController.position.pixels - 5,
                  duration: new Duration(milliseconds: 10), curve: Curves.ease);
              leftListX += 5;
              rightListX += 5;
            }
          }

          if (widget.lists.length > draggedListIndex + 1 && dx > rightListX - 45) {
            //scroll right
            if (kanbanMainViewController != null && kanbanMainViewController.hasClients) {
              kanbanMainViewController.animateTo(kanbanMainViewController.position.pixels + 5,
                  duration: new Duration(milliseconds: 10), curve: Curves.ease);
              leftListX -= 5;
              rightListX -= 5;
            }
          }
          if (widget.lists.length > draggedListIndex + 1 && dx > rightListX) {
            //move right
            moveListRight();
          }
          if (0 <= draggedListIndex - 1 && dx < leftListX) {
            //move left
            moveListLeft();
          }
        }
      }
      if (widget.middleWidget != null) {
        stackWidgets.add(Container(key:_middleWidgetKey,child:widget.middleWidget));
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if(mounted){
          setState(() {});
        }
      });
      stackWidgets.add(Positioned(
        width: widget.width,
        height: height,
        child: Opacity(opacity: .7, child: draggedItem),
        left: (dx - offsetX) + initialX,
        top: (dy - offsetY) + initialY,
      ));
    }

    return Container(
        child: Listener(
            onPointerMove: (opm) {
              if (draggedItem != null) {
                if (dxInit == null) {
                  dxInit = opm.position.dx;
                }
                if (dyInit == null) {
                  dyInit = opm.position.dy;
                }
                dx = opm.position.dx;
                dy = opm.position.dy;
                if(mounted) {
                  setState(() {});
                }
              }
            },
            onPointerDown: (opd) {
              RenderBox box = context.findRenderObject();
              Offset pos = box.localToGlobal(opd.position);
              offsetX = pos.dx;
              offsetY = pos.dy;
              pointer = opd;
              if(mounted) {
                setState(() {});
              }
            },
            onPointerUp: (opu) {
              if (onDropItem != null) {
                int tempDraggedItemIndex = draggedItemIndex;
                int tempDraggedListIndex = draggedListIndex;
                int startDraggedItemIndex = startItemIndex;
                int startDraggedListIndex = startListIndex;

                if(_isInWidget && widget.onDropItemInMiddleWidget != null){
                  onDropItem(startDraggedListIndex, startDraggedItemIndex);
                  widget.onDropItemInMiddleWidget(startDraggedListIndex, startDraggedItemIndex,opu.position.dx/MediaQuery.of(context).size.width);
                }else{
                  onDropItem(tempDraggedListIndex, tempDraggedItemIndex);
                }
              }
              if (onDropList != null) {
                int tempDraggedListIndex = draggedListIndex;
                if(_isInWidget && widget.onDropItemInMiddleWidget != null){
                  onDropList(tempDraggedListIndex);
                  widget.onDropItemInMiddleWidget(tempDraggedListIndex,null,opu.position.dx/MediaQuery.of(context).size.width);
                }else{
                  onDropList(tempDraggedListIndex);
                }
              }
              draggedItem = null;
              offsetX = null;
              offsetY = null;
              initialX = null;
              initialY = null;
              dx = null;
              dy = null;
              draggedItemIndex = null;
              draggedListIndex = null;
              onDropItem = null;
              onDropList = null;
              dxInit = null;
              dyInit = null;
              leftListX = null;
              rightListX = null;
              topListY = null;
              bottomListY = null;
              topItemY = null;
              bottomItemY = null;
              startListIndex = null;
              startItemIndex = null;
              if(mounted) {
                setState(() {});
              }
            },
            child: new Stack(
              children: stackWidgets,
            )));
  }

  void run() {
    if (pointer != null) {
      dx = pointer.position.dx;
      dy = pointer.position.dy;
      if(mounted) {
        setState(() {});
      }
    }
  }
}