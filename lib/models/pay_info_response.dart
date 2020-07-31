import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_info_response.g.dart';


@JsonSerializable()
class PayInfoResponse extends BaseResponse {


  @JsonKey(name: 'data')
  PayInfo data;

  PayInfoResponse(this.data,);

  factory PayInfoResponse.fromJson(Map<String, dynamic> srcJson) => _$PayInfoResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayInfoResponseToJson(this);

}


@JsonSerializable()
class PayInfo extends Object {

  @JsonKey(name: 'attach')
  String attach;

  @JsonKey(name: 'bank_type')
  String bankType;

  @JsonKey(name: 'charset')
  String charset;

  @JsonKey(name: 'device_info')
  String deviceInfo;

  @JsonKey(name: 'err_code')
  String errCode;

  @JsonKey(name: 'err_msg')
  String errMsg;

  @JsonKey(name: 'fee_type')
  String feeType;

  @JsonKey(name: 'gmt_create_time')
  String gmtCreateTime;

  @JsonKey(name: 'mch_id')
  String mchId;

  @JsonKey(name: 'nonce_str')
  String nonceStr;

  @JsonKey(name: 'notify_id')
  String notifyId;

  @JsonKey(name: 'out_refund_no')
  String outRefundNo;

  @JsonKey(name: 'out_trade_no')
  String outTradeNo;

  @JsonKey(name: 'out_transaction_id')
  String outTransactionId;

  @JsonKey(name: 'pay_fee')
  String payFee;

  @JsonKey(name: 'pay_type')
  String payType;

  @JsonKey(name: 'pay_url')
  String payUrl;

  @JsonKey(name: 'refund_channel')
  String refundChannel;

  @JsonKey(name: 'refund_count')
  int refundCount;

  @JsonKey(name: 'refund_fee')
  int refundFee;

  @JsonKey(name: 'refund_no')
  String refundNo;

  @JsonKey(name: 'refund_total')
  String refundTotal;

  @JsonKey(name: 'result_code')
  String resultCode;

  @JsonKey(name: 'result_msg')
  String resultMsg;

  @JsonKey(name: 'return_code')
  String returnCode;

  @JsonKey(name: 'return_msg')
  String returnMsg;

  @JsonKey(name: 'sign')
  String sign;

  @JsonKey(name: 'sign_type')
  String signType;

  @JsonKey(name: 'total_fee')
  int totalFee;

  @JsonKey(name: 'trade_end_time')
  String tradeEndTime;

  @JsonKey(name: 'trade_pay_time')
  String tradePayTime;

  @JsonKey(name: 'trade_state')
  String tradeState;

  @JsonKey(name: 'transaction_id')
  String transactionId;

  PayInfo(this.attach,this.bankType,this.charset,this.deviceInfo,this.errCode,this.errMsg,this.feeType,this.gmtCreateTime,this.mchId,this.nonceStr,this.notifyId,this.outRefundNo,this.outTradeNo,this.outTransactionId,this.payFee,this.payType,this.payUrl,this.refundChannel,this.refundCount,this.refundFee,this.refundNo,this.refundTotal,this.resultCode,this.resultMsg,this.returnCode,this.returnMsg,this.sign,this.signType,this.totalFee,this.tradeEndTime,this.tradePayTime,this.tradeState,this.transactionId,);

  factory PayInfo.fromJson(Map<String, dynamic> srcJson) => _$PayInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayInfoToJson(this);

}


