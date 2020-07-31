import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/check_in/check_in_agreement.dart';
import 'package:cmp_customer/ui/check_in/check_in_label.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_house_select.dart';
import 'package:cmp_customer/ui/home/tip_page.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

enum CustomerType{
  enterprise,
  individual
}

//租户入驻申请model
class CheckInApplyModel extends Model {
  CheckInDetails applyRequest = new CheckInDetails();
  bool isEnterprise=false;//true：企业客户，false：个人客户
  TextEditingController applyNameController = new TextEditingController();//申请人
  TextEditingController applyPhoneController = new TextEditingController();//申请人电话
  TextEditingController tenantNameController = new TextEditingController();//房租租户
  TextEditingController documentNumberController = new TextEditingController();//证件号码
  TextEditingController contactNameController = new TextEditingController();//联系人
  TextEditingController contactPhoneController = new TextEditingController();//联系电话
  TextEditingController emergencyNameController = new TextEditingController();//紧急联系人
  TextEditingController emergencyPhoneController = new TextEditingController();//紧急联系人电话
  TextEditingController relationController = new TextEditingController();//与客户关系
  TextEditingController legalController = new TextEditingController();//企业法人
  TextEditingController enterpriseNatureController = new TextEditingController();//企业性质
  TextEditingController propertyAreaController = new TextEditingController();//物业面积
  TextEditingController propertyLocationController = new TextEditingController();//物业位置
  TextEditingController propertyAddressController = new TextEditingController();//物业地址
  TextEditingController bankNameController = new TextEditingController();//开户银行
  TextEditingController bankNumberController = new TextEditingController();//开户账号
  TextEditingController taxesController = new TextEditingController();//税率
  TextEditingController taxesTypeController = new TextEditingController();//纳税类别
  TextEditingController enterpriseCodeController = new TextEditingController();//企业信用代码

  List<HouseInfo> _houseList; //默认项目下的房屋列表
//  bool isLoadingHouse=false;//加载房屋信息中

//  //获取当前项目下已认证的房屋列表
//  getHouseList() {
//    isLoadingHouse=true;
//    stateModel.getCertifiedHouseByProject(callBack: ({List<HouseInfo> houseList, failedMsg}) {
//      if (failedMsg == null) {
//        _houseList = houseList;
//        //applyModel为空则为新建
//        _houseList.forEach((HouseInfo info) {
//          if (info.isDefaultHouse == '1') {
//            //默认房屋
//            applyRequest.houseId = info.houseId;
//            applyRequest.houseNo =StringsHelper.getStringValue(info.buildName) +
//                StringsHelper.getStringValue(info.unitName) +
//                StringsHelper.getStringValue(info.houseNo);
//          }
//        });
//      }
//      isLoadingHouse = false;
//      notifyListeners();
//    });
//  }

  //设置客户类型
  setCustomerType(CustomerType type){
    isEnterprise=type==CustomerType.enterprise;
    applyRequest.projectId=stateModel.defaultProjectId;//默认项目id
    notifyListeners();
  }
  //选择入驻类型
  setEntryType(int index){
    applyRequest.enterType=entryTypeMap.keys.toList()[index];
    notifyListeners();
  }

  //入驻确认函拍照回调
  imagesLetterCallback(List<Attachment> images){
    applyRequest.attRzqrhList=images;
    notifyListeners();
  }

  //附件拍照回调
  imagesAttachmentCallback(List<Attachment> images){
    applyRequest.attZhrzList=images;
    notifyListeners();
  }

  //选择社区
  selectCommunity(){
    Navigate.toNewPage(CommunitySearchPage(callback: (int projectId, String formerName) {
      applyRequest.projectId=projectId;
      applyRequest.formerName=formerName;
      notifyListeners();
    },));
  }

  //选择房屋
  selectHouse(){
    if(applyRequest.projectId==null) {
      CommonToast.show(type: ToastIconType.INFO,msg: label_please_select_community);
    }else{
      Navigate.toNewPage(SelectHousePage(applyRequest.projectId, applyRequest.formerName),
          callBack: (HouseAddrModel model) {
            if(model!=null){
              applyRequest.houseId = model?.roomId;
              applyRequest.houseNo =StringsHelper.getStringValue(model.buildingName) +
                  StringsHelper.getStringValue(model.unitName) +
                  StringsHelper.getStringValue(model.roomName);
            }
          });
    }
  }

//  //选择房屋
//  selectHouse(){
//    if(!isLoadingHouse){
//      if(_houseList!=null&&_houseList.isNotEmpty){
//        Navigate.toNewPage(SelectHouseFromProjectPage(_houseList, applyRequest.houseId),
//            callBack: (HouseInfo info) {
//              if (info != null) {
//                applyRequest.houseId = info?.houseId;
//                applyRequest.houseNo =StringsHelper.getStringValue(info.buildName) +
//                    StringsHelper.getStringValue(info.unitName) +
//                    StringsHelper.getStringValue(info.houseNo);
//              }
//            });
//      }else{
//        CommonToast.show(type: ToastIconType.FAILED,msg: "当前项目下无可选房屋");
//      }
//    }
//  }

