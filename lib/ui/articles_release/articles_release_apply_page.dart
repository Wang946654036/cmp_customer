import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/articles_release_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/strings/strings_articles_release.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_record_page.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/common_wrap.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/common/scrawl_page/scrawl_page.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// 物品放行申请
///
class ArticlesReleaseApplyPage extends StatefulWidget {
  final ArticlesReleaseDetail applyModel;

  ArticlesReleaseApplyPage({this.applyModel});

  @override
  _ArticlesReleaseApplyPageState createState() => _ArticlesReleaseApplyPageState();
}

class _ArticlesReleaseApplyPageState extends State<ArticlesReleaseApplyPage> {
  TextEditingController _articlesNameController = TextEditingController();
  TextEditingController _articlesNumController = TextEditingController();
  ArticlesReleaseDetail _applyModel;
  List<HouseInfo> _houseList; //默认项目下的房屋列表
  bool _showCarNoInputView = false; //是否显示车牌号键盘
  bool _isOwner = false; //当前社区下房屋是否有业主身份
  List<Widget> _goodsWidgetList; //物品控件列表

  @override
  void initState() {
    super.initState();
    _initData();
    _initHouseList();
    _setListener();
  }

  //初始化数据，修改申请把加入详情数据，新建申请则初始化对象
  void _initData() {
    if (widget.applyModel != null) {
//      _applyModel = widget.applyModel;
//      _applyModel.reason = widget.applyModel.reason;
      _applyModel = ArticlesReleaseDetail.clone(widget.applyModel);
      _refreshHouseName(_applyModel);
      _applyModel.reasonName = articleReleaseReasonMap.keys
          .firstWhere((String key) => articleReleaseReasonMap[key] == _applyModel.reason, orElse: () => '');
      _articlesNameController.text = _applyModel.goodNames;
      _articlesNumController.text = _applyModel.goodNums.toString();

      _applyModel.goodsList?.forEach((GoodsInfo welderInfo) {
        _goodsWidgetAdd();
      });
    } else {
      _applyModel = ArticlesReleaseDetail();
      _goodsAdd();
      _goodsWidgetAdd();
    }

    _isOwner = stateModel.customerProper == customerYZ;
  }

  void _refreshHouseName(var info) {
    _applyModel.houseName = StringsHelper.getStringValue(info.formerName) +
        StringsHelper.getStringValue(info.buildName) +
        StringsHelper.getStringValue(info.unitName) +
        StringsHelper.getStringValue(info.houseNo);
  }

  //获取当前项目下已认证的房屋列表
  void _initHouseList() {
    stateModel.getCertifiedHouseByProject(callBack: ({List<HouseInfo> houseList, failedMsg}) {
      setState(() {
        if (failedMsg == null) {
          _houseList = houseList;
          if (widget.applyModel == null) {
            _houseList.forEach((HouseInfo info) {
              if (info.isDefaultHouse == '1') {
                //默认房屋
                _applyModel.houseId = info.houseId;
                _applyModel.projectId = info.projectId;
                //业主成员标为业主，住户成员标为住户
                if (info.custProper == customerYZ || info.custProper == customerJTCY)
                  _applyModel.applyType = customerYZ;
                else if (info.custProper == customerZH || info.custProper == customerZHCY)
                  _applyModel.applyType = customerZH;
                _refreshHouseName(info);
              }
              if (!_isOwner && info.custProper == customerYZ) {
                _isOwner = true;
              }
            });
          }
        }
      });
    });
  }

  //设置监听
  void _setListener() {
    _articlesNameController.addListener(() {
      _applyModel.goodNames = _articlesNameController.text;
    });
    _articlesNumController.addListener(() {
      if (_articlesNumController.text.isNotEmpty)
        _applyModel.goodNums = int.parse(_articlesNumController.text);
      else
        _applyModel.goodNums = null;
    });
  }

