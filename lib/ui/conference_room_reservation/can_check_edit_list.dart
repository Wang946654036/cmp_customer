import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CanCheckAndEditableObj extends Object {
  bool checked = false;
  bool editable = false;
  int contentLength;
  String key;
  String name = '';
  String editContent = '';
  String utit = '';
  double price;
  CanCheckAndEditableEmun type; //numble
}

enum CanCheckAndEditableEmun {
  numb0_9,
  str,
  doubleNumb,
}

class CanCheckAndEditList extends StatefulWidget {
  List<CanCheckAndEditableObj> dataList;
  String title;
  List<Widget> appBarActions;

  CanCheckAndEditList(this.dataList, this.title, {this.appBarActions});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CanCheckAndEditListState();
  }
}

class _CanCheckAndEditListState extends State<CanCheckAndEditList> {
  List<CanCheckAndEditableObj> dataList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataList = new List();
    dataList.addAll(widget.dataList);
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: UIData.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: CommonText.red15Text('确认'),
            onPressed: () {

              dataList.forEach((CanCheckAndEditableObj obj) {
                if (obj.editable) {
                  if (StringsHelper.isNotEmpty(obj.editContent)) {
                    obj.checked = true;
                  } else {
                    obj.checked = false;
                  }
                }
                LogUtils.printLog('dataList:[${obj.name}${obj.editable}${obj.editContent}${obj.checked}]');
              });

              Navigate.closePage(dataList);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      appTitle: widget.title ?? '',
      bottomNavigationBar: _buildBottomNavigationBar(),
      appBarActions: widget.appBarActions,
      bodyData: SingleChildScrollView(
        child: Column(
          children: getTheWidgetList(),
        ),
      ),
    );
  }

  List<CanCheckAndEditableItem> getTheWidgetList() {
    List<CanCheckAndEditableItem> widgets = new List();
    for (int i = 0; i < dataList.length; i++) {
      TextEditingController controller = new TextEditingController();
      controller.addListener((){
        dataList[i]?.editContent = controller.text;
      });
      if(dataList[i]?.editable??false)
      controller.text = dataList[i]?.editContent ?? 'editContent';
      widgets.add(CanCheckAndEditableItem(dataList[i], controller));
    }
    return widgets;
  }
}

class CanCheckAndEditableItem extends StatefulWidget {
  CanCheckAndEditableObj data;
  TextEditingController controller;

  CanCheckAndEditableItem(this.data, this.controller);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CanCheckAndEditableItemState();
  }
}

class _CanCheckAndEditableItemState extends State<CanCheckAndEditableItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: UIData.primaryColor,
      child:Column(children: <Widget>[Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CommonSelectSingleRow(
              widget.data?.name ?? 'name',
              content: CommonTextField(

                  enabled: widget.data?.editable ?? false,
                  controller: widget.controller,
                  keyboardType:
                  (widget.data?.type ?? CanCheckAndEditableEmun.str) ==
                      CanCheckAndEditableEmun.str
                      ? TextInputType.text
                      : TextInputType.number,
                  limitLength: widget.data?.contentLength ?? 15,
                  hintText: (widget.data?.editable ?? false)
                      ? '${widget.data.price != null ? '参考单价：${widget.data.price}元/${widget.data.utit}' : ''}'
                      : '',
                  suffixText: widget.data.utit,
                  suffixIcon: (widget.data?.editable ?? false)
                      ? GestureDetector(
                      onTap: () {
                        widget.data?.checked =false;
                        widget.data.editContent='';
                        WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.clear());
                      },
                      child: Icon(
                        Icons.cancel,
                        color: UIData.lightGreyColor,
                        size: UIData.fontSize16,
                      ))
                      : null,
                  inputFormatters:
                  (widget.data?.type ?? CanCheckAndEditableEmun.str) ==
                      CanCheckAndEditableEmun.numb0_9
                      ? <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  ]
                      : null),
              arrowVisible: false,
            ),
          ),
          Visibility(visible:!(widget.data?.editable ?? false),child: Checkbox(
            value: widget.data?.checked,
            onChanged: (checked) {
              setState(() {
                widget.data?.checked = checked;
                widget.data?.editContent = '';
              });
            },
          ),),

        ],
      ),
      CommonDivider()],),
    );
  }
}