  //设置预约收楼时间
  setAppointmentTime(String date){
    applyRequest.bookReprocessTime=date;
    notifyListeners();
  }

  //选择证件类型
  setDocumentType(int index){
    if(isEnterprise){
      applyRequest.idType=documentQYMap.keys.toList()[index];
    }else{
      applyRequest.idType=documentGRMap.keys.toList()[index];
    }
    notifyListeners();
  }

  //设置性别
  setGender(String gender){
    applyRequest.gender=gender;
    notifyListeners();
  }

  //设置房屋用途
  houseUseType(int index){
    applyRequest.houseUsage=houseUseTypeMap.keys.toList()[index];
    notifyListeners();
  }

  //设置入驻时间
  setEntryTime(String date){
    applyRequest.enterDate=date;
    notifyListeners();
  }

  //跳转到温馨提示页面
  toEntryTipPage(){
//    Navigate.toNewPage(TipPage(null,null));
    Navigate.toNewPage(CopyWritingPage('入驻温馨提示', CopyWritingType.TipsForTenants));
  }

  //校验数据
  checkUploadData(){
    if(StringsHelper.isEmpty(applyRequest.enterType)){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择入驻类型");
      return;
    }else if(StringsHelper.isEmpty(applyNameController.text.trim())){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请输入申请人");
      return;
    }else if(StringsHelper.isEmpty(applyPhoneController.text.trim())){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请输入申请人电话");
      return;
//    }else if (!StringsHelper.isPhone(applyPhoneController.text.trim())) {
//      CommonToast.show(msg: '请输入正确的申请人手机号码', type: ToastIconType.INFO);
//      return;
//    }else if(applyRequest.projectId == null){
//      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择社区");
//      return;
    }
    else if(applyRequest.houseId == null){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择房屋");
      return;
    }else if(applyRequest.houseId == null){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择房屋");
      return;
    }else if(applyRequest.attRzqrhList == null || applyRequest.attRzqrhList.isEmpty){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请上传入驻确认函");
      return;
    }else if(StringsHelper.isEmpty(applyRequest.bookReprocessTime)){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择预约收楼时间");
      return;
    }else if(StringsHelper.isEmpty(tenantNameController.text.trim())){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请输入房屋租户");
      return;
    }else if(StringsHelper.isEmpty(applyRequest.idType)){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择证件类型");
      return;
    }else if(StringsHelper.isEmpty(documentNumberController.text.trim())){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请输入证件号码");
      return;
    }else if(StringsHelper.isEmpty(applyRequest.enterDate)){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请选择入驻(入伙)日期");
      return;
    }else if(StringsHelper.isEmpty(emergencyNameController.text.trim())){
      CommonToast.show(type: ToastIconType.FAILED,msg: isEnterprise?"请输入主要联系人":"请输入紧急联系人");
      return;
    }else if(StringsHelper.isEmpty(emergencyPhoneController.text.trim())){
      CommonToast.show(type: ToastIconType.FAILED,msg: isEnterprise?"请输入主要联系人电话":"请输入紧急联系人电话");
      return;
//    }else if (!StringsHelper.isPhone(emergencyPhoneController.text.trim())) {
//      CommonToast.show(msg: '请输入正确的'+(isEnterprise?"主要联系人":"紧急联系人")+"手机号码", type: ToastIconType.INFO);
//      return;
    }else if(StringsHelper.isEmpty(relationController.text.trim())&&!isEnterprise){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请输入与客户关系");
      return;
    }
    if(applyRequest.attRzqrhList!=null){
      for(int i=0;i<applyRequest.attRzqrhList.length;i++){
        if(applyRequest.attRzqrhList[i]==null){
          CommonToast.show(type: ToastIconType.FAILED,msg: "尚有未上传完成的图片");
          return ;
        }
      }
    }
    if(applyRequest.attZhrzList!=null){
      for(int i=0;i<applyRequest.attZhrzList.length;i++){
        if(applyRequest.attZhrzList[i]==null){
          CommonToast.show(type: ToastIconType.FAILED,msg: "尚有未上传完成的图片");
          return ;
        }
      }
    }

    toAgreementPage();

  }

