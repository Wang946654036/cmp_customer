import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/project_setting_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_hot_work.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/common/scrawl_page/scrawl_page.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_record_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 动火申请
///
class HotWorkApplyPage extends StatefulWidget {
  final HotWorkDetail applyModel;

  HotWorkApplyPage({this.applyModel});

  @override
  _HotWorkApplyPageState createState() => _HotWorkApplyPageState();
}

class _HotWorkApplyPageState extends State<HotWorkApplyPage> {
  TextEditingController _contentController = TextEditingController(); //动火作业内容
  TextEditingController _locationController = TextEditingController(); //动火位置（地点）
  TextEditingController _constructionUnitController = TextEditingController(); //施工单位
  TextEditingController _siteLeaderController = TextEditingController(); //现场负责人
  TextEditingController _responsiblePersonController = TextEditingController(); //动火防火责任人
  TextEditingController _fireWatchManPersonController = TextEditingController(); //看火人
  HotWorkDetail _applyModel;
  List<HouseInfo> _houseList; //默认项目下的房屋列表
  HotWorkTimeInfo _hotWorkTimeInfo; //默认项目下的动火时间设置
  DateTime _currentTime = DateTime.now(); //今天
  bool isOwner = false; //当前社区下房屋是否有业主身份
  bool _agreeStatement = false; //是否同意说明
  List<Widget> _welderWidgetList; //动火人员控件列表

