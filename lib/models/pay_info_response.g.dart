// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayInfoResponse _$PayInfoResponseFromJson(Map<String, dynamic> json) {
  return PayInfoResponse(
    json['data'] == null
        ? null
        : PayInfo.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$PayInfoResponseToJson(PayInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

PayInfo _$PayInfoFromJson(Map<String, dynamic> json) {
  return PayInfo(
    json['attach'] as String,
    json['bank_type'] as String,
    json['charset'] as String,
    json['device_info'] as String,
    json['err_code'] as String,
    json['err_msg'] as String,
    json['fee_type'] as String,
    json['gmt_create_time'] as String,
    json['mch_id'] as String,
    json['nonce_str'] as String,
    json['notify_id'] as String,
    json['out_refund_no'] as String,
    json['out_trade_no'] as String,
    json['out_transaction_id'] as String,
    json['pay_fee'] as String,
    json['pay_type'] as String,
    json['pay_url'] as String,
    json['refund_channel'] as String,
    json['refund_count'] as int,
    json['refund_fee'] as int,
    json['refund_no'] as String,
    json['refund_total'] as String,
    json['result_code'] as String,
    json['result_msg'] as String,
    json['return_code'] as String,
    json['return_msg'] as String,
    json['sign'] as String,
    json['sign_type'] as String,
    json['total_fee'] as int,
    json['trade_end_time'] as String,
    json['trade_pay_time'] as String,
    json['trade_state'] as String,
    json['transaction_id'] as String,
  );
}

Map<String, dynamic> _$PayInfoToJson(PayInfo instance) => <String, dynamic>{
      'attach': instance.attach,
      'bank_type': instance.bankType,
      'charset': instance.charset,
      'device_info': instance.deviceInfo,
      'err_code': instance.errCode,
      'err_msg': instance.errMsg,
      'fee_type': instance.feeType,
      'gmt_create_time': instance.gmtCreateTime,
      'mch_id': instance.mchId,
      'nonce_str': instance.nonceStr,
      'notify_id': instance.notifyId,
      'out_refund_no': instance.outRefundNo,
      'out_trade_no': instance.outTradeNo,
      'out_transaction_id': instance.outTransactionId,
      'pay_fee': instance.payFee,
      'pay_type': instance.payType,
      'pay_url': instance.payUrl,
      'refund_channel': instance.refundChannel,
      'refund_count': instance.refundCount,
      'refund_fee': instance.refundFee,
      'refund_no': instance.refundNo,
      'refund_total': instance.refundTotal,
      'result_code': instance.resultCode,
      'result_msg': instance.resultMsg,
      'return_code': instance.returnCode,
      'return_msg': instance.returnMsg,
      'sign': instance.sign,
      'sign_type': instance.signType,
      'total_fee': instance.totalFee,
      'trade_end_time': instance.tradeEndTime,
      'trade_pay_time': instance.tradePayTime,
      'trade_state': instance.tradeState,
      'transaction_id': instance.transactionId,
    };
