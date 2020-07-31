import 'dart:core';

import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CupertinoPopoverMenuList extends StatelessWidget {
  final List<Widget> children;

  const CupertinoPopoverMenuList({this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.greyColor,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: children.length * 2 - 1,
        shrinkWrap: true,
//        itemCount: children.length,
        itemBuilder: (context, int i) {
          if (i.isOdd) {
            // 在每一列之前，添加一个1像素高的分隔线widget
            return CommonDivider();
          }
          final int index = i ~/ 2;
          return children[index];
//          return children[i];
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}


class CupertinoPopoverMenuItemWithIcon extends StatefulWidget {
  final Widget leading;
  final Widget child;
  final GestureTapCallback onTap;
  final bool isTapClosePopover;

  const CupertinoPopoverMenuItemWithIcon({this.leading, this.child, this.onTap, this.isTapClosePopover = true});

  @override
  State<StatefulWidget> createState() => CupertinoPopoverMenuItemWithIconState();
}

class CupertinoPopoverMenuItemWithIconState extends State<CupertinoPopoverMenuItemWithIcon> {
  bool isDown = false;

  Widget _buildWidget() {
    return GestureDetector(
      child: Container(
//        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize10),
        color: isDown ? UIData.darkGreyColor : UIData.greyColor,
        child: Row(

          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: UIData.spaceSize10),
              child: IconTheme(data: IconThemeData(color: Colors.white, size: UIData.fontSize16), child: widget.leading),
            ),
           SizedBox(width: UIData.spaceSize8,),
           DefaultTextStyle(
                    style: TextStyle(color: Colors.white, fontSize: UIData.fontSize14), child: widget.child)
          ],
        ),
      ),
      onTapDown: (detail) {
        setState(() {
          isDown = true;
        });
      },
      onTapUp: (detail) {
        if (isDown) {
          setState(() {
            isDown = false;
          });
//          if(widget.onTap != null){
//            return widget.onTap;
//          }
          if (widget.isTapClosePopover) {
            Navigator.of(context).pop();
          }
        }
      },
      onTap: widget.onTap,
      onTapCancel: () {
        if (isDown) {
          setState(() {
            isDown = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
//    List<Widget> widgets = [];
//    if (widget.leading != null) {
//      widgets.add(Container(
//        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize12, vertical: UIData.spaceSize12),
////        width: UIData.spaceSize30,
////        height: UIData.spaceSize30,
//        child: IconTheme(data: IconThemeData(color: Colors.white, size: 20.0), child: widget.leading),
//      ));
//    }
//    widgets.add(Expanded(
//        child: DefaultTextStyle(
//            style: TextStyle(color: Colors.white, fontSize: UIData.fontSize14), child: widget.child)));
//    return GestureDetector(
//      onTapDown: (detail) {
//        setState(() {
//          isDown = true;
//        });
//      },
//      onTapUp: (detail) {
//        if (isDown) {
//          setState(() {
//            isDown = false;
//          });
//          if (widget.onTap != null && widget.onTap()) {
//            return;
//          }
//          if (widget.isTapClosePopover) {
//            Navigator.of(context).pop();
//          }
//        }
//      },
//      onTapCancel: () {
//        if (isDown) {
//          setState(() {
//            isDown = false;
//          });
//        }
//      },
//      child: Container(
//        color: isDown ? UIData.darkGreyColor : UIData.greyColor,
////        padding: EdgeInsets.only(top:2.5,bottom: 2.5),
//        child: Row(children: widgets),
//      ),
//    );
  }
}

class CupertinoPopoverMenuItem extends StatefulWidget {
  final Widget leading;
  final Widget child;
  final GestureTapCallback onTap;
  final bool isTapClosePopover;

  const CupertinoPopoverMenuItem({this.leading, this.child, this.onTap, this.isTapClosePopover = true});

  @override
  State<StatefulWidget> createState() => CupertinoPopoverMenuItemState();
}

class CupertinoPopoverMenuItemState extends State<CupertinoPopoverMenuItem> {
  bool isDown = false;

  Widget _buildWidget() {
    return GestureDetector(
      child: Container(
       padding: EdgeInsets.symmetric(vertical: UIData.spaceSize6,horizontal: UIData.spaceSize8),
        color: isDown ? UIData.darkGreyColor : UIData.greyColor,
        child: DefaultTextStyle(
            style: TextStyle(color: Colors.white, fontSize: UIData.fontSize14), child: widget.child),
      ),
      onTapDown: (detail) {
        setState(() {
          isDown = true;
        });
      },
      onTapUp: (detail) {
        if (isDown) {
          setState(() {
            isDown = false;
          });
//          if(widget.onTap != null){
//            return widget.onTap;
//          }
          if (widget.isTapClosePopover) {
            Navigator.of(context).pop();
          }
        }
      },
      onTap: widget.onTap,
      onTapCancel: () {
        if (isDown) {
          setState(() {
            isDown = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
//    List<Widget> widgets = [];
//    if (widget.leading != null) {
//      widgets.add(Container(
//        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize12, vertical: UIData.spaceSize12),
////        width: UIData.spaceSize30,
////        height: UIData.spaceSize30,
//        child: IconTheme(data: IconThemeData(color: Colors.white, size: 20.0), child: widget.leading),
//      ));
//    }
//    widgets.add(Expanded(
//        child: DefaultTextStyle(
//            style: TextStyle(color: Colors.white, fontSize: UIData.fontSize14), child: widget.child)));
//    return GestureDetector(
//      onTapDown: (detail) {
//        setState(() {
//          isDown = true;
//        });
//      },
//      onTapUp: (detail) {
//        if (isDown) {
//          setState(() {
//            isDown = false;
//          });
//          if (widget.onTap != null && widget.onTap()) {
//            return;
//          }
//          if (widget.isTapClosePopover) {
//            Navigator.of(context).pop();
//          }
//        }
//      },
//      onTapCancel: () {
//        if (isDown) {
//          setState(() {
//            isDown = false;
//          });
//        }
//      },
//      child: Container(
//        color: isDown ? UIData.darkGreyColor : UIData.greyColor,
////        padding: EdgeInsets.only(top:2.5,bottom: 2.5),
//        child: Row(children: widgets),
//      ),
//    );
  }
}
