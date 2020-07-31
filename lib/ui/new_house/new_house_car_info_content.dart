import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'new_house_common_ui.dart';

///
/// Created by qianlx on 2020/3/26 11:27 AM.
/// 新房入伙车辆信息内容
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class NewHouseCarInfoContent extends StatefulWidget {
  final int editable;
  final NewHouseDetail newHouseDetail;
  final NewHouseStateModel stateModel;

  NewHouseCarInfoContent(this.editable, this.newHouseDetail, this.stateModel);

  @override
  _NewHouseCarInfoContentState createState() => _NewHouseCarInfoContentState();
}

class _NewHouseCarInfoContentState extends State<NewHouseCarInfoContent> {
  NewHouseDetail _newHouseDetail;
  List<Widget> _carsWidgetList; //车辆信息控件列表

  @override
  void initState() {
    super.initState();

    _initData();
  }

  void _initData() {
    _newHouseDetail = widget.newHouseDetail;

    if (_newHouseDetail.newHouseCarInfoList != null && _newHouseDetail.newHouseCarInfoList.length > 0) {
      _newHouseDetail.newHouseCarInfoList?.forEach((NewHouseCarInfo newHouseCarInfo) {
        _carsWidgetAdd();
      });
    } else {
      _carsAdd();
      _carsWidgetAdd();
    }
  }

  void _carsAdd() {
    if (_newHouseDetail.newHouseCarInfoList == null) _newHouseDetail.newHouseCarInfoList = List();
    _newHouseDetail.newHouseCarInfoList.add(NewHouseCarInfo());
  }

  void _carsWidgetAdd() {
    if (_carsWidgetList == null) _carsWidgetList = List();
    _carsWidgetList.add(CarCard(_carsWidgetList.length, _newHouseDetail, widget.editable, widget.stateModel,
        callback: (int index) {
      setState(() {
        LogUtils.printLog('去掉$index');
        _newHouseDetail.newHouseCarInfoList.removeAt(index);
        _carsWidgetList.removeAt(index);
      });
    }, key: GlobalKey()));
  }

  //物品列表
  Widget _buildCarsList() {
    return Visibility(
        visible: _newHouseDetail?.newHouseCarInfoList != null && _newHouseDetail.newHouseCarInfoList.length > 0,
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
//            padding: EdgeInsets.only(top: UIData.spaceSize16),
            itemCount: _newHouseDetail?.newHouseCarInfoList?.length ?? 0,
            itemBuilder: (context, index) {
              return _carsWidgetList[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: UIData.spaceSize16);
            }));
  }

  //添加宠物按钮
  Widget _buildAddCarsButton() {
    return Visibility(
        child: Container(
          color: UIData.scaffoldBgColor,
          padding: EdgeInsets.only(top: UIData.spaceSize16),
          child: Container(
            color: UIData.primaryColor,
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    _carsAdd();
                    _carsWidgetAdd();
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.add_circle, color: UIData.themeBgColor),
                    SizedBox(width: UIData.spaceSize4),
                    CommonText.red15Text('添加车辆'),
                  ],
                )),
          ),
        ),
        visible: widget.editable != 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextWithLeftBorder('车辆信息'),
//          leftTextWidget(
//            text: '车辆信息',
//            color: UIData.darkGreyColor,
//            fontSize: UIData.fontSize17,
//          ),
          SizedBox(height: UIData.spaceSize16),
          _buildCarsList(),
          _buildAddCarsButton(),
        ],
      ),
    );
  }
}

