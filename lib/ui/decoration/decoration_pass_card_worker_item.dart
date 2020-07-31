import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'decoration_pass_card_label.dart';

class DecorationPassCardWorkerItemPage extends StatefulWidget {
  /// 单个工人卡片
  /// [canOperate]是否可操作，详情不可操作，新建或修改可以编辑和删除
  final int index;
  final DecorationPassCardDetails model;
  final bool canOperate;
  final Function callback;

  DecorationPassCardWorkerItemPage(this.index, this.model, this.canOperate, {Key key, this.callback})
      : super(key: key);

  @override
  State<DecorationPassCardWorkerItemPage> createState() {
    // TODO: implement createState
    return _DecorationPassCardWorkerItem();
  }
}

class _DecorationPassCardWorkerItem extends State<DecorationPassCardWorkerItemPage> {
  TextEditingController _welderNameController = TextEditingController();
  TextEditingController _idController = TextEditingController();

//  TextEditingController _certController = TextEditingController();
  TextEditingController _workTypeController = TextEditingController();
  UserList _welderInfo;

  @override
  void initState() {
    super.initState();
    _initData();

    if (widget.canOperate) {
      _setListener();
    }
  }

  void _initData() {
    _welderInfo = widget.model?.userList[widget.index];
    if (widget.canOperate) {
      _welderNameController.text = _welderInfo?.name;
      _idController.text = _welderInfo?.idCard;
//      _certController.text = _welderInfo?.certificateNo;
      _workTypeController.text = _welderInfo?.workType;
    }
  }

  void _setListener() {
    _welderNameController.addListener(() {
      _welderInfo.name = _welderNameController.text;
    });
    _idController.addListener(() {
      _welderInfo.idCard = _idController.text;
    });
//    _certController.addListener(() {
//      _welderInfo.certificateNo = _certController.text;
//    });
    _workTypeController.addListener(() {
      _welderInfo.workType = _workTypeController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: CommonText.darkGrey15Text('装修工人员信息${widget.model.userList.indexOf(_welderInfo) + 1}')),
              Visibility(
                  visible: widget.canOperate,
                  child: IconButton(
                      icon: UIData.iconCloseOutline,
                      onPressed: () {
                        if (widget.callback != null) widget.callback(widget.model.userList.indexOf(_welderInfo));
                      }))
            ],
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '姓名',
            content: widget.canOperate
                ? CommonTextField(controller: _welderNameController, hintText: '请输入（必填）')
                : _welderInfo?.name,
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '身份证号',
            hintText: '请输入（必填）',
            content: widget.canOperate
                ? CommonTextField(controller: _idController, hintText: '请输入（必填）')
                : _welderInfo?.idCard,
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
              attachmentList: _welderInfo?.idCardPhotos,
              callbackWithInfo: (List<Attachment> images) {
                setState(() {
                  _welderInfo.idCardPhotos = images;
                });
              },
            ),
          ),
          CommonDivider(),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text(widget.canOperate ? '正面头像（必填）' : '正面头像'),
          ),
          Container(
            margin: EdgeInsets.all(UIData.spaceSize16),
            child: CommonImagePicker(
              enableAddImage: widget.canOperate,
              maxCount: 1,
              attachmentList: _welderInfo?.headPhotos,
              callbackWithInfo: (List<Attachment> images) {
                setState(() {
                  _welderInfo.headPhotos = images;
                });
              },
            ),
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '工种',
            hintText: (widget.canOperate ? "请输入" : ""),
            content: widget.canOperate
                ? CommonTextField(controller: _workTypeController, hintText: '请输入')
                : _welderInfo?.workType,
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '证件有效期',
            hintText: (widget.canOperate ? "请选择开始时间（必填）" : ""),
            content: _welderInfo?.beginDate,
            arrowVisible: widget.canOperate,
            onTap: () {
              if (widget.canOperate) {
                CommonPicker.datePickerModal(context, onConfirm: (String date) {
                  if (DateUtils.isBefore(date, widget.model.beginDate)) {
                    CommonToast.show(
                        type: ToastIconType.INFO, msg: "证件有效开始时间不能小于" + label_apply_accreditation_start_date);
                  } else if (StringsHelper.isNotEmpty(_welderInfo.endDate) &&
                      DateUtils.isAfterDay(date, _welderInfo.endDate)) {
                    setState(() {
                      _welderInfo.beginDate = date;
                      _welderInfo.endDate = null;
                    });
                  } else {
                    setState(() {
                      _welderInfo.beginDate = date;
                    });
                  }
                });
              }
            },
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '',
            hintText: (widget.canOperate ? "请选择截止时间（必填）" : ""),
            content: _welderInfo?.endDate,
            arrowVisible: widget.canOperate,
            onTap: () {
              if (widget.canOperate) {
                if (StringsHelper.isEmpty(_welderInfo.beginDate)) {
                  CommonToast.show(type: ToastIconType.INFO, msg: "请选择证件有效开始时间");
                } else {
                  CommonPicker.datePickerModal(context, onConfirm: (String date) {
                    if (DateUtils.isAfterDay(_welderInfo.beginDate, date)) {
                      CommonToast.show(type: ToastIconType.INFO, msg: "证件有效结束时间不能小于开始时间");
                    } else if (DateUtils.isAfterDay(date, widget.model.endDate)) {
                      CommonToast.show(
                          type: ToastIconType.INFO, msg: "证件有效结束时间不能大于" + label_apply_accreditation_end_date);
                    } else {
                      setState(() {
                        _welderInfo.endDate = date;
                      });
                    }
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
