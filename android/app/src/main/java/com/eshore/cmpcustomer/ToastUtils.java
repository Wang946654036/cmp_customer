package com.eshore.cmpcustomer;

import android.content.Context;
import android.view.Gravity;
import android.widget.Toast;

/**
 * 单例Toast, 保证不重复显示，响应最新的toast
 */
public class ToastUtils {

    private static Toast mToast;

    public static void showBottomToast(Context context, String string) {
        if (mToast != null){
            mToast.cancel();
            mToast = mToast.makeText(context, string, Toast.LENGTH_SHORT);
        }else {
            mToast = mToast.makeText(context, string, Toast.LENGTH_SHORT);
        }
        mToast.show();
    }

    public static void showCenterToast(Context context, String string) {
        if (mToast != null){
            mToast.cancel();
            mToast = mToast.makeText(context, string, Toast.LENGTH_SHORT);
            mToast.setGravity(Gravity.CENTER, 0, 0);
        }else {
            mToast = mToast.makeText(context, string, Toast.LENGTH_SHORT);
            mToast.setGravity(Gravity.CENTER, 0, 0);
        }
        mToast.show();
    }
}
