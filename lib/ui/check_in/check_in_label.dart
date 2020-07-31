const String label_apply_tenant_entry_apply = "租户入驻申请";
const String label_apply_base_info = "基本信息";
const String label_apply_tenant_type = "租户类型";
const String label_apply_individual_customer = "个人客户";
const String label_apply_enterprise_customer = "企业客户";
const String label_apply_entry_type = "入驻类型";
const String label_apply_apply_person = "申请人";
const String label_apply_apply_phone = "申请人电话";
const String label_apply_community = "社区";
const String label_apply_house = "房屋";
const String label_apply_letter = "入驻确认函";
const String label_apply_letter_required = "入驻确认函（必填）";
const String label_apply_appointment_time = "预约收楼时间";
const String label_apply_agree_time = "商定收楼时间";
const String label_apply_customer_info = "客户信息";
const String label_apply_house_tenant = "房屋租户";
const String label_apply_document_type = "证件类型";
const String label_apply_document_number = "证件号码";
const String label_apply_gender = "性别";
const String label_apply_gender_man = "男";
const String label_apply_gender_woman = "女";
const String label_apply_contact_person = "联系人";
const String label_apply_contact_phone = "联系电话";
const String label_apply_house_use = "房屋用途";
const String label_apply_entry_time = "入驻(入伙)日期";
const String label_apply_emergency_contact_person = "紧急联系人";
const String label_apply_emergency_contact_phone = "紧急联系人电话";
const String label_apply_emergency_contact_relation = "与客户关系";
const String label_apply_primary_contact_person = "主要联系人";
const String label_apply_primary_contact_phone = "主要联系人电话";
const String label_apply_attachment_info = "附件信息（身份证、证件照等图片）";
const String label_apply_entry_tip = "入驻温馨提示";
const String label_apply_enterprise_legal_person = "企业法人";
const String label_apply_enterprise_info = "企业信息";
const String label_apply_enterprise_nature = "企业性质";
const String label_apply_enterprise_code = "企业信用代码";
const String label_apply_property_area = "物业面积";
const String label_apply_property_location = "物业位置";
const String label_apply_property_address = "地址";
const String label_apply_bank_name = "开户银行";
const String label_apply_bank_number = "开户账户";
const String label_apply_taxes = "税率";
const String label_apply_taxes_type = "纳税类别";


const String label_please_select_type = "请选择类型（必填）";
const String label_please_select_community = "请选择社区（必填）";
const String label_please_select_house = "请选择房屋（必填）";
const String label_please_select_time = "请选择时间（必填）";


const String label_apply_select_status = "处理情况";


//const Map<String, String> documentMap = {
//  'SFZ': '身份证',
//  'HZ': '护照',
//  'JSZ': '驾驶证',
//  'XSZ': '学生证',
//  'GATXZ': '港澳通行证',
//  'RTZ': '入台证',
//  'HKB': '户口本',
//  'XGSFZ': '香港身份证',
//  'JGZ': '军官证',
//  'TBZ': '台胞证',
//  'AMSFZ': '澳门身份证',
//  'TWSFZ': '台湾身份证',
//  'YYZZ': '营业执照',
//  'TYSHXYDM': '统一社会信用代码',
//};
//
//const Map<String, String> documentIndividualMap = {
//  'SFZ': '身份证',
//  'HZ': '护照',
//  'JSZ': '驾驶证',
//  'XSZ': '学生证',
//  'GATXZ': '港澳通行证',
//  'RTZ': '入台证',
//  'HKB': '户口本',
//  'XGSFZ': '香港身份证',
//  'JGZ': '军官证',
//  'TBZ': '台胞证',
//  'AMSFZ': '澳门身份证',
//  'TWSFZ': '台湾身份证',
//};

//const Map<String, String> documentEnterpriseMap = {
//  'YYZZ': '营业执照',
//  'TYSHXYDM': '统一社会信信用代码',
//};

const Map<String, String> entryTypeMap = {
  'XZL': '写字楼',
  'SP': '商铺',
  'GY': '公寓',
};

const Map<String, String> houseUseTypeMap = {
  'ZZ': '自住',
  'CZ': '出租',
  'KZ': '空置',
  'BG': '办公',
  'GG': '公共',
  'PT': '配套',
};


//租户类型名称
getRentTypeName(String type){
  if(type=="G"){
    return "个人客户";
  }else if(type=="Q"){
    return "企业客户";
  }else{
    return "";
  }
}

////获取ID类型名称
//getIdType(String type){
//  String name="";
//  switch(type){
//    case 'SFZ':
//      name='身份证';
//      break;
//    case 'HZ':
//      name='护照';
//      break;
//    case 'JSZ':
//      name='驾驶证';
//      break;
//    case 'XSZ':
//      name='学生证';
//      break;
//    case 'GATXZ':
//      name='港澳通行证';
//      break;
//    case 'RTZ':
//      name='入台证';
//      break;
//  }
//}

