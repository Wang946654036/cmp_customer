import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum KEYBOARD_TYPE {
  PROVINCE, //省简称
  LETTER, //字母和数字
}

///
/// 车牌号键盘
///
class CarNoInputKeyboard extends StatefulWidget {
  final String carNo;
  final Function onConfirm;
  final Function onCancel;

  CarNoInputKeyboard({this.carNo, this.onCancel, this.onConfirm, Key key}) : super(key: key);

  @override
  CarNoInputKeyboardState createState() => CarNoInputKeyboardState();
}

class CarNoInputKeyboardState extends State<CarNoInputKeyboard> {
  KEYBOARD_TYPE _keyboardType = KEYBOARD_TYPE.PROVINCE; //车牌号键盘类型
  String _carNo = '';

  @override
  void initState() {
    super.initState();
    _carNo = widget.carNo ?? '';
  }

  void refreshCarNo(String carNo) {
    setState(() {
      _carNo = carNo;
      _setKeyboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Center(
            child: Container(
              height: ScreenUtil().setHeight(65),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(UIData.imageCarNoBg))),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
              alignment: Alignment.center,
              child: CommonText.black26Text(_carNo),
            ),
          )),
          Container(
            height: ScreenUtil().setHeight(320),
            color: UIData.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
//                    padding: EdgeInsets.symmetric(vertical: UIData.spaceSize14, horizontal: UIData.spaceSize20),
                  padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          child: CommonText.red16Text('取消'),
                          onTap: () {
//                              _cancelPlateNumber();
                            if (widget.onCancel != null) widget.onCancel();
                          }),
                      CommonText.darkGrey18Text('请选择车牌号'),
                      GestureDetector(
                          child: CommonText.red16Text('确定'),
                          onTap: () {
                            if (widget.onConfirm != null) widget.onConfirm(_carNo);
//                              model.plateNumberShow = model.plateNumber;
                          }),
                    ],
                  ),
                )),
                Container(
                    height: ScreenUtil().setHeight(276),
                    child: Wrap(
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, childAspectRatio: 1.6),
                      children: _buildKeyboard(),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  //车牌号输入键盘
  List<Widget> _buildKeyboard() {
    List<Widget> listWidget = List();
//    List<String> lists = _keyboardList;
    _keyboardList.forEach((String value) {
      listWidget.add(GestureDetector(
        onTap: () {
          setState(() {
            _carNo += value;
            _setKeyboard();
          });
        },
        child: Container(
          width: ScreenUtil().setWidth(62),
          height: ScreenUtil().setHeight(46),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: UIData.dividerColor, width: 0.5),
          ),
          child: CommonText.black16Text(value),
        ),
      ));
    });
    //一个空格
    listWidget.add(Container(width: ScreenUtil().setWidth(62), height: ScreenUtil().setHeight(46)));
    //删除按钮
    listWidget.add(GestureDetector(
        child: Container(
          color: UIData.dividerColor,
          width: ScreenUtil().setWidth(62),
          height: ScreenUtil().setHeight(46),
          child: UIData.iconCarNoKeyboardDelete,
        ),
        onTap: () {
          _backSpacePlateNumber();
        }));
    return listWidget;
  }

  List<String> get _keyboardList {
    if (_keyboardType == KEYBOARD_TYPE.PROVINCE)
      return StringsHelper.provinceAbbrList;
    else
      return StringsHelper.letterList;
  }

  _setKeyboard() {
    setState(() {
      if (_carNo.length == 1) {
        _keyboardType = KEYBOARD_TYPE.LETTER;
      } else if (_carNo.length == 0) {
        _keyboardType = KEYBOARD_TYPE.PROVINCE;
      }
    });
//    notifyListeners();
  }

  _backSpacePlateNumber() {
    _carNo = _carNo.substring(0, _carNo.length - 1);
    _setKeyboard();
  }

  //点击键盘取消输入
  _cancelPlateNumber() {
    _carNo = '';
//    _showPlateNoInputView = false;
    _setKeyboard();
  }
}
