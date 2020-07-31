
//证件类型:
// 个人：SFZ-身份证,HZ-护照,JSZ-驾驶证,XSZ-学生证,
// GZTXZ-港澳通行证,RTZ-入台证,HKB-户口本,XGSFZ-香港身份证；
// 企业：YYZZ-营业执照，TYSHXYDM-统一社会信信用代码
const Map<String, String> documentGRMap = {
  'SFZ': '身份证',
  'HZ': '护照',
  'JSZ': '驾驶证',
  'XSZ': '学生证',
  'GATXZ': '港澳通行证',
  'RTZ': '入台证',
  'JGZ': '军官证',
  'TBZ': '台胞证',
  'HKB': '户口本',
  'XGSFZ': '香港身份证',
  'AMSFZ': '澳门身份证',
  'TWSFZ': '台湾身份证',
};
//const Map<String, String> documentGRMapForVisit = {
//  'SFZ': '身份证',
//  'JZZ': '居住证',
//  'JSZ': '驾驶证',
//  'JGZ': '军官证',
//  'HKB': '户口本',
//};
//探亲/访友
//
//送水/送煤气
//
//送快递/送货/送餐
//
//安装/维修
//
//房屋租售
//
//家政/教学/美容/治疗
//
//搬家
//
//抢险救助
//
//其他
const Map<String, String> documentMapForVisitReason = {
  'TQ': '探亲/访友',
  'SS': '送水/送煤气',
  'SKD': '送快递/送货/送餐',
  'AZ': '安装/维修',
  'FWZS': '房屋租售',
  'JZ': '家政/教学/美容/治疗',
  'BJ': '搬家',
  'QXJZ': '抢险救助',
  'QT': '其他',
};
//证件类型:
// 个人：SFZ-身份证,HZ-护照,JSZ-驾驶证,XSZ-学生证,
// GZTXZ-港澳通行证,RTZ-入台证,HKB-户口本,XGSFZ-香港身份证；
// 企业：YYZZ-营业执照，TYSHXYDM-统一社会信用代码
const Map<String, String> documentQYMap = {
  'YYZZ': '营业执照',
  'TYSHXYDM': '统一社会信用代码',
};


const String houseAuditWaiting = "DSH"; //待审核
const String houseAuditFailed = "RZSB"; //审核不通过 （认证失败）
const String houseAuditSuccess = "RZTG"; //审核通过（已认证）
const Map<String, String> auditStatusMap = {
  houseAuditWaiting: '待审核',
  houseAuditFailed: '认证失败',
  houseAuditSuccess: '已认证',
  '': '',
  null: '',
};