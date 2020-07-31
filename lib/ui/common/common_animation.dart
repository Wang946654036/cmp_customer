import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

//箭头旋转动画
class ArrowRotateWidget extends StatefulWidget {
  ValueChanged<bool> onChanged;//
  ArrowRotateWidget(this.onChanged);
  @override
  State<StatefulWidget> createState() {
    return new _ArrowRotate();
  }
}

class _ArrowRotate extends State<ArrowRotateWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> rotate;
  AnimationStatus _status = AnimationStatus.dismissed;//默认


  void _initController() {
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  void _initAni() {
    rotate = Tween<double>(
      begin: 0.0,
      end: math.pi ,
    ).animate(
        _controller
    )
      ..addListener(() {
//        print(rotate.value);
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          _status=status;
        });
      });
  }

   _startAnimation()  {
    try {
      if(_status==AnimationStatus.dismissed) {
         _controller.forward();
         if(widget.onChanged!=null){
           widget.onChanged(true);
         }
      }else if(_status==AnimationStatus.completed){
         _controller.reverse();
         if(widget.onChanged!=null){
           widget.onChanged(false);
         }
      }
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _initAni();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
          //旋转90度
          angle: rotate.value,
          child: IconButton(
            icon:Icon(Icons.keyboard_arrow_down),
            color: UIData.lighterGreyColor,
            onPressed: (){
              _startAnimation();
            },
          ),
        );
  }
}

//// 帧动画Image
//class FrameAnimationImage extends StatefulWidget {
//  final List<String> _assetList;
//  final double width;
//  final double height;
//  int interval = 200;
//  bool paly;
//
//  FrameAnimationImage(this._assetList, {this.paly=true,this.width, this.height, this.interval});
//
//  @override
//  State<StatefulWidget> createState() {
//    return _FrameAnimationImageState();
//  }
//}

//class _FrameAnimationImageState extends State<FrameAnimationImage>
//    with SingleTickerProviderStateMixin {
//  // 动画控制
//  Animation<double> _animation;
//  AnimationController _controller;
//  int interval = 200;
//
//  @override
//  void initState() {
//    super.initState();
//
//    if (widget.interval != null) {
//      interval = widget.interval;
//    }
//    final int imageCount = widget._assetList.length;
//    final int maxTime = interval * imageCount;
//
//    if(_controller==null){
//      // 启动动画controller
//      _controller = new AnimationController(
//          duration: Duration(milliseconds: maxTime), vsync: this);
//      _controller.addStatusListener((AnimationStatus status) {
//        if(status == AnimationStatus.completed) {
//          _controller.forward(from: 0.0); // 完成后重新开始
//        }
//      });
//    }
//
//    _animation = new Tween<double>(begin: 0, end: imageCount.toDouble()).animate(_controller)
//      ..addListener(() {
//        setState(() {
//          // the state that has changed here is the animation object’s value
//        });
//      });
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    int ix = _animation.value.floor() % widget._assetList.length;
//
//    List<Widget> images = [];
//    // 把所有图片都加载进内容，否则每一帧加载时会卡顿
//    for (int i = 0; i < widget._assetList.length; ++i) {
//      if (i != ix) {
//        images.add(Image.asset(
//          widget._assetList[i],
//          width: 0,
//          height: 0,
//        ));
//      }
//    }
//
//    images.add( Image.asset(
//      widget._assetList[ix],
//      width: widget.width,
//      height: widget.height,
//    ) );
//
//
//
//    if(widget.paly&&!_controller.isAnimating){
//      _controller.forward();
//    }else{
//      _controller.dispose();
//    }
//    return Stack(
//        alignment: AlignmentDirectional.center,
//        children: images);
//  }
//}
