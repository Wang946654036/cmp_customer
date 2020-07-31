import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:flutter/material.dart';
import 'package:tip_dialog/tip_dialog.dart';

enum ToastIconType {
  LOADING,
  INFO,
  SUCCESS,
  FAILED,
}

///
/// 统一样式toast和加载框，上面icon下面文字
///
class CommonToast {
  static Map<ToastIconType, TipDialogType> _typeMap = {
    ToastIconType.LOADING: TipDialogType.LOADING,
    ToastIconType.SUCCESS: TipDialogType.SUCCESS,
    ToastIconType.FAILED: TipDialogType.FAIL,
    ToastIconType.INFO: TipDialogType.INFO,
    null: TipDialogType.LOADING,
  };

  static void show({ToastIconType type = ToastIconType.LOADING, String msg = '提交中'}) {
    if (tipDialogKey.currentState.isShow) tipDialogKey.currentState.dismiss();
    tipDialogKey.currentState.show(
        tipDialog: TipDialog(
          type: _typeMap[type],
          tip: msg ?? '',
        ),
        isAutoDismiss: !(type == ToastIconType.LOADING));
  }


//  static void dismiss() {
//    tipDialogKey.currentState.dismiss();
//  }

  static void dismiss() {
    if (tipDialogKey.currentState != null &&
        tipDialogKey.currentState.isShow) tipDialogKey.currentState.dismiss();
  }


  static void showMic(String tips) {
    tipDialogKey.currentState.show(
        tipDialog: new TipDialog.customIcon(
          icon: new Icon(
            Icons.mic,
            color: Colors.white,
            size: 50.0,
            textDirection: TextDirection.ltr,
          ),
          tip: tips,
        ),
        isAutoDismiss: false
    );
  }
}