  @override
  void initState() {
    super.initState();
    _initData();
    _initHouseList();
    _initHotWorkSetting();
    _setListener();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //初始化数据，修改申请把加入详情数据，新建申请则初始化对象
  void _initData() {
    if (widget.applyModel != null) {
      _applyModel = HotWorkDetail.clone(widget.applyModel);
      _refreshHouseName(_applyModel);
//      _applyModel.reasonName = articleReleaseReasonMap.keys
//          .firstWhere((String key) => articleReleaseReasonMap[key] == _applyModel.reason, orElse: () => '');
      _contentController.text = _applyModel.hotWorkContent;
      _locationController.text = _applyModel.hotWorkLocation;
      _constructionUnitController.text = _applyModel.constructionUnit;
      _siteLeaderController.text = _applyModel.onSiteLeader;
      _responsiblePersonController.text = _applyModel.firePreventMan;
      _fireWatchManPersonController.text = _applyModel.fireWatchMan;

      _applyModel.welderList?.forEach((WelderInfo welderInfo){
        _welderWidgetAdd();
      });
    } else {
      _applyModel = HotWorkDetail();
      _welderAdd();
      _welderWidgetAdd();
    }
    isOwner = stateModel.customerProper == customerYZ;
  }

  void _refreshHouseName(var info) {
    _applyModel.houseName = StringsHelper.getStringValue(info.formerName) +
        ((info is HouseInfo)
            ? (StringsHelper.getStringValue(info.buildName) +
                StringsHelper.getStringValue(info.unitName) +
                StringsHelper.getStringValue(info.houseNo))
            : StringsHelper.getStringValue(info.houseName));
  }

  //获取当前项目下已认证的房屋列表
  void _initHouseList() {
    stateModel.getCertifiedHouseByProject(callBack: ({List<HouseInfo> houseList, failedMsg}) {
      setState(() {
        if (failedMsg == null) {
          _houseList = houseList;
          //applyModel为空则为新建
          if (widget.applyModel == null) {
            _houseList.forEach((HouseInfo info) {
              if (info.isDefaultHouse == '1') {
                //默认房屋
                _applyModel.houseId = info.houseId;
                //业主成员标为业主，住户成员标为住户
                if (info.custProper == customerYZ || info.custProper == customerJTCY)
                  _applyModel.applyType = customerYZ;
                else if (info.custProper == customerZH || info.custProper == customerZHCY)
                  _applyModel.applyType = customerZH;
                _refreshHouseName(info);
              }
              if (!isOwner && info.custProper == customerYZ) {
                isOwner = true;
              }
            });
          }
        }
      });
    });
  }

  //获取当前项目的动火设置
  void _initHotWorkSetting() {
    stateModel.getHotWorkSetting(callBack: ({HotWorkTimeInfo hotWorkTimeInfo, failedMsg}) {
      setState(() {
        if (failedMsg == null) {
          _hotWorkTimeInfo = hotWorkTimeInfo;
        }
      });
    });
  }

  //设置监听
  void _setListener() {
    _contentController.addListener(() {
      _applyModel.hotWorkContent = _contentController.text;
    });
    _locationController.addListener(() {
      _applyModel.hotWorkLocation = _locationController.text;
    });
    _constructionUnitController.addListener(() {
      _applyModel.constructionUnit = _constructionUnitController.text;
    });
    _siteLeaderController.addListener(() {
      _applyModel.onSiteLeader = _siteLeaderController.text;
    });
    _responsiblePersonController.addListener(() {
      _applyModel.firePreventMan = _responsiblePersonController.text;
    });
    _fireWatchManPersonController.addListener(() {
      _applyModel.fireWatchMan = _fireWatchManPersonController.text;
    });
  }

  bool _checkCommit() {
    if (_applyModel.houseId == null) {
      CommonToast.show(msg: '请选择房屋信息', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.hotWorkContent == null || _applyModel.hotWorkContent.isEmpty) {
      CommonToast.show(msg: '请填写作业内容', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.hotWorkLocation == null || _applyModel.hotWorkLocation.isEmpty) {
      CommonToast.show(msg: '请填写动火位置/地点', type: ToastIconType.INFO);
      return false;
    }
//    if (_applyModel.constructionUnit == null) {
//      CommonToast.show(msg: '请填写施工单位', type: ToastIconType.INFO);
//      return false;
//    }
    if (_applyModel.onSiteLeader == null || _applyModel.onSiteLeader.isEmpty) {
      CommonToast.show(msg: '请填写现场负责人', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.firePreventMan == null || _applyModel.firePreventMan.isEmpty) {
      CommonToast.show(msg: '请填写动火防火责任人', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.firePreventMan == null || _applyModel.firePreventMan.isEmpty) {
      CommonToast.show(msg: '请填写动火防火责任人', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.hotWorkStartTime == null) {
      CommonToast.show(msg: '请选择动火开始时间', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.hotWorkEndTime == null) {
      CommonToast.show(msg: '请选择动火结束时间', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel?.welderList == null || _applyModel.welderList.length == 0) {
      CommonToast.show(msg: '请添加动火员工', type: ToastIconType.INFO);
      return false;
    }
    bool valid = true;
    for (int i = 0; i < _applyModel.welderList.length; i++) {
      if (!valid) return false;
      WelderInfo welderInfo = _applyModel.welderList[i];
      if (welderInfo?.welderName == null || welderInfo.welderName.isEmpty) {
        CommonToast.show(msg: '请填入动火员工${i + 1}的姓名', type: ToastIconType.INFO);
        valid = false;
        return false;
      }
      if (welderInfo?.idCardNo == null || welderInfo.idCardNo.isEmpty) {
        CommonToast.show(msg: '请填入动火员工${i + 1}的身份证号', type: ToastIconType.INFO);
        valid = false;
        return false;
      }
      if (welderInfo?.welderIdPhotoList == null || welderInfo.welderIdPhotoList.length == 0) {
        CommonToast.show(msg: '请填入动火员工${i + 1}的身份证照片', type: ToastIconType.INFO);
        valid = false;
        return false;
      }
      if (!_agreeStatement) {
        CommonToast.show(msg: '请阅读并同意《动火温馨提示》！', type: ToastIconType.INFO);
        return false;
      }
    }
    return true;
  }

  void _welderAdd() {
    if (_applyModel.welderList == null) _applyModel.welderList = List();
    _applyModel.welderList.add(WelderInfo());
  }

  void _welderWidgetAdd() {
    if(_welderWidgetList == null) _welderWidgetList = List();
    _welderWidgetList.add(WelderCard(_welderWidgetList.length, _applyModel, true, callback: (int index) {
      setState(() {
        LogUtils.printLog('去掉$index');
        _applyModel.welderList.removeAt(index);
        _welderWidgetList.removeAt(index);
      });
    },key: GlobalKey()));
  }

  //添加动火员工按钮
  Widget _buildAddWelderButton() {
    return Container(
      color: UIData.primaryColor,
      child: FlatButton(
          onPressed: () {
            setState(() {
              _welderAdd();
              _welderWidgetAdd();
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.add_circle, color: UIData.themeBgColor),
              SizedBox(width: UIData.spaceSize4),
              CommonText.red15Text('添加动火人员'),
            ],
          )),
    );
  }

  //员工列表
  Widget _buildWelderList() {
    return Visibility(
        visible: _applyModel?.welderList != null && _applyModel.welderList.length > 0,
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: UIData.spaceSize16),
            itemCount: _applyModel?.welderList?.length ?? 0,
            itemBuilder: (context, index) {
//              WelderInfo welderInfo = _applyModel.welderList[index];
              return _welderWidgetList[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: UIData.spaceSize16);
            }));
  }

  Widget _buildContent() {
    return Container(
      color: UIData.primaryColor,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          //选择房屋
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('房屋'),
          ),
          CommonSelectSingleRow(null, hintText: '加载中', content: _applyModel.houseName, onTap: () {
            if (_houseList != null && _houseList.length > 0 && widget.applyModel == null)
              Navigate.toNewPage(SelectHouseFromProjectPage(_houseList, _applyModel.houseId),
                  callBack: (HouseInfo info) {
                if (info != null) {
                  _refreshHouseName(info);
                  LogUtils.printLog('houseId:${info?.houseId}');
                  _applyModel.houseId = info?.houseId;
                  //业主成员标为业主，住户成员标为住户
                  if (info.custProper == customerYZ || info.custProper == customerJTCY)
                    _applyModel.applyType = customerYZ;
                  else if (info.custProper == customerZH || info.custProper == customerZHCY)
                    _applyModel.applyType = customerZH;
                }
              });
          }, arrowVisible: widget.applyModel == null,
              contentColor: widget.applyModel == null ? UIData.darkGreyColor : UIData.lightGreyColor),
          CommonDivider(),
          CommonSelectSingleRow(
            '作业内容',
            content: CommonTextField(controller: _contentController, hintText: '作业事项如电焊、割接等（必填）'),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '动火位置/地点',
            content: CommonTextField(controller: _locationController, hintText: '请输入（必填）'),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '现场负责人',
            content: CommonTextField(controller: _siteLeaderController, hintText: '请输入（必填）'),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '动火防火责任人',
            content: CommonTextField(controller: _responsiblePersonController, hintText: '请输入（必填）'),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '施工单位',
            content: CommonTextField(controller: _constructionUnitController),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '看火人',
            content: CommonTextField(controller: _fireWatchManPersonController),
            arrowVisible: false,
          ),
          CommonDivider(),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize8, right: UIData.spaceSize16),
            child: CommonText.text13(
                _hotWorkTimeInfo == null
                    ? '加载中...'
                    : '请在动火前${_hotWorkTimeInfo?.applyDay ?? 0}天内发起申请，'
                    '动火时长不得超过${_hotWorkTimeInfo?.workDay ?? 0}天，'
                    '且必须在每天${_hotWorkTimeInfo?.startTime ?? ''}至${_hotWorkTimeInfo?.endTime ?? ''}内进行动火作业。',
                color: UIData.themeBgColor,
                overflow: TextOverflow.fade),
          ),
          CommonSelectSingleRow('动火开始时间',
              hintText: '请选择（必填）',
              content: _applyModel.hotWorkStartTime,
              onTap: () => CommonPicker.dateTimePickerModal(context, onConfirm: (String date) {
                    setState(() {
                      DateTime selectedTime = DateTime.parse(date);
                      LogUtils.printLog('selectedTime:$selectedTime');
                      _applyModel.hotWorkStartTime = null;
                      if (selectedTime.isAfter(_currentTime.add(Duration(days: _hotWorkTimeInfo?.applyDay)))) {
                        CommonToast.show(
                            msg: '请在动火前${_hotWorkTimeInfo?.applyDay ?? 0}天内发起申请！', type: ToastIconType.INFO);
                        return;
                      }
                      DateTime startTime = DateTime.parse(
                          '${StringsHelper.formatterYMD.format(selectedTime)} ${_hotWorkTimeInfo.startTime}');
                      DateTime endTime = DateTime.parse(
                          '${StringsHelper.formatterYMD.format(selectedTime)} ${_hotWorkTimeInfo.endTime}');
                      if (selectedTime.isBefore(startTime)) {
                        CommonToast.show(
                            msg: '当天动火开始时间必须晚于${_hotWorkTimeInfo.startTime}！', type: ToastIconType.INFO);
                        return;
                      }
                      if (selectedTime.isAfter(endTime)) {
                        CommonToast.show(
                            msg: '当天动火开始时间必须早于${_hotWorkTimeInfo.endTime}！', type: ToastIconType.INFO);
                        return;
                      }
//                      LogUtils.printLog('开始时间：${DateTime.parse(date.split(' ')[1])}');
                      _applyModel.hotWorkStartTime = date;
                    });
                  })),
          CommonDivider(),
          CommonSelectSingleRow('动火结束时间',
              hintText: '请选择（必填）',
              content: _applyModel.hotWorkEndTime,
              onTap: () => CommonPicker.dateTimePickerModal(context, onConfirm: (String date) {
                    setState(() {
                      DateTime selectedTime = DateTime.parse(date);
                      _applyModel.hotWorkEndTime = null;
                      if (selectedTime.isBefore(DateTime.parse(_applyModel?.hotWorkStartTime))) {
                        CommonToast.show(msg: '结束时间必须后于开始时间！', type: ToastIconType.INFO);
                        return;
                      }
                      if (selectedTime.difference(DateTime.parse(_applyModel?.hotWorkStartTime)) >
                          Duration(days: (_hotWorkTimeInfo?.workDay ?? 0))) {
                        CommonToast.show(
                            msg: '动火时长不得超过${_hotWorkTimeInfo?.workDay ?? 0}天！', type: ToastIconType.INFO);
                        return;
                      }
                      DateTime startTime = DateTime.parse(
                          '${StringsHelper.formatterYMD.format(selectedTime)} ${_hotWorkTimeInfo.startTime}');
                      DateTime endTime = DateTime.parse(
                          '${StringsHelper.formatterYMD.format(selectedTime)} ${_hotWorkTimeInfo.endTime}');
                      if (selectedTime.isBefore(startTime)) {
                        CommonToast.show(
                            msg: '当天动火结束时间必须晚于${_hotWorkTimeInfo.startTime}！', type: ToastIconType.INFO);
                        return;
                      }
                      if (selectedTime.isAfter(endTime)) {
                        CommonToast.show(
                            msg: '当天动火结束时间必须早于${_hotWorkTimeInfo.endTime}！', type: ToastIconType.INFO);
                        return;
                      }
                      _applyModel.hotWorkEndTime = date;
                    });
                  }))
        ],
      ),
    );
  }

  Widget _buildStatement() {
    return Row(
      children: <Widget>[
        Checkbox(
            value: _agreeStatement,
            onChanged: (bool value) {
              setState(() {
                _agreeStatement = value;
              });
            }),
        CommonText.darkGrey12Text('同意'),
        GestureDetector(
            child: CommonText.text12('《动火温馨提示》', color: UIData.redColor),
            onTap: () =>
                Navigate.toNewPage(CopyWritingPage('动火温馨提示', CopyWritingType.TipsForHotWork))),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildContent(),
          _buildWelderList(),
          SizedBox(height: UIData.spaceSize16),
          _buildAddWelderButton(),
          _buildStatement(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '动火申请',
      appBarActions: [
        FlatButton(
            onPressed: () => Navigate.toNewPage(HotWorkRecordPage(isOwner)), child: CommonText.red15Text('申请记录'))
      ],
      bodyData: _buildBody(),
      bottomNavigationBar: StadiumSolidButton('提交申请', onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_checkCommit()) {
          CommonDialog.showAlertDialog(context, title: '确认提交', content: '确定提交该动火申请？', onConfirm: () {
            Navigate.toNewPage(ScrawlPage(), callBack: (path) {
              if (path != null && path is String && StringsHelper.isNotEmpty(path)) {
                CommonToast.show();
                ImagesStateModel().uploadFile(path, (data) {
                  CommonToast.dismiss();
                  Attachment info = Attachment.fromJson(data);
                  if(stateModel.customerProper == customerYZ || stateModel.customerProper == customerJTCY){
                    if (_applyModel.attDhYzSignList == null) {
                      _applyModel.attDhYzSignList = new List();
                    } else
                      _applyModel.attDhYzSignList.clear();
                    _applyModel.attDhYzSignList.add(info);
                  }else {
                    if (_applyModel.attDhZhSignList == null) {
                      _applyModel.attDhZhSignList = new List();
                    } else
                      _applyModel.attDhZhSignList.clear();
                    _applyModel.attDhZhSignList.add(info);
                  }
                  _applyModel.projectId = stateModel.defaultProjectId;
                  _applyModel.customerId = stateModel.customerId;
                  stateModel.applyHotWork(applyModel: _applyModel, newCreate: widget.applyModel == null);
                }, (data) {
                  CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString() ?? "");
                });
              }
            });
          });
        }
      }),
    );
  }
}