  //跳转到协议同意页面
  toAgreementPage(){
    //保存需要提交的数据
    applyRequest.rentType=isEnterprise?"Q":"G";
    applyRequest.customerName=applyNameController.text.trim();
    applyRequest.customerPhone=applyPhoneController.text.trim();
    applyRequest.rentersName=tenantNameController.text.trim();
    applyRequest.idNum=documentNumberController.text.trim();
    applyRequest.legalPersonName=legalController.text.trim();
    applyRequest.contactName=contactNameController.text.trim();
    applyRequest.contactPhone=contactPhoneController.text.trim();
    applyRequest.emerContactName=emergencyNameController.text.trim();
    applyRequest.emerContactPhone=emergencyPhoneController.text.trim();
    applyRequest.relationship=relationController.text.trim();

    applyRequest.companyProp=enterpriseNatureController.text.trim();
    applyRequest.rentArea=propertyAreaController.text.trim();
    applyRequest.rentLocation=propertyLocationController.text.trim();
    applyRequest.rentAddress=propertyAddressController.text.trim();
    applyRequest.depositBank=bankNameController.text.trim();
    applyRequest.depositAccount=bankNumberController.text.trim();
    applyRequest.taxRate=taxesController.text.trim();
    applyRequest.taxCategory=taxesTypeController.text.trim();
    applyRequest.companyCreditCode=enterpriseCodeController.text.trim();

    Navigate.toNewPage(CheckInAgreementPage(applyRequest),callBack:(success){
      if(success){
        Navigate.closePage(true);
      }
    },);
  }

  //设置详情信息
  setDetailsInfo(CheckInDetails info){
    applyRequest=info;
    isEnterprise=info.rentType=="Q";
    applyNameController.text=info.customerName??"";
    applyPhoneController.text=info.customerPhone??"";
    tenantNameController.text=info.rentersName??"";
    documentNumberController.text=info.idNum??"";
    legalController.text=info.legalPersonName??"";
    contactNameController.text=info.contactName??"";
    contactPhoneController.text=info.contactPhone??"";
    emergencyNameController.text=info.emerContactName??"";
    emergencyPhoneController.text=info.emerContactPhone??"";
    relationController.text=info.relationship??"";

    enterpriseNatureController.text=info.companyProp??"";
    propertyAreaController.text=info.rentArea??"";
    propertyLocationController.text=info.rentLocation??"";
    propertyAddressController.text=info.rentAddress??"";
    bankNameController.text=info.depositBank??"";
    bankNumberController.text=info.depositAccount??"";
    taxesController.text=info.taxRate??"";
    taxesTypeController.text=info.taxCategory??"";
    enterpriseCodeController.text=info.companyCreditCode??"";

//    applyRequest.rentingEnterId=info.rentingEnterId;//租户入驻业务id
//    applyNameController.text=info.customerName??"";
//    applyPhoneController.text=info.customerPhone??"";
//    tenantNameController.text=info.rentersName??"";
//    documentNumberController.text=info.idNum??"";
//    legalController.text=info.legalPersonName??"";
//    contactNameController.text=info.contactName??"";
//    contactPhoneController.text=info.contactPhone??"";
//    emergencyNameController.text=info.emerContactName??"";
//    emergencyPhoneController.text=info.emerContactPhone??"";
//    relationController.text=info.relationship??"";
//
//    enterpriseNatureController.text=info.companyProp??"";
//    propertyAreaController.text=info.rentArea??"";
//    propertyLocationController.text=info.rentLocation??"";
//    propertyAddressController.text=info.rentAddress??"";
//    bankNameController.text=info.depositBank??"";
//    bankNumberController.text=info.depositAccount??"";
//    taxesController.text=info.taxRate??"";
//    taxesTypeController.text=info.taxCategory??"";
//    enterpriseCodeController.text=info.companyCreditCode??"";
//
//    isEnterprise=info.rentType=="Q";
//    applyRequest.enterType=entryTypeMap[info.enterType];
//    applyRequest.attRzqrhList=info.attRzqrhList;
//    applyRequest.attZhrzList=info.attZhrzList;
//    applyRequest.projectId=info.projectId;
//    applyRequest.projectName=info.projectName;
//    applyRequest.houseId=info.houseId;
//    applyRequest.houseNo=info.houseNo;
//    applyRequest.bookReprocessTime=info.bookReprocessTime;
//    applyRequest.idType=isEnterprise?documentEnterpriseMap[info.idType]:documentIndividualMap[info.idType];
//    applyRequest.gender=info.gender;
//    applyRequest.houseUsage=houseUseTypeMap[info.houseUsage];
//    applyRequest.enterDate=info.enterDate;
  }
}