  bool _checkCommit() {
    if (_applyModel.houseId == null) {
      CommonToast.show(msg: '请选择房屋信息', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.reason == null) {
      CommonToast.show(msg: '请选择申请理由', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.outTime == null) {
      CommonToast.show(msg: '请选择出门时间', type: ToastIconType.INFO);
      return false;
    }
//    if (_applyModel.carNo == null || _applyModel.carNo.isEmpty) {
//      CommonToast.show(msg: '请输入车牌号', type: ToastIconType.INFO);
//      return false;
//    }
//    if (_applyModel.attDwzmList == null || _applyModel.attDwzmList.isEmpty) {
//      CommonToast.show(msg: '请填入单位证明照片', type: ToastIconType.INFO);
//      return false;
//    }
//    if (_applyModel.goodNames == null || _applyModel.goodNames.isEmpty) {
//      CommonToast.show(msg: '请输入物品名称', type: ToastIconType.INFO);
//      return false;
//    }
//    if (_applyModel.goodNums == null) {
//      CommonToast.show(msg: '请输入物品数量', type: ToastIconType.INFO);
//      return false;
//    }
//    if (_applyModel.attWpzpList == null || _applyModel.attWpzpList.isEmpty) {
//      CommonToast.show(msg: '请填入物品照片', type: ToastIconType.INFO);
//      return false;
//    }
    bool valid = true;
    for (int i = 0; i < _applyModel.goodsList.length; i++) {
      if (!valid) return false;
      GoodsInfo goodsInfo = _applyModel.goodsList[i];
      if (goodsInfo?.goodsName == null || goodsInfo.goodsName.isEmpty) {
        CommonToast.show(msg: '请填入物品${i + 1}的物品名称', type: ToastIconType.INFO);
        valid = false;
        return false;
      }
      if (goodsInfo?.goodsNumber == null) {
        CommonToast.show(msg: '请填入物品${i + 1}的物品数量', type: ToastIconType.INFO);
        valid = false;
        return false;
      }
      if (goodsInfo?.goodsPicUuid == null || goodsInfo.goodsPicUuid.isEmpty) {
        CommonToast.show(msg: '请上传物品${i + 1}的物品照片', type: ToastIconType.INFO);
        valid = false;
        return false;
      }
    }
    return true;
  }

  void _goodsAdd() {
    if (_applyModel.goodsList == null) _applyModel.goodsList = List();
    _applyModel.goodsList.add(GoodsInfo());
  }

  void _goodsWidgetAdd() {
    if (_goodsWidgetList == null) _goodsWidgetList = List();
    _goodsWidgetList.add(GoodsCard(_goodsWidgetList.length, _applyModel, true, callback: (int index) {
      setState(() {
        LogUtils.printLog('去掉$index');
        _applyModel.goodsList.removeAt(index);
        _goodsWidgetList.removeAt(index);
      });
    }, key: GlobalKey()));
  }

  //添加物品按钮
  Widget _buildAddGoodsButton() {
    return Container(
      color: UIData.primaryColor,
      child: FlatButton(
          onPressed: () {
            setState(() {
              _goodsAdd();
              _goodsWidgetAdd();
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.add_circle, color: UIData.themeBgColor),
              SizedBox(width: UIData.spaceSize4),
              CommonText.red15Text('添加物品'),
            ],
          )),
    );
  }

  Widget _buildContent() {
    return Container(
      color: UIData.primaryColor,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('房号'),
          ),
          CommonSelectSingleRow(null, hintText: '加载中', content: _applyModel.houseName, onTap: () {
            if (_houseList != null && _houseList.length > 0 && widget.applyModel == null)
              Navigate.toNewPage(SelectHouseFromProjectPage(_houseList, _applyModel.houseId),
                  callBack: (HouseInfo info) {
                if (info != null) {
                  _refreshHouseName(info);
                  LogUtils.printLog('houseId:${info?.houseId}');
                  _applyModel.houseId = info?.houseId;
                  _applyModel.houseNo = info?.houseNo;
                  _applyModel.unitId = info?.unitId;
                  _applyModel.unitName = info?.unitName;
                  _applyModel.buildId = info?.buildId;
                  _applyModel.buildName = info?.buildName;
                  _applyModel.projectId = info?.projectId;
                  _applyModel.projectName = info?.projectName;
                  //业主成员标为业主，住户成员标为住户
                  if (info.custProper == customerYZ || info.custProper == customerJTCY)
                    _applyModel.applyType = customerYZ;
                  else if (info.custProper == customerZH || info.custProper == customerZHCY)
                    _applyModel.applyType = customerZH;
                }
              });
          },
              arrowVisible: widget.applyModel == null,
              contentColor: widget.applyModel == null ? UIData.darkGreyColor : UIData.lightGreyColor),
          CommonDivider(),
          CommonSelectSingleRow(
            '申请理由',
            hintText: '请选择（必填）',
            content: _applyModel.reasonName,
            onTap: () => CommonPicker.singlePickerModal(context, articleReleaseReasonMap.keys.toList(),
                onConfirm: (int index, String data) {
              setState(() {
                _applyModel.reason = articleReleaseReasonMap[data];
                _applyModel.reasonName = data;
                LogUtils.printLog('reason: ${_applyModel.reasonName}');
              });
            }),
          ),
          CommonDivider(),
          CommonSelectSingleRow('出门时间',
              hintText: '请选择（必填）',
              content: _applyModel.outTime,
              onTap: () => CommonPicker.datePickerModal(context, onConfirm: (String date) {
                    setState(() {
                      _applyModel.outTime = date;
                    });
                  })),
          Container(
            padding:
                EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
            child: CommonText.text13(
                _applyModel.outTime == null
                    ? '请如实填写出门日期，放行条自出门日期前一天起三天内有效。'
                    : '有效期${StringsHelper.formatterYMD.format(DateTime.parse(_applyModel.outTime).add(Duration(days: -1)))}'
                        '至${StringsHelper.formatterYMD.format(DateTime.parse(_applyModel.outTime).add(Duration(days: 1)))}',
                color: UIData.themeBgColor,
                overflow: TextOverflow.fade),
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '车牌号码',
            content: _applyModel.carNo,
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                _showCarNoInputView = true;
              });
            },
          ),
          CommonDivider(),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('单位证明'),
          ),
          Container(
            margin: EdgeInsets.all(UIData.spaceSize16),
            child: CommonImagePicker(
              photoIdList: _applyModel.attDwzmList?.map((Attachment attach) => attach.attachmentUuid)?.toList(),
              callback: (List<String> images) {
                LogUtils.printLog('单位证明照片images：$images');
                if (_applyModel.attDwzmList == null)
                  _applyModel.attDwzmList = List();
                else
                  _applyModel.attDwzmList.clear();
                images.forEach((String uuid) => _applyModel.attDwzmList.add(Attachment(attachmentUuid: uuid)));
                LogUtils.printLog('单位证明照片attDwzmList：${_applyModel.attDwzmList}');
              },
            ),
          ),
          Container(height: UIData.spaceSize16, color: UIData.scaffoldBgColor),
