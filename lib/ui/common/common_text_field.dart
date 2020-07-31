import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 登录样式的输入框
///
class LoginTypeTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool pwdVisible;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final ValueChanged<String> onSubmitted;
  final double heightBackGround;
  final TextAlign textAlign;
  final Widget prefixIcon;
  final double fontSize;
  final bool showCancelBtn;
  final int maxLength;
  final bool autoFocus;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String> onChanged;
  final bool enabled;

  LoginTypeTextField({
    this.controller,
    this.hintText,
    this.pwdVisible = false,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
    this.heightBackGround,
    this.textAlign,
    this.prefixIcon,
    this.fontSize,
    this.showCancelBtn = true,
    this.maxLength,
    this.autoFocus = false,
    this.padding,
    this.onChanged,
    this.enabled = true,
  });

  @override
  _LoginTypeTextFieldState createState() => _LoginTypeTextFieldState();
}

class _LoginTypeTextFieldState extends State<LoginTypeTextField> {
  bool cancelVisible = false;
  IconData iconPwd = Icons.visibility_off;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller.addListener(() {
        if (mounted ?? false) {
          setState(() {
            if (widget.controller.text.isNotEmpty)
              cancelVisible = true;
            else
              cancelVisible = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightBackGround,
      padding: widget.padding,
      child: TextField(
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        controller: widget.controller,
//        maxLength: widget.maxLength,
        autofocus: widget.autoFocus,
        enabled: widget.enabled,
        decoration: InputDecoration(
//            isDense: true,
            border: InputBorder.none,
            hintText: widget.hintText,
            suffixIcon: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
//                      widget.controller.clear();
                      // 保证在组件build的第一帧时才去触发取消清空内容
                      WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.clear());
                      cancelVisible = false;
                    });
                  },
                  child: Visibility(
                      visible: widget.showCancelBtn && cancelVisible,
                      child: Icon(
                        Icons.cancel,
                        color: UIData.lightGreyColor,
                        size: UIData.fontSize16,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (iconPwd == Icons.visibility_off) {
                        iconPwd = Icons.visibility;
                        obscureText = false;
                      } else {
                        iconPwd = Icons.visibility_off;
                        obscureText = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: UIData.spaceSize8, right: UIData.spaceSize8),
                    child: Visibility(
                        visible: widget.pwdVisible,
                        child: Icon(
                          iconPwd,
                          color: UIData.lightGreyColor,
                          size: UIData.fontSize16,
                        )),
                  ),
                )
              ],
            )),
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength ?? 20)
        ],
        obscureText: widget.pwdVisible ? obscureText : false,
        style: TextStyle(
            color: UIData.darkGreyColor,
            fontSize: widget.fontSize ?? UIData.fontSize16),
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
      ),
    );
  }
}

///
/// 公用搜索条（左边搜索输入框，右边搜索按钮）
///
class CommonSearchBar extends StatefulWidget {
  final backgroundColor;
  final hintText;
  final padding;
  final Function onSearch;
  final TextEditingController controller;

//  final ValueChanged<String> onChanged;
  CommonSearchBar({
    this.backgroundColor = UIData.scaffoldBgColor,
    this.hintText = '',
    this.padding,
    this.onSearch,
    this.controller,
//    this.onChanged,
  });

  @override
  _CommonSearchBarState createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller == null)
      _controller = TextEditingController();
    else
      _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.primaryColor,
      alignment: Alignment.centerLeft,
      padding: widget.padding ??
          EdgeInsets.symmetric(
              horizontal: UIData.spaceSize16, vertical: UIData.spaceSize8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
                  decoration: BoxDecoration(
                      color: UIData.scaffoldBgColor,
                      borderRadius: BorderRadius.circular(1.0)),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: UIData.spaceSize30,
                        height: UIData.spaceSize30,
                        child: Icon(
                          Icons.search,
                          color: UIData.lighterGreyColor,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: TextField(
                          style: CommonText.darkGrey14TextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            hintStyle: CommonText.lightGrey14TextStyle(),
                            isDense: true,
                          ),
                          controller: _controller,
//                          onChanged: onChanged,
                          textInputAction: TextInputAction.go,
                          onSubmitted: (value){
                            FocusScope.of(context).requestFocus(FocusNode());
                            widget.onSearch(_controller.text);
                          },
                        ),
                      ))
                    ],
                  ))),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: UIData.spaceSize16),
              child: CommonText.darkGrey14Text('搜索'),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              widget.onSearch(_controller.text);
            },
          )
        ],
      ),
    );
  }
}

