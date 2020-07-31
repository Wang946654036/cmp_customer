

const Map<String, String> customerTypeMap = {
  //客户属性:YZ-业主，ZH-租户，JTCY-业主成员，ZHCY-租户成员
  'YZ': '业主',
  'ZH': '租户',
  'JTCY': '业主成员',
  'ZHCY': '租户成员',
  '': '',
  null: '',
};

//认证类型
const String authTypeGR = 'G'; //个人认证
const String authTypeQY = 'Q'; //企业认证