//          FormMultipleTextField('物品名称', hintText: '请输入物品名称（必填）', controller: _articlesNameController),
//          Container(
//              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//              child: CustomWrap(articlesCommonWordsList.map((String text) {
//                return CustomChip(text, onTap: () {
////                    _articlesNameController.text = _articlesNameController.text + text;
//                  _articlesNameController.value = TextEditingValue(
//                      text: _articlesNameController.text + text,
//                      // 保持光标在最后
//                      selection: TextSelection.fromPosition(TextPosition(
//                          affinity: TextAffinity.downstream,
//                          offset: (_articlesNameController.text + text).length)));
//                });
//              }).toList())),
//          CommonDivider(),
//          CommonSelectSingleRow(
//            '物品数量',
//            content: CommonTextField(
//                controller: _articlesNumController,
//                keyboardType: TextInputType.number,
//                limitLength: 4,
////                onChanged: (String value) {
////                  if (value.isNotEmpty)
////                    _applyModel.goodNums = int.parse(value);
////                  else
////                    _applyModel.goodNums = null;
////                },
//                hintText: '请输入（必填）',
//                inputFormatters: <TextInputFormatter>[
//                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
//                ]),
//            arrowVisible: false,
//          ),
//          CommonDivider(),
//          Container(
//            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
//            child: CommonText.darkGrey15Text('物品照片（必填）'),
//          ),
//          Container(
//            margin: EdgeInsets.all(UIData.spaceSize16),
//            child: CommonImagePicker(
//              photoIdList: _applyModel.attWpzpList?.map((Attachment attach) => attach.attachmentUuid)?.toList(),
//              callback: (List<String> images) {
//                if (_applyModel.attWpzpList == null)
//                  _applyModel.attWpzpList = List();
//                else
//                  _applyModel.attWpzpList.clear();
//                images.forEach((String uuid) => _applyModel.attWpzpList.add(Attachment(attachmentUuid: uuid)));
//              },
//            ),
//          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
//      color: UIData.primaryColor,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildContent(),
          _buildGoodsList(),
          SizedBox(height: UIData.spaceSize16),
          _buildAddGoodsButton(),
          GestureDetector(
              child: Container(
                  color: UIData.scaffoldBgColor,
                  padding: EdgeInsets.all(UIData.spaceSize16),
                  child: Row(
                    children: <Widget>[
                      UIData.iconInfoOutline,
                      SizedBox(width: UIData.spaceSize4),
                      CommonText.red14Text('放行温馨提示')
                    ],
                  )),
              onTap: () {
                Navigate.toNewPage(CopyWritingPage('放行温馨提示', CopyWritingType.ReleasePassTips));
              }),
        ],
      ),
    );
  }

  Widget _buildCarNoKeyboard() {
    return Theme(
        data: Theme.of(context).copyWith(),
        child: Material(
          color: Colors.transparent,
          child: Offstage(
            offstage: !_showCarNoInputView,
            child: CarNoInputKeyboard(
              carNo: _applyModel.carNo,
              onCancel: () {
                setState(() {
                  _showCarNoInputView = false;
                });
              },
              onConfirm: (String carNo) {
                if (!StringsHelper.isCarNo(carNo)) {
                  CommonToast.show(msg: '请输入正确车牌号', type: ToastIconType.INFO);
                } else {
                  setState(() {
                    _showCarNoInputView = false;
                    _applyModel.carNo = carNo;
//              MainStateModel.of(context).tipDialogKey.currentState.show(
//                  tipDialog: TipDialog(
//                    type: TipDialogType.LOADING,
//                    tip: '验证中',
//                  ));
//              model.checkCarNo(
//                  carNo: carNo,
//                  callBack: ({String failedMsg}) {
//                    if (MainStateModel.of(context).tipDialogKey.currentState.isShow)
//                      MainStateModel.of(context).tipDialogKey.currentState.dismiss();
//                    if (failedMsg != null) {
//                      MainStateModel.of(context).tipDialogKey.currentState.show(
//                          tipDialog: TipDialog(
//                            type: TipDialogType.FAIL,
//                            tip: failedMsg,
//                          ));
//                    } else {
//                      _showCarNoInputView = false;
//                      _carNo = carNo;
//                    }
//                  });
                  });
                }
              },
            ),
          ),
        ));
  }

  //物品列表
  Widget _buildGoodsList() {
    return Visibility(
        visible: _applyModel?.goodsList != null && _applyModel.goodsList.length > 0,
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
//            padding: EdgeInsets.only(top: UIData.spaceSize16),
            itemCount: _applyModel?.goodsList?.length ?? 0,
            itemBuilder: (context, index) {
//              WelderInfo welderInfo = _applyModel.welderList[index];
              return _goodsWidgetList[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: UIData.spaceSize16);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonScaffold(
          appTitle: '物品放行申请',
          appBarActions: [
            FlatButton(
                onPressed: () => Navigate.toNewPage(ArticlesReleaseRecordPage(_isOwner)),
                child: CommonText.red15Text('申请记录'))
          ],
          bodyData: _buildBody(),
          bottomNavigationBar: StadiumSolidButton('提交申请', onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (_checkCommit()) {
              CommonDialog.showAlertDialog(context, title: '确认提交', content: '确定提交该物品放行申请？', onConfirm: () {
                _applyModel.operateStep = articleReleaseTJSQ;

                Navigate.toNewPage(ScrawlPage(), callBack: (path) {
                  if (path != null && path is String && StringsHelper.isNotEmpty(path)) {
                    CommonToast.show();
                    ImagesStateModel().uploadFile(path, (data) {
                      CommonToast.dismiss();
                      Attachment info = Attachment.fromJson(data);
                      if (_applyModel.attWpSignList == null) {
                        _applyModel.attWpSignList = new List();
                      } else
                        _applyModel.attWpSignList.clear();
                      _applyModel.attWpSignList.add(info);
                      _applyModel.customerId = stateModel.customerId;
                      stateModel.applyArticleRelease(
                          applyModel: _applyModel, newCreate: widget.applyModel == null);
                    }, (data) {
                      CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString() ?? "");
                    });
                  }
                });
              });
            }
          }),
        ),
        _buildCarNoKeyboard(),
      ],
    );
  }
}