///
/// 单个动火员工卡片
/// [canOperate]是否可操作，详情不可操作，新建或修改可以编辑和删除
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
///
class WelderCard extends StatefulWidget {
  final int index;
  final HotWorkDetail model;
  final bool canOperate;
  final Function callback;
  final int customerType;

  WelderCard(this.index, this.model, this.canOperate, {Key key, this.callback, this.customerType}):super(key: key);

  @override
  _WelderCardState createState() => _WelderCardState();
}

class _WelderCardState extends State<WelderCard> {
  TextEditingController _welderNameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _certController = TextEditingController();
  TextEditingController _workTypeController = TextEditingController();
  WelderInfo _welderInfo;

  @override
  void initState() {
    super.initState();
    _initData();

    if (widget.canOperate) {
      _setListener();
    }
  }

  void _initData() {
    _welderInfo = widget.model?.welderList[widget.index];
    if (widget.canOperate) {
      _welderNameController.text = _welderInfo?.welderName;
      _idController.text = _welderInfo?.idCardNo;
      _certController.text = _welderInfo?.certificateNo;
      _workTypeController.text = _welderInfo?.workType;
    }
  }

  void _setListener() {
    _welderNameController.addListener(() {
      _welderInfo.welderName = _welderNameController.text;
    });
    _idController.addListener(() {
      _welderInfo.idCardNo = _idController.text;
    });
    _certController.addListener(() {
      _welderInfo.certificateNo = _certController.text;
    });
    _workTypeController.addListener(() {
      _welderInfo.workType = _workTypeController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
//    _initData();
    return Container(
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: widget.canOperate
                      ? EdgeInsets.only(left: UIData.spaceSize16)
                      : EdgeInsets.all(UIData.spaceSize16),
                  child: CommonText.darkGrey15Text('动火员工${widget.model.welderList.indexOf(_welderInfo) + 1}')),
              widget.canOperate
                  ? IconButton(
                      icon: UIData.iconCloseOutline,
                      onPressed: () {
//                      setState(() {
                        if (widget.callback != null) widget.callback(widget.model.welderList.indexOf(_welderInfo));
//                        widget.model.welderList.removeAt(widget.index);
//                      });
                      })
                  : widget.model.processState == hotWorkHasApproved
                      ? IconButton(
                          icon: UIData.iconHotWorkPass,
                          onPressed: () {
                            Navigate.toNewPage(HotWorkDetailPage(
                              widget.model.hotWorkId,
                              customerType: widget.customerType,
                              isLicence: true,
                              hotWorkDetail: widget.model,
                              welderName: _welderInfo?.welderName,
                              welderId: _welderInfo?.welderId,
                            ));
                          })
                      : Container()
            ],
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '姓名',
            content: widget.canOperate
                ? CommonTextField(controller: _welderNameController, hintText: '请输入（必填）')
                : _welderInfo?.welderName,
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '身份证号',
            hintText: '请输入（必填）',
            content: widget.canOperate
                ? CommonTextField(controller: _idController, hintText: '请输入（必填）')
                : _welderInfo?.idCardNo,
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '操作证号',
            content: widget.canOperate
                ? CommonTextField(controller: _certController, hintText: '请输入')
                : _welderInfo?.certificateNo,
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '工种',
            content: widget.canOperate
                ? CommonTextField(controller: _workTypeController, hintText: '请输入')
                : _welderInfo?.workType,
            arrowVisible: false,
          ),
          CommonDivider(),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text(widget.canOperate ? '身份证（必填）' : '身份证'),
          ),
          Container(
            margin: EdgeInsets.all(UIData.spaceSize16),
            child: CommonImagePicker(
              enableAddImage: widget.canOperate,
              maxCount: 2,
              photoIdList: _welderInfo?.welderIdPhotoList,
              callback: (List<String> images) {
                setState(() {
                  _welderInfo.welderIdPhotoList = images;
//                  if (_welderInfo.welderIdPhotoList == null)
//                    _welderInfo.welderIdPhotoList = List();
//                  else
//                    _welderInfo.welderIdPhotoList.clear();
//                  images.forEach((String uuid) {
//                    _welderInfo.welderIdPhotoList.add(uuid);
//                  });
//                  LogUtils.printLog('welderIdPhotoList length:${_welderInfo.welderIdPhotoList.length}');
                });
              },
            ),
          ),
          Visibility(
              visible: (!widget.canOperate &&
                  _welderInfo?.welderCertPhotoList != null &&
                  _welderInfo.welderCertPhotoList.length > 0) || widget.canOperate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CommonDivider(),
                  Container(
                    padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
                    child: CommonText.darkGrey15Text('证件照（包括焊工证）'),
                  ),
                  Container(
                    margin: EdgeInsets.all(UIData.spaceSize16),
                    child: CommonImagePicker(
                      enableAddImage: widget.canOperate,
                      maxCount: 5,
                      photoIdList: _welderInfo?.welderCertPhotoList,
                      callback: (List<String> images) {
                        setState(() {
                          _welderInfo.welderCertPhotoList = images;
//                  if (_welderInfo.welderCertPhotoList == null)
//                    _welderInfo.welderCertPhotoList = List();
//                  else
//                    _welderInfo.welderCertPhotoList.clear();
//                  images.forEach((String uuid) => _welderInfo.welderCertPhotoList.add(uuid));
                        });
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
