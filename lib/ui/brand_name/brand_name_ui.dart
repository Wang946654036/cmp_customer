//SPMP_TJSQ-提交申请、SPMP_SLPG-受理评估、SPMP_XGSQ-修改申请、SPMP_QRFA-确认方案、SPMP_QRZF-确认支付、SPMP_QXSQ-取消申请、SPMP_WGDJ-完工登记
//状态：DSL-待受理、KFTH-客服退回、DQRFA-待确认方案、DZF-待支付、ZZZ-制作中、YWG-已完工、YQX-已取消、YGD-已关单
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/brand_name_obj.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_type_detail.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

const String auditWaiting = "DSL"; //待受理
const String auditFailed = "KFTH"; //客服会退
const String auditSuc = "DQRFA"; //待确认方案
const String payWaiting = "DZF"; //待支付
const String working = "ZZZ"; //制作中
const String cancelled = "YQX"; //取消办理
const String completed = "YWG"; //已完工
const String closed = 'YGD';//已经关单
//申请类型:SP(水牌),MP(名牌),SPMP(水牌名牌)

const String sp = 'SP';
const String mp = 'MP';
const String spmp = 'SPMP';
const String createTime='申请时间';
const String businessNo = '业务单号';
const String applyType='申请类型';
const String mpApplyCount='名牌数量';
const String mpContent='名牌内容';
const String payFeesStr='应付金额';
const String paymentTime='缴费时间';
const String remark='备注说明';
const String spApplyCount='水牌数量';
const String spContent='水牌内容';
const String useTime='办理时间';
const String deal_progress = "办理进度";


String getTypeName(String type) {
  String name = '';
  switch (type) {
    case sp:
      name = '水牌';
      break;
    case mp:
      name = '名牌';
      break;
    case spmp:
      name = '水牌名牌';
      break;
  }
  return name;
}

String getStateStr(String state) {
  String stateText = '';
  switch (state) {
    case auditWaiting:
      stateText = "待受理";
      break;
    case auditFailed:
      stateText = "客服回退";
      break;
    case auditSuc:
      stateText = "待确认方案";
      break;
    case completed:
      stateText = "已完工";
      break;
    case cancelled:
      stateText = "已取消";
      break;
    case working:
      stateText = "制作中";
      break;
    case payWaiting:
      stateText = "待支付";
      break;
    case  closed:
      stateText = '已关单';
      break;
  }
  return stateText;
}
class BrandNameTypeCard extends StatelessWidget {
  List<SettingList> infos;
int position;
Function callback;
  BrandNameTypeCard(this.infos,{this.position=0,this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(infos==null){
      infos = new List();
    }
    if(position==null){
      position=0;
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BrandNameTypeDetail(infos,callback);
        }));
      },
      child: Container(
        color: Colors.white,
        height: UIData.spaceSize48 * 2 + UIData.spaceSize10,

        padding: EdgeInsets.all(UIData.spaceSize16),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: UIData.spaceSize30 * 2 + UIData.spaceSize10,
              width: UIData.spaceSize30 * 3 + UIData.spaceSize3,
              margin: EdgeInsets.only(right: UIData.spaceSize12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: UIData.yellowColor,width: 1),),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage.assetNetwork(
                  placeholder: UIData.imagePayServiceDefault,
                  image: ((infos?.length??-1)>position)?infos[position]?.photoAttList!=null?infos[position].photoAttList.length>0?HttpOptions.showPhotoUrl(infos[position].photoAttList[0].attachmentUuid):'':'':'',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: UIData.spaceSize20),
                  padding: EdgeInsets.symmetric(vertical: UIData.spaceSize3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:  CommonText.black16Text(infos.length>0?infos[position].settingTitle:'')),
                      Expanded(child:  CommonText.lighterRed15Text(
                          infos.length>0?'${infos[position].markPrice??''}元':'')),
                    ],
                  ),
                )),
            Icon(
              Icons.keyboard_arrow_right,
              color: UIData.lighterGreyColor,
            )
          ],
        ),
      ),
    );
  }
}