///
/// 单个新房入伙宠物信息卡片
/// [canOperate]是否可操作，详情不可操作，新建或修改可以编辑和删除
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class CarCard extends StatefulWidget {
  final int index;
  final NewHouseDetail model;
  final Function callback;
  final int customerType;
  final int editable;
  final NewHouseStateModel stateModel;

  CarCard(this.index, this.model, this.editable, this.stateModel, {Key key, this.callback, this.customerType})
      : super(key: key);

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  static const Map<String, String> _carSizeMap = {'0': '小型', '1': '中型', '2': '大型', '': '', null: ''};
  TextEditingController _plateNumberController = TextEditingController(); //车牌号
  TextEditingController _carBrandController = TextEditingController(); //品牌
  TextEditingController _carColorController = TextEditingController(); //颜色
  NewHouseCarInfo _carInfo;

  @override
  void initState() {
    super.initState();
    _initData();

    if (widget.editable != 2) {
      _setListener();
    }
  }

  void _initData() {
    _carInfo = widget.model?.newHouseCarInfoList[widget.index];

      _plateNumberController.text = _carInfo?.plateNumber;
      _carBrandController.text = _carInfo?.carBrand;
      _carColorController.text = _carInfo?.carColor;

  }

  void _setListener() {
    _plateNumberController.addListener(() {
      _carInfo.plateNumber = _plateNumberController.text;
    });
    _carBrandController.addListener(() {
      _carInfo.carBrand = _carBrandController.text;
    });
    _carColorController.addListener(() {
      _carInfo.carColor = _carColorController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NewHouseStateModel>(
        model: widget.stateModel,
        child: ScopedModelDescendant<NewHouseStateModel>(builder: (context, child, model) {
          return Container(
            color: UIData.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: UIData.scaffoldBgColor,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: UIData.spaceSize16),
                    dense: true,
                    title: Container(
                        child: CommonText.darkGrey15Text(
                            '车辆${widget.model.newHouseCarInfoList.indexOf(_carInfo) + 1}')),
                    trailing: widget.editable != 2
                        ? Offstage(
                            offstage: widget.index == 0,
                            child: IconButton(
                                icon: UIData.iconCloseOutline,
                                onPressed: () {
                                  if (widget.callback != null)
                                    widget.callback(widget.model.newHouseCarInfoList.indexOf(_carInfo));
                                }))
                        : null,
                  ),
                ),
                CommonDivider(),
                CommonSelectSingleRow(
                  '车牌号',
                  content: _carInfo?.plateNumber,
                  hintText: widget.editable == 2 ? '' : null,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.stateModel.setCarInfo(_carInfo);
                  },
                  arrowVisible: false,
                ),
                CommonDivider(),
                CommonSelectSingleRow(
                  '品牌',
                  content: CommonTextField(
                          hintText: widget.editable == 2 ? '' : null, controller: _carBrandController,
                      enabled: widget.editable != 2)
                      ,
                  arrowVisible: false,
                ),
                CommonDivider(),
                CommonSelectSingleRow(
                  '颜色',
                  content:
                      CommonTextField(hintText: widget.editable == 2 ? '' : null, controller: _carColorController,
                          enabled: widget.editable != 2),
                  arrowVisible: false,
                ),
                CommonDivider(),
                //车型：0-小型，1-中型，2-大型
                CommonSelectSingleRow(
                  '车型',
                  hintText: widget.editable == 2 ? '' : null,
                  content: widget.editable == 2
                      ? _carSizeMap[_carInfo.carSize]
                      : Row(
                          children: <Widget>[
                            CommonRadio(
                                text: '小型',
                                value: '0',
                                groupValue: _carInfo.carSize,
                                onChanged: (String value) {
                                  setState(() {
                                    _carInfo.carSize = value;
                                  });
                                }),
                            SizedBox(width: UIData.spaceSize8),
                            CommonRadio(
                                text: '中型',
                                value: '1',
                                groupValue: _carInfo.carSize,
                                onChanged: (String value) {
                                  setState(() {
                                    _carInfo.carSize = value;
                                  });
                                }),
                            SizedBox(width: UIData.spaceSize8),
                            CommonRadio(
                                text: '大型',
                                value: '2',
                                groupValue: _carInfo.carSize,
                                onChanged: (String value) {
                                  setState(() {
                                    _carInfo.carSize = value;
                                  });
                                }),
                          ],
                        ),
                  arrowVisible: false,
                ),
                CommonDivider(),
                Container(
                  padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
                  child: CommonText.darkGrey15Text('车辆资料'),
                ),
                widget.editable == 2
                    ? Container(
                        padding: EdgeInsets.only(
                            bottom: UIData.spaceSize12,
                            top: UIData.spaceSize8,
                            left: UIData.spaceSize16,
                            right: UIData.spaceSize16),
                        child: CommonImageDisplay(
                            photoIdList: _carInfo.carAttachmentList
                                ?.map((Attachment attach) => attach?.attachmentUuid)
                                ?.toList()),
                      )
                    : Container(
                        margin: EdgeInsets.all(UIData.spaceSize16),
                        child: CommonImagePicker(
                          attachmentList: _carInfo.carAttachmentList,
                          callbackWithInfo: (List<Attachment> images) {
                            if (_carInfo.carAttachmentList == null)
                              _carInfo.carAttachmentList = List();
                            else
                              _carInfo.carAttachmentList.clear();
                            _carInfo.carAttachmentList.addAll(images);
                          },
                        ),
                      ),
              ],
            ),
          );
        }));
  }
}