///
/// 公用搜索条（左边搜索输入框，右边搜索图标）
///
class CommonSearchRightBar extends StatefulWidget {
  final backgroundColor;
  final hintText;
  final padding;
  final Function onSearch;
  final TextEditingController controller;

//  final ValueChanged<String> onChanged;
  CommonSearchRightBar({
    this.backgroundColor = UIData.scaffoldBgColor,
    this.hintText = '',
    this.padding,
    this.onSearch,
    this.controller,
//    this.onChanged,
  });

  @override
  _CommonSearchRightBarState createState() => _CommonSearchRightBarState();
}

class _CommonSearchRightBarState extends State<CommonSearchRightBar> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller == null)
      _controller = TextEditingController();
    else
      _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
        decoration: BoxDecoration(
            color: UIData.scaffoldBgColor,
            borderRadius: BorderRadius.circular(1.0)),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: TextField(
                style: CommonText.darkGrey14TextStyle(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: CommonText.lightGrey14TextStyle(),
                  isDense: true,
                ),
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  widget.onSearch(_controller.text);
                },
//                          onChanged: onChanged,
              ),
            )),
            GestureDetector(
              child: Container(
                width: UIData.spaceSize30,
                height: UIData.spaceSize30,
                child: Icon(
                  Icons.search,
                  color: UIData.lighterGreyColor,
                ),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                widget.onSearch(_controller.text);
              },
            )
          ],
        ));
  }
}

///
/// 单行：左边title，中间自定义控件，可以直接放String进去，
/// 右边箭头，可以隐藏
///
class CommonSingleInputRow extends StatelessWidget {
  final String title;
  final content;
  final GestureTapCallback onTap;
  final arrowVisible;
  final backgroundColor;
  final EdgeInsetsGeometry padding;
  final TextOverflow contentOverFlow;
  final Color titleColor;
  final Color contentColor;
  final double titleWidth;
  final Widget iconDate;
  CrossAxisAlignment crossAxisAlignment;
  CommonSingleInputRow(this.title,
      {this.content,
      this.onTap,
      this.arrowVisible = true,
      this.backgroundColor,
      this.padding,
      this.contentOverFlow,
      this.titleColor,
      this.contentColor,
      this.titleWidth,this.iconDate,this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints:
            BoxConstraints(minHeight: ScreenUtil.getInstance().setHeight(45)),
//        height: contentOverFlow == TextOverflow.fade ? null : ScreenUtil.getInstance().setHeight(45),
        padding: padding ??
            EdgeInsets.symmetric(
                horizontal: UIData.spaceSize16, vertical: UIData.spaceSize8),
        color: backgroundColor ?? UIData.primaryColor,
        child: Row(
          crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.center,
          children: <Widget>[
            title != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    height: ScreenUtil.getInstance().setWidth(25),
                    width: ScreenUtil.getInstance().setWidth(titleWidth ?? 110),
                    child: CommonText.text15(title ?? '',
                        color: titleColor ?? UIData.darkGreyColor))
                : Container(),
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: ScreenUtil.getInstance().setWidth(25)),
              child: content != null
                  ? content is String
                      ? CommonText.text15(content ?? '',
                          overflow: contentOverFlow,
                          color: contentColor ?? UIData.darkGreyColor)
                      : content
                  : Container(),
            )),
            arrowVisible
                ? (iconDate??Icon(
              Icons.keyboard_arrow_right,
              color: UIData.iconGreyColor,
            ))
                : Container()
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

///
/// 单行选择框，没有值则显示浅灰色的[hintText]
/// 继承[CommonSingleInputRow]
///
class CommonSelectSingleRow extends CommonSingleInputRow {
  final String hintText;
  final Color titleColor;
  final Color contentColor;
  final Widget icon;
  CrossAxisAlignment crossAxisAlignment;
  CommonSelectSingleRow(String title,
      {GestureTapCallback onTap,
      bool arrowVisible,
      Color backgroundColor,
      EdgeInsetsGeometry padding,
      double titleWidth,
      var content,
      this.hintText,
      this.titleColor,
      this.contentColor,this.icon,this.crossAxisAlignment})
      : super(title,
      crossAxisAlignment:crossAxisAlignment,
            onTap: onTap,
            padding: padding,
            backgroundColor: backgroundColor,
      iconDate:icon,
            arrowVisible: arrowVisible ?? true,
            content: content is String
                ? (content == null || content.isEmpty
                    ? CommonText.lightGrey15Text(hintText ?? '请选择')
                    : CommonText.text15(content,
                        color: contentColor ?? UIData.darkGreyColor))
                : content ?? CommonText.lightGrey15Text(hintText ?? '请选择'),
            titleColor: titleColor,
            titleWidth: titleWidth);
}

///
/// 表单中多行输入的输入框，标题在上面，输入框在下面
///
class FormMultipleTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final int maxLength;
  final String content;
  final bool enabled;

