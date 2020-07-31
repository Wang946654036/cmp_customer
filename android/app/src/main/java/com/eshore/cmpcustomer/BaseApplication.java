package com.eshore.cmpcustomer;

import android.app.Application;
import android.content.Context;

import cafe.adriel.androidaudioconverter.AndroidAudioConverter;
import cafe.adriel.androidaudioconverter.callback.ILoadCallback;
import io.flutter.app.FlutterApplication;
import io.sentry.Sentry;
import io.sentry.android.AndroidSentryClientFactory;
import android.os.Build;
import android.os.StrictMode;

import com.lope.smartlife.sdk.LopeAPI;

public class BaseApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        //音频转换初始化
        AndroidAudioConverter.load(this, new ILoadCallback() {
            @Override
            public void onSuccess() {
                // Great!
            }
            @Override
            public void onFailure(Exception error) {
                // FFmpeg is not supported by device
            }
        });


        // android 7.0系统解决拍照的问题
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
            StrictMode.setVmPolicy(builder.build());
            builder.detectFileUriExposure();
        }
        //智锁
        LopeAPI.create(getApplicationContext(), true);
        //错误日志
        Sentry.init("https://1e3937c360ef4716b836c9cdedb45ba2@sentry.io/1759475", new AndroidSentryClientFactory(this));

    }
}
