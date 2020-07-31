import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 星级评分
///
class CommonStarRating extends StatefulWidget {
  final int count;
  final double starSize;
  final double spacing;
  final bool enableClick;
  final Function onStar;

  CommonStarRating({this.count, this.starSize = 14, this.spacing = 0, this.enableClick = false, this.onStar});

  @override
  _CommonStarRatingState createState() => _CommonStarRatingState();
}

class _CommonStarRatingState extends State<CommonStarRating> {
  int _clickCount = 5;

  Widget _singleStar(Color color, int index, bool selected) {
    return GestureDetector(
        child: Icon(
          selected ? UIData.iconDataStartSelected : UIData.iconDataStartUnselected,
          color: selected ? color : UIData.lighterGreyColor,
          size: widget.starSize,
        ),
        onTap: () {
          if (widget.enableClick) {
            setState(() {
              _clickCount = index;
              widget.onStar(index);
            });
          }
        });
  }

  List<Widget> _getStarList() {
    return [
      _singleStar(UIData.redGradient5, 1, !(widget.enableClick && _clickCount < 1)),
      _singleStar(UIData.redGradient4, 2, !(widget.enableClick && _clickCount < 2)),
      _singleStar(UIData.redGradient3, 3, !(widget.enableClick && _clickCount < 3)),
      _singleStar(UIData.redGradient2, 4, !(widget.enableClick && _clickCount < 4)),
      _singleStar(UIData.redGradient1, 5, !(widget.enableClick && _clickCount < 5)),
    ];
  }

  List<Widget> _getStarRating(int count) {
    List<Widget> list = List();
    for (int i = 0; i < count; i++) {
      list.add(_getStarList()[i]);
      if (i != count - 1) {
        list.add(SizedBox(width: widget.spacing));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _getStarRating(widget.enableClick ? 5 : widget.count),
    );
  }
}