///
/// 单个物品放行物品卡片
/// [canOperate]是否可操作，详情不可操作，新建或修改可以编辑和删除
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
///
class GoodsCard extends StatefulWidget {
  final int index;
  final ArticlesReleaseDetail model;
  final bool canOperate;
  final Function callback;
  final int customerType;

  GoodsCard(this.index, this.model, this.canOperate, {Key key, this.callback, this.customerType})
      : super(key: key);

  @override
  _GoodsCardState createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  TextEditingController _goodsNameController = TextEditingController();
  TextEditingController _goodsNumController = TextEditingController();
  GoodsInfo _goodsInfo;

  @override
  void initState() {
    super.initState();
    _initData();

    if (widget.canOperate) {
      _setListener();
    }
  }

  void _initData() {
    _goodsInfo = widget.model?.goodsList[widget.index];
    if (widget.canOperate) {
      _goodsNameController.text = _goodsInfo?.goodsName;
      _goodsNumController.text = _goodsInfo?.goodsNumber?.toString();
    }
  }

  void _setListener() {
    _goodsNameController.addListener(() {
      _goodsInfo.goodsName = _goodsNameController.text;
    });
    _goodsNumController.addListener(() {
      if (StringsHelper.isNotEmpty(_goodsNumController.text)) {
        _goodsInfo.goodsNumber = int.parse(_goodsNumController.text);
      } else {
        _goodsInfo.goodsNumber = 0;
      }
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
          ListTile(
            contentPadding: EdgeInsets.only(left: UIData.spaceSize16),
            dense: true,
            title: Container(
//                padding: widget.canOperate
//                    ? EdgeInsets.only(left: UIData.spaceSize16)
//                    : EdgeInsets.all(UIData.spaceSize16),
                child: CommonText.darkGrey15Text('物品${widget.model.goodsList.indexOf(_goodsInfo) + 1}')),
            trailing: widget.canOperate
                ? Offstage(
                    offstage: widget.index == 0,
                    child: IconButton(
                        icon: UIData.iconCloseOutline,
                        onPressed: () {
//                      setState(() {
                          if (widget.callback != null) widget.callback(widget.model.goodsList.indexOf(_goodsInfo));
//                        widget.model.goodsList.removeAt(widget.index);
//                      });
                        }))
                : null,
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Container(
//                  padding: widget.canOperate
//                      ? EdgeInsets.only(left: UIData.spaceSize16)
//                      : EdgeInsets.all(UIData.spaceSize16),
//                  child: CommonText.darkGrey15Text('物品${widget.model.goodsList.indexOf(_goodsInfo) + 1}')),
//              widget.canOperate
//                  ? Offstage(
//                  offstage: widget.index == 0,
//                  child: IconButton(
//                  icon: UIData.iconCloseOutline,
//                  onPressed: () {
////                      setState(() {
//                    if (widget.callback != null) widget.callback(widget.model.goodsList.indexOf(_goodsInfo));
////                        widget.model.goodsList.removeAt(widget.index);
////                      });
//                  }))
//                  : Container()
//            ],
//          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '物品名称',
            content: widget.canOperate
                ? CommonTextField(controller: _goodsNameController, hintText: '请输入（必填）',
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(50),
              ],)
                : _goodsInfo?.goodsName,
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '物品数量',
            hintText: '请输入（必填）',
            content: widget.canOperate
                ? CommonTextField(
                    controller: _goodsNumController,
                    hintText: '请输入（必填）',
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      LengthLimitingTextInputFormatter(3),
                    ],
                    keyboardType: TextInputType.numberWithOptions())
                : _goodsInfo?.goodsNumber?.toString(),
            arrowVisible: false,
          ),
          CommonDivider(),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text(widget.canOperate ? '物品照片（必填）' : '物品照片'),
          ),
          Container(
            margin: EdgeInsets.all(UIData.spaceSize16),
            child: CommonImagePicker(
              enableAddImage: widget.canOperate,
              maxCount: 1,
              photoIdList: StringsHelper.isNotEmpty(_goodsInfo?.goodsPicUuid) ? [_goodsInfo?.goodsPicUuid] : null,
              callback: (List<String> images) {
                setState(() {
                  if (images != null && images.length > 0) {
                    _goodsInfo.goodsPicUuid = images[0];
                  } else {
                    _goodsInfo.goodsPicUuid = null;
                  }
//                  if (_goodsInfo.welderIdPhotoList == null)
//                    _goodsInfo.welderIdPhotoList = List();
//                  else
//                    _goodsInfo.welderIdPhotoList.clear();
//                  images.forEach((String uuid) {
//                    _goodsInfo.welderIdPhotoList.add(uuid);
//                  });
//                  LogUtils.printLog('welderIdPhotoList length:${_goodsInfo.welderIdPhotoList.length}');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
