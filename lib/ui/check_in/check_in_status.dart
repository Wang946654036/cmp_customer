//租户入驻申请状态
const String auditWaiting = "DSH"; //待审核
const String payWaiting = "DJF"; //待缴费
const String auditFailed = "SHBTG"; //不通过
const String cancelled = "YCD"; //已撤单
const String settledWaiting= "DRZ"; //待入驻
const String completed = "YRZ"; //已入驻

getStateText(String state) {
  var stateText = "";
  switch (state) {
    case auditWaiting:
      stateText = "待审核";
      break;
    case payWaiting:
      stateText = "待缴费";
      break;
    case auditFailed:
      stateText = "审核不通过";
      break;
    case cancelled:
      stateText = "已撤单";
      break;
    case settledWaiting:
      stateText = "待入驻";
      break;
    case completed:
      stateText = "已入驻";
      break;
  }
  return stateText;
}