import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_select_model.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_house_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_select_page.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_apply.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_label.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_house_select.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/home/tip_page.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

//装修出入证model
class DecorationPassCardTypeStateModel extends Model {
  DecorationPassCardDetails applyRequest = new DecorationPassCardDetails();
  int selectedTypeIndex = -1; //默认选中的类型项
  var applyTypeList = new List<CommonSelectModel>();
  List<DecorationPassCardHouse> _houseList; //默认项目下的房屋列表
  int selectedProjectIndex = -1; //默认选中的项目
  bool isOwner;//是否存在业主的房屋


  //设置默认的客户类型
  setDefaultType(){
    isOwner = stateModel.customerProper==customerYZ;
    if(!isOwner&& stateModel.defaultProjectId!=null){
      _initHouseList();
    }
  }
  //客户类型设置(必选一个)
  setCustomerType(int index, bool selected) {
    if (selected && index != selectedTypeIndex) {
      //选中
      applyTypeList[index].selected = selected;
      if (selectedTypeIndex >= 0) {
        //取消原来选中的
        applyTypeList[selectedTypeIndex].selected = false;
      }
      selectedTypeIndex = index;
      getApplyHouseList();
    }
    notifyListeners();
  }

  //获取可申请的房屋列表
  getApplyHouseList() {
    CommonToast.show(msg: "获取房屋列表...");
    applyRequest = new DecorationPassCardDetails();
    _houseList=null;
    selectedProjectIndex = -1; //默认选中的项目
    Map<String, dynamic> params = new Map();
    params["type"] = applyTypeList[selectedTypeIndex].code;
    params["operationCust"] = stateModel.customerId;
    HttpUtil.post(HttpOptions.decorationPassCardApplyHouse, _getHouseListCallBack,
        jsonData: json.encode(params),errorCallBack: _getHouseListError);
  }

  //获取房屋成功
  _getHouseListCallBack(data){
    CommonToast.dismiss();
    try {
      DecorationPassCardHouseResponse resultModel = DecorationPassCardHouseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          if(resultModel.houseList!=null&&resultModel.houseList.length>0){
            _houseList=resultModel.houseList;
            if(_houseList.length==1){
              selectedProjectIndex=0;
              applyRequest.projectId=_houseList[0].projectId;
              applyRequest.formerName=_houseList[0].formerName;
              if(_houseList[0].houseVoList!=null&&_houseList[0].houseVoList.length==1){
                HouseInfo info=_houseList[0].houseVoList[0];
                  applyRequest.houseId = info?.houseId;
                  applyRequest.houseName =StringsHelper.getStringValue(info.buildName) +
                      StringsHelper.getStringValue(info.unitName) +
                      StringsHelper.getStringValue(info.houseNo);
              }
            }
            notifyListeners();
          }else{
            CommonToast.show(type: ToastIconType.FAILED, msg: "无可选择的房屋列表");
          }
        } else {
          CommonToast.show(type: ToastIconType.FAILED,
              msg: resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "获取房屋列表失败,返回参数错误");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "获取房屋列表失败，返回参数错误");
    }
  }

  //通用网络请求错误回调
  _getHouseListError(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: "获取房屋列表异常："+data?.toString());
  }


  //选择社区
  selectCommunity(){
    if(selectedTypeIndex<0) {
      CommonToast.show(type: ToastIconType.INFO,msg: label_please_select_type);
    }else if(_houseList==null||_houseList.isEmpty) {
      CommonToast.show(type: ToastIconType.INFO,msg: "无可选择的房屋列表");
    }else{
      Navigate.toNewPage(CommonSelectPage("社区选择",_houseList?.map((DecorationPassCardHouse house) => house.formerName)?.toList()??null,selectedProjectIndex),callBack: (index){
        applyRequest.projectId=_houseList[index].projectId;
        applyRequest.formerName=_houseList[index].formerName;
        selectedProjectIndex=index;
        notifyListeners();
      });
    }
  }

  //选择房屋
  selectHouse(){
    if(applyRequest.projectId==null) {
      CommonToast.show(type: ToastIconType.INFO,msg: label_please_select_community);
    }else{
      Navigate.toNewPage(SelectHouseFromProjectPage(_houseList[selectedProjectIndex].houseVoList, applyRequest.houseId),
          callBack: (HouseInfo info) {
            if (info != null) {
              applyRequest.houseId = info?.houseId;
              applyRequest.houseName =StringsHelper.getStringValue(info.formerName) +StringsHelper.getStringValue(info.buildName) +
                      StringsHelper.getStringValue(info.unitName) +
                      StringsHelper.getStringValue(info.houseNo);
            }
          });
    }
  }

  //校验数据
  checkData(){
    if(selectedTypeIndex<0){
      CommonToast.show(type: ToastIconType.FAILED,msg: label_please_select_type);
      return;
    }else if(applyRequest.projectId == null){
      CommonToast.show(type: ToastIconType.FAILED,msg: label_please_select_community);
      return;
    }else if(applyRequest.houseId == null){
      CommonToast.show(type: ToastIconType.FAILED,msg: label_please_select_house);
      return;
    }

    applyRequest.type=StringsHelper.getIntValue(applyTypeList[selectedTypeIndex].code);
    applyRequest.custId=stateModel.customerId;
    applyRequest.operationCust=stateModel.customerId;
    _toApplyPage();
  }

  //跳转到申请页面
  _toApplyPage(){
    Navigate.toNewPage(DecorationPassCardApplyPage(applyRequest),callBack: (success){
      if(success!=null&&success){
        Navigate.closePage();
      }
    });
  }

  //初始化数据
  initSelectData() {
    if(applyTypeList.isEmpty){
      applyTypeList.add(new CommonSelectModel(
          "1", "业主", false));
      applyTypeList.add(new CommonSelectModel(
          "2", "租户", false));
      applyTypeList.add(new CommonSelectModel(
          "3", "施工负责人", false));
    }
  }

  //获取当前项目下已认证的房屋列表
  void _initHouseList() {
    stateModel.getCertifiedHouseByProject(callBack: ({List<HouseInfo> houseList, failedMsg}) {
      if (houseList != null) {
        houseList.forEach((HouseInfo info) {
          if (!isOwner && info.custProper == customerYZ) {
            isOwner = true;
            return;
          }
        });
      }
    });
  }
}