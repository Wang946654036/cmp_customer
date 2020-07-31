import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CommonMap extends Object {
  dynamic complaintPropertyId;
  String complaintPropertyName;
  List<CommonMap> info;
  bool isCheck;

  CommonMap(this.complaintPropertyId, this.complaintPropertyName,
      {this.info, this.isCheck = false});
}

///添加人员
class AddWorker extends StatefulWidget {
  String title;
  String listType;
  String chooseType;
  List<CommonMap> checkedList;
  Function callback;
bool alwaysShow;
  AddWorker(this.title, this.listType, this.callback,
      {this.chooseType = "0", this.checkedList,this.alwaysShow=false});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddWorkerState();
  }
}

class AddWorkerState extends State<AddWorker> {
  List<CommonMap> commonMapList = new List();
  bool showOnlyCheck = false;

  getCheckLength() {
    int i = 0;
    if (commonMapList == null) {
      commonMapList = new List();
    }
    commonMapList.forEach((info) {
      if (info.isCheck) {
        i++;
      }
    });
    return i;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.checkedList == null) {
      widget.checkedList = new List();
    }
    if (widget.callback != null) {
      widget.callback(commonMapList);
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new CommonScaffold(
      appTitle: widget.title,
      bodyData: _buildContent(),
      appBarActions: <Widget>[
        Visibility(
          visible: widget.chooseType == '1',
          child:
          FlatButton(onPressed: () {
            Navigator.of(context).pop(widget.checkedList);
          }, child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize16,
                  vertical: UIData.spaceSize18),
              padding: EdgeInsets.symmetric(
                  vertical: UIData.spaceSize2,
                  horizontal: UIData.spaceSize4),
              child: CommonText.red15Text('确认')))
         ,
        )
      ],
      bottomNavigationBar: Visibility(
          visible: widget.chooseType == '1',
          child: Container(
            color: UIData.primaryColor,
            padding: EdgeInsets.all(UIData.spaceSize16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: showOnlyCheck
                      ? CommonText.darkGrey16Text('全删')
                      : CommonText.darkGrey16Text('全选'),
                  onTap: () {
                    if (!showOnlyCheck) {
                      setState(() {
                        commonMapList.forEach((info) {
                          info.isCheck = true;
                        });
                      });
                    } else {
                      setState(() {
                        commonMapList.forEach((info) {
                          info.isCheck = false;
                        });
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 1,
                ),
                GestureDetector(
                  child: showOnlyCheck
                      ? CommonText.darkGrey16Text('全部')
                      : CommonText.blue16Text('已选(${getCheckLength()})'),
                  onTap: () {
                    setState(() {
                      showOnlyCheck = !showOnlyCheck;
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildContent() {

    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {

        return CommonLoadContainer(
          state: widget.alwaysShow?ListState.HINT_DISMISS:stateModel.workOthersAddWorkerModelLoadState,
          callback: _refresh,
          content: _buildList(),
        );
      },
    );
  }

  _refresh() {
//    if (widget.listType == '1') stateModel.getDispatchPost();
//    if (widget.listType == '2') stateModel.getDispatchUser();
    if (widget.callback != null) {
      widget.callback(commonMapList);
    }
  }

  Widget _buildList() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
          if(widget.checkedList==null){
            widget.checkedList = new List();
          }

          commonMapList.forEach((info) {
            widget.checkedList.forEach((checkInfo){
              LogUtils.printLog(checkInfo.complaintPropertyId);
              LogUtils.printLog(info.complaintPropertyId);
              if(info.complaintPropertyId == checkInfo.complaintPropertyId){
                info.isCheck = true;
                return;
              }

            });
          });

          widget.checkedList.clear();
          commonMapList.forEach((info) {
            if(info.isCheck)
              widget.checkedList.add(info);
          });
      return ListView.builder(
//        separatorBuilder: (BuildContext context, int index) =>
//            new CommonFullScaleDivider(),
//        itemCount: widget.listType == '1'
//            ? stateModel.dispatchPost.length
//            : stateModel.dispatchUser.length,
        itemCount: commonMapList.length,
        itemBuilder: (BuildContext context, int index) {
//          CommonMap info = widget.listType == '1'
//              ? model.dispatchPost[index]
//              : stateModel.dispatchUser[index];
          CommonMap info = commonMapList[index];
          return Visibility(
              visible: !showOnlyCheck || info.isCheck, child: _buildItem(info));
        },
      );
    });
  }

  Widget _buildItem(CommonMap info) {
    return GestureDetector(
      onTap: () {
        if (widget.chooseType == '0')
          Navigator.of(context).pop(info);
        else
          setState(() {
            if (info.isCheck) {
              info.isCheck = !info.isCheck;
              if (widget.checkedList.contains(info))
                widget.checkedList.remove(info);
            } else {
              info.isCheck = !info.isCheck;
              if (!widget.checkedList.contains(info))
                widget.checkedList.add(info);
            }
          });
      },
      child: Container(
        color: UIData.primaryColor,
        padding: EdgeInsets.symmetric(
            vertical: widget.chooseType == '1' ? 0 : UIData.spaceSize16,
            horizontal: widget.chooseType == '1' ? 0 : UIData.spaceSize16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
                visible: widget.chooseType == '1',
                child: Checkbox(
                  value: info.isCheck,
                  onChanged: (bool val) {
                    setState(() {
                      if (info.isCheck) {
                        info.isCheck = !info.isCheck;
                        if (widget.checkedList.contains(info))
                          widget.checkedList.remove(info);
                      } else {
                        info.isCheck = !info.isCheck;
                        if (!widget.checkedList.contains(info))
                          widget.checkedList.add(info);
                      }
                    });
                  },
                  activeColor: UIData.themeBgColor,
                )),
            Visibility(
                visible: widget.chooseType == '1',
                child: SizedBox(
                  width: UIData.spaceSize16,
                )),
            Expanded(
              flex: 1,
              child: CommonText.darkGrey16Text(info.complaintPropertyName),
            ),
//            Visibility(
//                  visible: info != null&&info.info!=null&&info.info.length>0,
//                  child:Expanded(
//                      flex: 1,
//                      child:  (info.info!=null&&info.info.length>0&&info.info[0].complaintPropertyName != null &&
//                          info.info[0].complaintPropertyName != '0' &&
//                          info.info[0].complaintPropertyName != '1' &&
//                          info.info[0].complaintPropertyName != '2')
//                      ? CommonText.darkGrey16Text('空闲')
//                      : CommonText.text16(info.info[0].complaintPropertyName,
//                          color: UIData.greenAccentColor)),
//            ),
            SizedBox(
              width: UIData.spaceSize20,
            ),
            Visibility(
              visible:
                  info != null && info.info != null && info.info.length > 0,
              child: Expanded(
                  flex: 3,
                  child: CommonText.darkGrey16Text(info.info != null
                      ? info.info[0]?.complaintPropertyName ?? ''
                      : '')),
            ),
          ],
        ),
      ),
    );
  }
}
