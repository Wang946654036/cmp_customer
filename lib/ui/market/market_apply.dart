import 'dart:convert';

import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/community_certified_model.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/market/ware_project_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration/decoration_pass_card_apply_state_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_apply_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_detail_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_select_page.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'market_basedata.dart';
import 'market_detail.dart';


//集市发布和编辑
class MarketApplyPage extends StatefulWidget {
  WareDetailModel detail;
  MarketType marketType;
  MarketApplyPage({this.detail, this.marketType});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }
}

class _PageState extends State<MarketApplyPage> {
  MarketDetailModel _detailModel;
  MarketApplyModel _applyModel;
  String rentMode;
  int selectedGoodsType = -1;
  List<ProjectInfo> _projectList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailModel = new MarketDetailModel();
    _applyModel = new MarketApplyModel();
    if (widget.detail != null) {
      //修改操作
      _initEditData();
      if(stateModel.wareGoodsTypeList!=null){
        int length = stateModel.wareGoodsTypeList.length;
        for(int i=0;i<length;i++){
          if(stateModel.wareGoodsTypeList[i].dataCode == _detailModel.marketInfo.waresType){
            selectedGoodsType = i;
            _detailModel.marketInfo?.waresTypeName =
                stateModel.wareGoodsTypeList[i].dataName;
            break;
          }
        }
      }else{
      }
    } else {
      _detailModel.marketInfo = WareDetailModel();
      rentMode = "次";//默认元每次
    }
    _queryProjectList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //小生意内容
    Widget _buildXSYContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CommonDivider(),
          CommonSelectSingleRow(
            '价格（元）',
            content: CommonTextField(
              hintText: '请填写（必填）',
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                PrecisionLimitFormatter(),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              content: StringsHelper.validDecimalFormat(_detailModel.marketInfo?.price?.toString()) ?? "",
              onChanged: (value) {
                _detailModel.marketInfo?.price = StringsHelper.validDecimalFormat(value);
              },
            ),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '价格单位',
            content: CommonTextField(
              hintText: '请填写（必填），如个、斤、公斤',
              content: _detailModel.marketInfo?.priceDescribe ?? "",
              onChanged: (value) {
                _detailModel.marketInfo?.priceDescribe = value;
              },
            ),
            arrowVisible: false,
          ),
        ],
      );
    }

    //二手内容
    Widget _buildESContent() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CommonDivider(),
            CommonSelectSingleRow(
              '原价（元）',
              content: CommonTextField(
                content: StringsHelper.validDecimalFormat(_detailModel.marketInfo?.priceBak?.toString()) ?? "",
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  PrecisionLimitFormatter()
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _detailModel.marketInfo?.priceBak = value;
                },
              ),
              arrowVisible: false,
            ),
            CommonDivider(),
            CommonSelectSingleRow(
              '现价（元）',
              content: CommonTextField(
                hintText: '请输入（必填）',
                content: StringsHelper.validDecimalFormat(_detailModel.marketInfo?.price?.toString()) ?? "",
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  PrecisionLimitFormatter()
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _detailModel.marketInfo?.price = value;
                },
              ),
              arrowVisible: false,
            ),

            CommonDivider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
              child:
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CommonText.darkGrey15Text("可交换"),
                  Switch(
                      value: _detailModel.marketInfo?.tradingOpt == "1",
                      onChanged: (checked) {
                        setState(() {
                          _detailModel.marketInfo?.tradingOpt = (checked ? "1" : "0");
                        });
                      })
                ],
              ),
            )
          ]);
    }

    //租借内容
    Widget _buildZJContent() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CommonDivider(),
            CommonSelectSingleRow(
              '租金（元）',
              content: CommonTextField(
                hintText: '请输入（必填）',
                content: StringsHelper.validDecimalFormat(_detailModel.marketInfo?.price?.toString()) ?? "",
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  PrecisionLimitFormatter()
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _detailModel.marketInfo?.price = value;
                },
              ),
              arrowVisible: false,
            ),
            CommonDivider(),
            CommonSelectSingleRow(
              '租金方式',
              content: Row(
                children: <Widget>[
                  Radio<String>(
                      groupValue: rentMode,
                      value: "次",
                      onChanged: (String value) {
                        setState(() {
                          rentMode = value;
                          _detailModel.marketInfo?.priceDescribe = "次";
                        });
                      }),
                  GestureDetector(
                    child: CommonText.darkGrey15Text('元/次'),
                    onTap: () {
                      setState(() {
                        rentMode = "次";
                        _detailModel.marketInfo?.priceDescribe = "次";
                      });
                    },
                  ),
                  Radio<String>(
                      groupValue: rentMode,
                      value: "天",
                      onChanged: (String value) {
                        setState(() {
                          rentMode = value;
                          _detailModel.marketInfo?.priceDescribe = "天";
                        });
                      }),
                  GestureDetector(
                    child: CommonText.darkGrey15Text('元/天'),
                    onTap: () {
                      setState(() {
                        rentMode = "天";
                        _detailModel.marketInfo?.priceDescribe = "天";
                      });
                    },
                  )
                ],
              ),
              arrowVisible: false,
            ),
            CommonDivider(),
            CommonSelectSingleRow(
              '押金（元）',
              content: CommonTextField(
                hintText: '请输入（必填）',
                content: StringsHelper.validDecimalFormat(_detailModel.marketInfo?.priceBak?.toString())  ?? "",
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  PrecisionLimitFormatter()
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  _detailModel.marketInfo?.priceBak = value;
                },
              ),
              arrowVisible: false,
            ),
            CommonDivider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CommonText.darkGrey15Text("对本社区认证用户免押金"),
                  Switch(
                      value: _detailModel.marketInfo?.tradingOpt == "1",
                      onChanged: (checked) {
                        setState(() {
                          _detailModel.marketInfo?.tradingOpt = (checked ? "1" : "0");
                        });
                      })
                ],
              ),
            )
          ]);
    }

    //内容
    Widget _buildContent() {
      return SingleChildScrollView(
          child: Container(
        color: color_layout_bg,
        margin: EdgeInsets.only(top: top_spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CommonSelectSingleRow(
              '标题',
              content: CommonTextField(
                hintText: '请填写商品标题（必填）',
                content: _detailModel.marketInfo?.title ?? "",
                onChanged: (value) {
                  _detailModel.marketInfo?.title = value;
                },
              ),
              arrowVisible: false,
            ),
            CommonDivider(),
            FormMultipleTextField(
              "商品描述",
              padding: EdgeInsets.only(
                  top: top_spacing, left: left_spacing, right: right_spacing),
              hintText: "请填写商品描述（必填）",
              content: _detailModel.marketInfo?.content ?? "",
              onChanged: (value) {
                _detailModel.marketInfo?.content = value;
              },
            ),
            CommonDivider(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize16, vertical: UIData.spaceSize8),
              child: CommonText.darkGrey15Text("商品图片（必填）"),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize16, vertical: UIData.spaceSize8),
              child: CommonImagePicker(
                attachmentList: _detailModel.marketInfo?.picAttachmentList,
                callbackWithInfo: (List<Attachment> list) {
                  setState(() {
                    _detailModel.marketInfo?.picAttachmentList = list;
                  });
                },
              ),
            ),
            Visibility(
              visible: widget.marketType == MarketType.XSY,
              child: _buildXSYContent(),
            ),
            Visibility(
              visible: widget.marketType == MarketType.ES,
              child: _buildESContent(),
            ),
            Visibility(
              visible: widget.marketType == MarketType.ZJ,
              child: _buildZJContent(),
            ),
            CommonDivider(),
            CommonSelectSingleRow(
              '商品分类',
              content: _detailModel.marketInfo?.waresTypeName ?? "",
              onTap: () {
                if (stateModel.wareGoodsTypeList == null) {
                  stateModel.findWareDataDictionaryList(
                      showToast: true,
                      callback: () {
                        toSelectGoodsType();
                      });
                } else if (stateModel.wareGoodsTypeList.isEmpty) {
                  CommonToast.show(
                      type: ToastIconType.FAILED, msg: "暂无商品分类数据，请联系管理员");
                } else {
                  toSelectGoodsType();
                }
              },
              hintText: '请选择（必填）',
            ),
            Visibility(
              visible: _projectList?.isNotEmpty??false,
              child:
            CommonDivider(),
            ),
            Visibility(
              visible: _projectList?.isNotEmpty??false,
              child:
              CommonSelectSingleRow(
                '所属项目',
                content: getProjectAndCity(_detailModel.marketInfo?.projectName,_detailModel.marketInfo?.city),
                onTap: () {
                  Navigate.toNewPage(CommonSelectPage("项目选择", _projectList.map((info)=>info.name).toList(), null),
                      callBack: (index) {
                        _setProject(_projectList[index]);
                  });
                },
                hintText: '请选择',
                arrowVisible: (_projectList?.length??0)>1,
              ),
            ),
            Visibility(
              visible: (_projectList?.length??0)>1,
              child: CommonDivider(),
            ),
            Visibility(
              visible: (_projectList?.length??0)>1,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: horizontal_spacing, vertical: vertical_spacing),
                child: CommonText.lightGrey12Text(
                    "检测到亲在多个社区有房屋哦，为了助您促成交易，请选择您希望展示的商品所属社区",
                    overflow: TextOverflow.visible),
              ),
            )
          ],
        ),
      ));
    }

    Widget _buildBody() {
      return ScopedModelDescendant<MarketDetailModel>(
          builder: (context, child, model) {
        return _buildContent();
      });
    }

    return ScopedModel<MarketDetailModel>(
        model: _detailModel,
        child: CommonScaffold(
          appTitle: _setAppTitle(),
          bodyData: _buildBody(),
          bottomNavigationBar: _detailModel!=null?StadiumSolidButton(
            "发布",
            btnType: ButtonType.CONFIRM,
            onTap: () {
              _checkUploadData();
            },
          ):null,
        ));
  }

  //获取已认证的社区列表
  void _queryProjectList() {
    _applyModel.queryProjectList( callBack: (list){
      setState(() {
        _projectList = list;
      });
      if (list != null && widget.detail==null) {
        //先设置第一个先
        _setProject(_projectList[0]);
          //如果和默认社区同一个，则设置默认社区
          _projectList.forEach((data) {
            ProjectInfo info = data;
            if (info.projectId == stateModel.defaultProjectId) {
              _setProject(info);
              return;
            }
          });
        }
    });
  }

  void _setProject(ProjectInfo info){
    if(info!=null){
      setState(() {
        _detailModel.marketInfo.projectId = info.projectId;
        _detailModel.marketInfo.projectName = info.name;
        _detailModel.marketInfo.city = info.city;
      });
    }
  }

  //设置标题
  String _setAppTitle() {
    String title = "";
    switch (widget.marketType) {
      case MarketType.XSY:
        // TODO: Handle this case.
        title = "小生意";
        break;
      case MarketType.ES:
        // TODO: Handle this case.
        title = "二手商品";
        break;
      case MarketType.ZJ:
        // TODO: Handle this case.
        title = "租借商品";
        break;
      case MarketType.ZS:
        // TODO: Handle this case.
        title = "赠送商品";
        break;
    }
    return widget?.detail != null ? "编辑$title" : "发布$title";
  }

  void toSelectGoodsType() {
    if (stateModel.wareGoodsTypeList != null) {
      Navigate.toNewPage(
          CommonSelectPage(
              "商品分类",
              stateModel.wareGoodsTypeList
                  .map((goodsType) => goodsType.dataName)
                  .toList(),
              selectedGoodsType), callBack: (index) {
        if (index != null) {
          setState(() {
            selectedGoodsType = index;
            _detailModel.marketInfo?.waresType =
                stateModel.wareGoodsTypeList[index].dataCode;
            _detailModel.marketInfo?.waresTypeName =
                stateModel.wareGoodsTypeList[index].dataName;
          });
        }
      });
    }
  }

  void _checkUploadData() {
    if (StringsHelper.isEmpty(_detailModel.marketInfo?.title?.trim())) {
      CommonToast.show(msg: '请填写商品标题', type: ToastIconType.INFO);
      return;
    } else if (StringsHelper.isEmpty(_detailModel.marketInfo?.content?.trim())) {
      CommonToast.show(msg: '请填写商品描述', type: ToastIconType.INFO);
      return;
    } else if (_detailModel.marketInfo?.picAttachmentList?.isEmpty ?? true) {
      CommonToast.show(msg: '请上传商品图片', type: ToastIconType.INFO);
      return;
    } else if (widget.marketType == MarketType.XSY &&
        StringsHelper.isEmpty(_detailModel.marketInfo?.price?.toString()?.trim())) {
      CommonToast.show(msg: '请填写价格', type: ToastIconType.INFO);
      return;
    } else if (widget.marketType == MarketType.XSY &&
        StringsHelper.isEmpty(_detailModel.marketInfo?.priceDescribe?.trim())) {
      CommonToast.show(msg: '请填写价格单位', type: ToastIconType.INFO);
      return;
    } else if (widget.marketType == MarketType.ES &&
        StringsHelper.isEmpty(_detailModel.marketInfo?.price?.toString()?.trim())) {
      CommonToast.show(msg: '请填写现价', type: ToastIconType.INFO);
      return;
    } else if (widget.marketType == MarketType.ZJ &&
        StringsHelper.isEmpty(_detailModel.marketInfo?.price?.toString()?.trim())) {
      CommonToast.show(msg: '请填写租金', type: ToastIconType.INFO);
      return;
    } else if (widget.marketType == MarketType.ZJ &&
        StringsHelper.isEmpty(rentMode?.toString()?.trim())) {
      CommonToast.show(msg: '请选择租金方式', type: ToastIconType.INFO);
      return;
    } else if (widget.marketType == MarketType.ZJ &&
        StringsHelper.isEmpty(_detailModel.marketInfo?.priceBak?.toString()?.trim())) {
      CommonToast.show(msg: '请填写押金', type: ToastIconType.INFO);
      return;
    } else if (StringsHelper.isEmpty(_detailModel.marketInfo?.waresTypeName?.trim())) {
      CommonToast.show(msg: '请选择商品分类', type: ToastIconType.INFO);
      return;
    }

    if (widget.marketType == MarketType.ZJ) {
      _detailModel.marketInfo?.priceDescribe =  rentMode ??"次";
    }

    if(widget.marketType == MarketType.ES || widget.marketType == MarketType.ZJ){
      //二手或者租借的类型，需要设置，不能为null
      if(_detailModel.marketInfo?.tradingOpt==null){
        _detailModel.marketInfo?.tradingOpt = "0";
      }
    }

    if (_detailModel.marketInfo.picAttachmentList != null) {
      for (int i = 0; i < _detailModel.marketInfo.picAttachmentList.length; i++) {
        if (_detailModel.marketInfo.picAttachmentList[i] == null) {
          CommonToast.show(type: ToastIconType.FAILED, msg: "尚有未上传完成的图片");
          return;
        }
      }
    }

    if(_detailModel.marketInfo.waresId!=null){
      CommonDialog.showAlertDialog(context, title: '确认发布？', onConfirm: () {
        _applyModel.uploadEditData(json.encode(_detailModel.marketInfo),callback: (success){
          if(success!=null&&success){
            CommonToast.show(type: ToastIconType.SUCCESS,msg: "编辑成功");
            Navigate.closePage(true);
          }
        });
      }, positiveBtnText: '果断发布');
    }else{
      _detailModel.marketInfo.tradingType = StringsHelper.enum2String(widget.marketType?.toString());
      CommonDialog.showAlertDialog(context, title: '确认发布？', onConfirm: () {
        _applyModel.uploadData(json.encode(_detailModel.marketInfo),callback: (id){
          if(id!=null){
            CommonDialog.showAlertDialog(context, title: '已发布！', onConfirm: () {
              Navigate.closePage(true);
              Navigate.toNewPage(MarketDetail(StringsHelper.getIntValue(id)));
            },onCancel: (){
              Navigate.closePage(true);
            }, positiveBtnText: '点击查看',negativeBtnText: "返回集市");
          }
        });
      }, positiveBtnText: '果断发布');
    }
  }

  void _initEditData() {
    _detailModel.marketInfo = WareDetailModel.fromJson(json.decode(json.encode(widget.detail)));
    rentMode = _detailModel.marketInfo?.priceDescribe??"次";
  }
}