  FormMultipleTextField(this.title,
      {this.hintText,
      this.controller,
      this.padding,
      this.textInputAction,
      this.onSubmitted,
      this.keyboardType,
      this.inputFormatters,
      this.onChanged,
      this.maxLength = 200,
      this.content,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.primaryColor,
      constraints: BoxConstraints(minHeight: UIData.spaceSize100),
      padding: padding ?? EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonText.darkGrey15Text(title),
          CommonTextField(
            controller: controller,
            content: content,
            textInputAction: textInputAction,
            hintText: hintText,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            maxLength: maxLength,
            enabled: enabled,
          )
        ],
      ),
    );
  }
}

///
/// 普通公用输入框
///
class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;
  final int maxLines;
  final ValueChanged<String> onChanged;
  List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final bool enabled;
  final textColor;
  final maxLength;
  final int limitLength;
  final String labelText; //预文字
  final TextStyle labelStyle; //提示文字样式
  final String suffixText; //补充文本
  final Widget suffixIcon;
  final bool autofocus;
  final String content;

  CommonTextField(
      {this.controller,
      this.hintText,
      this.textInputAction = TextInputAction.done,
      this.onSubmitted,
      this.maxLines,
      this.onChanged,
      this.inputFormatters,
      this.keyboardType,
      this.enabled = true,
      this.textColor,
      this.maxLength,
      this.limitLength,
      this.labelText,
      this.suffixText,
      this.suffixIcon,
      this.labelStyle,
      this.autofocus,
      this.content});

  @override
  Widget build(BuildContext context) {
    if (inputFormatters == null)
      inputFormatters = new List<TextInputFormatter>();
    if (maxLength == null)
      inputFormatters.add(LengthLimitingTextInputFormatter(limitLength ?? 20));
    return TextField(
//      autofocus: autofocus??false,
      controller: controller ??
          (content != null
              ? TextEditingController.fromValue(
                  TextEditingValue(
                      text: content ?? "",
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: content?.length ?? 0))),
                )
              : null),
      textInputAction: textInputAction,
      maxLines: maxLines,
      maxLength: maxLength,
      onSubmitted: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        if (onSubmitted != null) onSubmitted(value);
      },
      style: CommonText.textStyle15(color: textColor),
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
//        prefixText:prefixText,
//        prefixStyle: prefixStyle,
        border: InputBorder.none,
        hintText: hintText ?? '请输入',
        hintStyle: CommonText.lightGrey15TextStyle(),
        isDense: true,
      ),
      enabled: enabled,
//      maxLength: maxLength,
    );
  }
}

///
/// 详情信息的单行
///
class DetailSingleRow extends StatelessWidget {
  final String title;
  final content;
  final TextStyle contentTextStyle;
  final GestureTapCallback onTap;

  DetailSingleRow(this.title, this.content,
      {this.contentTextStyle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: UIData.spaceSize8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 1, child: CommonText.grey15Text(title ?? '')),
          Expanded(
              flex: 2,
              child: GestureDetector(
                  child: content is String
                      ? Text(content ?? '',
                          style: contentTextStyle ??
                              CommonText.darkGrey15TextStyle())
                      : content ?? Container(),
                  onTap: onTap)),
        ],
      ),
    );
  }
}


///价格输入框和数量输入框的限制
class PrecisionLimitFormatter extends TextInputFormatter {
  int scale;//保留小数的位数(默认两位小数)

  PrecisionLimitFormatter({this.scale = 2});

  RegExp exp = new RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    ///输入完全删除
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    ///只允许输入小数
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    ///包含小数点的情况
    if (newValue.text.contains(POINTER)) {
      ///包含多个小数
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      ///小数点后位数
      int lengthAfterPointer = input.substring(index, input.length).length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      ///不包含小数点,不能以“00”开头
      return oldValue;
    }
    return newValue;
  }
}
