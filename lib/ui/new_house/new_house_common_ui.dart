import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// Created by yangyangyang on 2020/3/25 3:30 PM.
/// 新房入伙控件
///
///

const String newHousePayTypeTS = 'TS'; //缴费形式：托收
const String newHousePayTypeXJ = 'XJ'; //缴费形式：现金


//新房入伙操作环节
const String newHouseOperateTJ = "TJ";//提交申请
const String newHouseOperateSH = "SH";//提交审核
const String newHouseOperateXG = "XG";//提交修改
const String newHouseOperateYS = "YS";//提交验收
const String newHouseOperateWYYS = "WYYS";//物业验收
const String newHouseOperateCH = "CH";//撤回


const String newHouseStatusDQR = 'DQR'; //待审核
const String newHouseStatusDXG = 'DXG'; //审核不通过
const String newHouseStatusDYS = 'DYS'; //待验收
const String newHouseStatusYGD = 'YGD'; //已验收
const String newHouseStatusYCH = 'YCH'; //已撤回

//新房入伙状态显示颜色：DQR-待审核，DXG-审核不通过，DYS-待验收，YGD-已验收，YCH-已撤回
const Map<String, Color> newHouseStatusToColorMap = {
  newHouseStatusDQR: UIData.yellowColor,
  newHouseStatusDXG: UIData.lightRedColor,
  newHouseStatusDYS: UIData.yellowColor,
  newHouseStatusYGD: UIData.greenColor,
  newHouseStatusYCH: UIData.greyColor,
  null: UIData.yellowColor,
};

/*
  带背景色的选择器里使用的对象
 */
class ColorCheckViewObj {
  String name;
  dynamic key;
  bool isChecked = false;
}

/*
  带背景色的选择器
 */
class ColorCheckView extends StatefulWidget {
  List<ColorCheckViewObj> myList;
  bool isCheckBox; //默认单选
  ColorCheckView(this.myList, {this.isCheckBox = false});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ColorCheckView(myList);
  }
}

class _ColorCheckView extends State<ColorCheckView> {
  List<ColorCheckViewObj> myList;

  _ColorCheckView(this.myList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  List<Widget> getSpcWidgetList() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < myList.length; i++) {
      widgetList.add(ChoiceChip(
        label: Text(myList[i].name ?? ''),
        selected: myList[i].isChecked ?? false,
        selectedColor: UIData.themeBgColor,
        backgroundColor: Color(0xFFEFEFEF),
        labelStyle: myList[i].isChecked ?? false
            ? TextStyle(
                color: UIData.primaryColor,
                fontSize: UIData.fontSize14,
              )
            : TextStyle(
                color: UIData.lightGreyColor,
                fontSize: UIData.fontSize14,
              ),
        onSelected: (bool value) {
          setState(() {
            if (!widget.isCheckBox) {
              myList.forEach((ColorCheckViewObj obj) {
                obj.isChecked = false;
              });
            }
            myList[i].isChecked = value;
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(UIData.spaceSize12 + UIData.spaceSize3)),
      ));
    }

    return widgetList;
  }
}

///
/// 单个卡片
/// [canOperate]是否可操作，详情不可操作，新建或修改可以编辑和删除
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
///
class SingleCard extends StatefulWidget {
  final String title;
  final int index;
  final bool canOperate;
  final Function callback;
final Widget contentWidget;

  SingleCard(this.title,this.index, this.canOperate,
      {Key key, this.contentWidget,this.callback,})
      : super(key: key);

  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    _initData();
    return Container(
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: UIData.spaceSize16),
            dense: true,
            title: Container(
                child: CommonText.darkGrey15Text(widget.title??'')),
            trailing: widget.canOperate
                ? Offstage(
                    offstage: widget.index == 0,
                    child: IconButton(
                        icon: UIData.iconCloseOutline,
                        onPressed: () {
                          if (widget.callback != null)
                            widget.callback(
                                widget.index);
                        }))
                : null,
          ),
          CommonDivider(),
          widget.contentWidget!=null?widget.contentWidget:Container()
        ],
      ),
    );
  }
}

class ChoiceTap extends StatelessWidget {
  final String tag;
  final String keys;
  final String value;
  final GestureTapCallback onTap;

  ChoiceTap(this.tag, this.keys, this.value, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: keys == tag ? UIData.themeBgColor : UIData.dividerColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize6),
          child: CommonText.text15(value, color: keys == tag ? UIData.primaryColor : UIData.lightGreyColor),
        ),
        onTap: onTap);
  }
}


//左边带主题色边框的文字标题
class TextWithLeftBorder extends StatelessWidget {
  final String text;

  TextWithLeftBorder(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: UIData.spaceSize12),
      decoration:
      BoxDecoration(border: Border(left: BorderSide(color: UIData.themeBgColor, width: UIData.spaceSize4))),
      child:
      Container(padding: EdgeInsets.only(left: UIData.spaceSize2), child: CommonText.darkGrey17Text(text ?? '')),
    );
  }
}