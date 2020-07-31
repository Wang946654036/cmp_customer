package com.eshore.cmpcustomer;

import android.Manifest;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.os.Vibrator;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import androidx.core.content.ContextCompat;

import com.lope.smartlife.frame.model.Access;
import com.lope.smartlife.frame.model.Lock;
import com.lope.smartlife.sdk.ILopeStateListener;
import com.lope.smartlife.sdk.LopeAPI;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import cafe.adriel.androidaudioconverter.AndroidAudioConverter;
import cafe.adriel.androidaudioconverter.callback.IConvertCallback;
import cafe.adriel.androidaudioconverter.model.AudioFormat;
import cellcom.com.cn.deling.bean.KeyInfo;
import cellcom.com.cn.deling.homepage.core.OpenDoorStatus;
import cellcom.com.cn.deling.homepage.core.OpenDoorUtil;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements OpenDoorUtil.IOpenDoorCallBack, ILopeStateListener {
  //传输通道
  private static final String CHANNEL = "zswy.flutter/channel";

  private Lock mCurLock;
  private String mLockPid;
  private String mLockKey;
  private int mScanDuration = 2000;

  private Handler mMyHandler;
  private List<Lock> mLocks;
  private boolean mBoolean;
  private long mStartTime = -1;

    private String[] mPermissionLists = {
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION};
  private MethodChannel.Result mResult;
  private OpenDoorUtil openDoorUtils;//开门
  private String mCurMethodCall;
  private static final int MSG_SCAN_STOP = 1,MSG_INIT_SUC = 2;
  private String TAG = "到家汇：";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    //初始化传输通道
    initChannel();
    initMyHandler();
    LopeAPI.get().setListener(this);
  }

  private void initChannel(){
    // setMethodCallHandler在此通道上接收方法调用的回调
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                try {
                  mResult=result;
                  mCurMethodCall = methodCall.method;
                  // 通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可
                  if(methodCall.method.equals("openDoor")){//一键开门
                      Map map = methodCall.arguments();
                      if (map != null) {
                          String pid = map.get("pid").toString();
                          String lockId = map.get("lockId").toString();
                          KeyInfo keyInfo=new KeyInfo();
                          keyInfo.setPid(pid);
                          keyInfo.setLock_id(lockId);
                          openDoor(keyInfo);
                      }
//                    toOpenDoor(info[0],info[1]);
                  }else if (methodCall.method.equals("openLopeDoor")) {
                    // 通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可

                    Map map = methodCall.arguments();
                    if (map != null) {
                      mLockPid = map.get("mac").toString();
                      mLockKey = map.get("key").toString();
                      if (TextUtils.isEmpty(mLockKey) || TextUtils.isEmpty(mLockPid)) {
                        String code = "1";
                        String message = ("密码失效");
                        if (code != null) {
                          Map<String, Object> callBackMap = new HashMap<>();
                          callBackMap.put("code", code);
                          callBackMap.put("message", message);
                          flutterCallBack(callBackMap);
                        }
                        return;
                      }
                      long checkTime = System.currentTimeMillis() - mStartTime;
                      if (mStartTime != -1 && checkTime <= 10000) {//在5秒内
                        boolean canOpen=false;
                        if (mLocks != null && mLocks.size() >= 0) {
                          for (Lock l : mLocks) {
                            if (mLockPid.equalsIgnoreCase(l.getMac())) {
                              mCurLock = l;
                              canOpen = true;
                              break;
                            }
                          }
                        }
                        if (canOpen&&mCurLock != null && mLockPid.equalsIgnoreCase(mCurLock.getMac())) {//存在当前的mac则直接开门
                          openLopeLockCheckPermissions(3);
                        } else {//否则则扫描
                          openLopeLockCheckPermissions(2);
                        }
                      } else {//重新扫描
                        openLopeLockCheckPermissions(2);
                      }
                    }
                  } else if (methodCall.method.equals("openLopeDoorInit")) {
                    LopeAPI.get().init("0oki87uyhnj76545tgls987");
//                    openLopeLockCheckPermissions(1);
                  } else if(methodCall.method.equals("audioConvert")){//音频转换
                    String fileName=methodCall.arguments();
                    if(fileName==null){//文件不能为空
                      result.success("error file is null");
                      return;
                    }
                    File file = new File(fileName);
                    if(file==null||!file.exists()){
                      result.success("error file does not exist");
                      return;
                    }

                    //转换回调
                    IConvertCallback callback = new IConvertCallback() {
                      @Override
                      public void onSuccess(File convertedFile) {
                        // So fast? Love it!
                        result.success(convertedFile.getPath());
                      }
                      @Override
                      public void onFailure(Exception error) {
                        // Oops! Something went wrong
                        result.success("error convert audio fail");
                      }
                    };
                    //开始转换
                    AndroidAudioConverter.with(MainActivity.this)
                            // Your current audio file
                            .setFile(file)

                            // Your desired audio format
                            .setFormat(AudioFormat.MP3)

                            // An callback to know when conversion is finished
                            .setCallback(callback)

                            // Start conversion
                            .convert();
                  } else if (methodCall.method.equals("back2Desk")) {
                    moveTaskToBack(false);
                  }
  //                else if(methodCall.method.equals("toZSZY")){//跳转到招商置业
  //                  if(isAppAvilible(MainActivity.this,"com.chanxa.cmpcapp")){
  //                    toZSZY();
  //                  }else {
  //                    result.success("error application not installed");
  //                  }
  //                }
                  else{
                    result.notImplemented();
                  }

                }catch (Exception e){

                }
              }
            }
    );
  }

//  //跳转到开门页面
//  private void toOpenDoor(String pid,String lockid){
//    Intent intent = new Intent(this,OpenDoorActivity.class);
//    intent.putExtra("pid",pid);
//    intent.putExtra("lockid",lockid);
//    startActivity(intent);
//  }

  //跳转到招商置业
//  private void toZSZY(){
//    Intent intent = new Intent(Intent.ACTION_MAIN);
//    ComponentName componentName = new ComponentName("com.chanxa.cmpcapp", "com.chanxa.cmpcapp.MainActivity");
//    intent.setComponent(componentName);
//    startActivity(intent);
//  }


//  /**
//   * 判断 用户是否安装app
//   */
//  private boolean isAppAvilible(Context context,String packageName) {
//    final PackageManager packageManager = context.getPackageManager();// 获取packagemanager
//    List<PackageInfo> pinfo = packageManager.getInstalledPackages(0);// 获取所有已安装程序的包信息
//    if (pinfo != null) {
//      for (int i = 0; i < pinfo.size(); i++) {
//        String pn = pinfo.get(i).packageName;
//        if (pn.equals(packageName)) {
//          return true;
//        }
//      }
//    }
//    return false;
//  }

  void openLopeLockCheckPermissions(int nextType) {//1:init;2:scan;3:open
    //检查定位和写入权限
    // API level 大于等于 23(Android 6.0) 时需要打开定位权限
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      if (!hasPermissions(this, mPermissionLists)) {
        //如果没有权限则先请求权限，等用户拒绝或允许完请求权限后，再进行跳转
        flutterCallBack(null);
        requestPermissions(mPermissionLists, 1);
        return;
      }
    }

    //监测蓝牙，并请求打开蓝牙
    BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    if (bluetoothAdapter != null) {
      if (bluetoothAdapter.isEnabled()) {
        switch (nextType) {
          case 1:
            LopeAPI.get().init("0oki87uyhnj76545tgls987");
            break;
          case 2:
            if(mLocks==null)
              mLocks = new ArrayList<>();
            else
              mLocks.clear();

            mCurLock = new Lock();
            mStartTime = System.currentTimeMillis();
            LopeAPI.get().startScan(mScanDuration, true);
            mBoolean = false;
            break;
          case 3:
            LopeAPI.get().openLock(mCurLock.getMac(), mLockKey, mCurLock.getFwVersion());
            break;
        }
      } else {
        registerBluetoothReceiver();
        bluetoothAdapter.enable();
      }
    } else {
      Map<String, Object> map = new HashMap<>();
      map.put("code", "1");
      map.put("message", "蓝牙不可用");
      flutterCallBack(map);
    }

  }
  //蓝牙开门
  void openDoor(KeyInfo keyInfo){
    //检查定位和写入权限
    // API level 大于等于 23(Android 6.0) 时需要打开定位权限
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      if (!hasPermissions(this, mPermissionLists)) {
        //如果没有权限则先请求权限，等用户拒绝或允许完请求权限后，再进行跳转
        flutterCallBack(null);
        requestPermissions(mPermissionLists,1);
        return;
      }
    }
    if(openDoorUtils==null){
      openDoorUtils=OpenDoorUtil.openDoorInit(this);
    }
    int result = openDoorUtils.bleInit(this);
    if(result == -4){
      Map<String,Object> map = new HashMap<>();
      map.put("code","1");
      map.put("message","您的手机不支持ble,无法使用手机开门！");
      flutterCallBack(map);
    }else{
      //监测蓝牙，并请求打开蓝牙
      BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
      if (bluetoothAdapter != null) {
        ArrayList keys=new ArrayList<>();
        keys.add(keyInfo);
        openDoorUtils.setMyKeys(keys);
        if(bluetoothAdapter.isEnabled()){
          openDoorUtils.openTheDoorByClick();
        }else{
          registerBluetoothReceiver();
          bluetoothAdapter.enable();
        }
      }else{
        Map<String,Object> map = new HashMap<>();
        map.put("code","1");
        map.put("message","蓝牙不可用");
        flutterCallBack(map);
      }
    }
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    if(openDoorUtils!=null){
      openDoorUtils.onDestroy();
      openDoorUtils=null;
    }
  }

  //回调flutter返回
  private void flutterCallBack(Object data){
    if(mResult!=null){
      mResult.success(data);
      mResult=null;//回调后置空
    }
  }

  //蓝牙开门状态监听
  @Override
  public void onOpening(int status) {
    String message = null;
    String code = null;
    switch (status) {
      /**
       * 蓝牙未开启
       */
      case OpenDoorStatus.BLUETOOTH_DISABLE:
        code="1";
        message = ("蓝牙未开启");
        break;
      /**
       * 没有钥匙
       */
      case OpenDoorStatus.KEY_EMPTY:
        code="1";
        message = ("钥匙列表为空");
        break;
      /**
       * 开始扫描设备
       */
      case OpenDoorStatus.SCAN_START:
        break;
      /**
       * 连接超时
       */
      case OpenDoorStatus.CONNECT_OVERTIME:
        code="1";
        message = ("连接超时");
        break;
      /**
       * 其它连接错误
       */
      case OpenDoorStatus.CONNECT_ERROR:
        code="1";
        message = ("连接错误");
        break;
      /**
       * 未检测到蓝牙设备
       */
      case OpenDoorStatus.SCAN_EMPTY:
        code="1";
        message = ("未检测到蓝牙设备");
        break;
      /**
       * 没有该门禁钥匙
       */
      case OpenDoorStatus.KEY_NONE:
        code="1";
        message = ("没有该门禁钥匙");
        break;
      /**
       * 开门成功
       */
      case OpenDoorStatus.OPEN_SUCCESS:
        code="0";
        message = ("开门成功");
        break;
      /**
       * 开门失败
       */
      case OpenDoorStatus.OPEN_FAILURE:
        code="1";
        message = ("开门失败");
        break;
      /**
       * 蓝牙信号弱
       */
      case OpenDoorStatus.SCAN_SIGNALWEAK:
        code="1";
        message = ("蓝牙信号弱");
        break;
      /**
       * 密码错误
       */
      case OpenDoorStatus.OPEN_WRONG_PASSWORD:
        code="1";
        message = ("密码错误");
        break;
    }
    if (code != null) {
        Map<String,Object> map = new HashMap<>();
        map.put("code",code);
        map.put("message",message);
        flutterCallBack(map);
    }
  }

  //注册蓝牙广播
  private void registerBluetoothReceiver() {
    //注册监听
    IntentFilter intentFilter = new IntentFilter();
    intentFilter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);//要接收的广播
    registerReceiver(bluetoothReceiver, intentFilter);//注册接收者
  }
  //移除广播接收器
  private void removeBluetoothReceiver(){
    unregisterReceiver(bluetoothReceiver);
  }

  //蓝牙广播接收器
  private BroadcastReceiver bluetoothReceiver = new BroadcastReceiver() {
    @Override
    public void onReceive(Context context, Intent intent) {
      String action = intent.getAction();
      if (action.equals(BluetoothAdapter.ACTION_STATE_CHANGED)&& BluetoothAdapter.STATE_ON==intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, 0)) {
        //已经打开蓝牙
        if("openLopeDoor".equals(mCurMethodCall)||"openLopeDoorInit".equals(mCurMethodCall)){
          if (TextUtils.isEmpty(mLockKey) || TextUtils.isEmpty(mLockPid)) {
            String code = "1";
            String message = ("密码失效");
            if (code != null) {
              Map<String, Object> callBackMap = new HashMap<>();
              callBackMap.put("code", code);
              callBackMap.put("message", message);
              flutterCallBack(callBackMap);
            }
            return;
          }
          long checkTime = System.currentTimeMillis() - mStartTime;
          if (mStartTime != -1 && checkTime <= 10000) {//在10秒内
            if (mLocks != null && mLocks.size() >= 0) {

              for (Lock l : mLocks) {
                if (mLockPid.equals(l.getMac())) {
                  mCurLock = l;
                  break;
                }
              }
            }
            if (mCurLock != null && mLockPid.equals(mCurLock.getMac())) {//存在当前的mac则直接开门
              LopeAPI.get().openLock(mCurLock.getMac(), mLockKey, mCurLock.getFwVersion());
            } else {//否则则扫描
              if(mLocks==null)
                mLocks = new ArrayList<>();
              else
                mLocks.clear();
              mCurLock = new Lock();
              mStartTime = System.currentTimeMillis();
              LopeAPI.get().startScan(mScanDuration, true);
              mBoolean = false;
            }
          } else {//重新扫描
            if(mLocks==null)
              mLocks = new ArrayList<>();
            else
            mLocks.clear();
            mCurLock = new Lock();
            mStartTime = System.currentTimeMillis();
            LopeAPI.get().startScan(mScanDuration, true);
            mBoolean = false;
          }
        }else if(mResult!=null){
          openDoorUtils.openTheDoorByClick();
        }
        removeBluetoothReceiver();
      }
    }
  };


    //判断是否用权限
    public static boolean hasPermissions(Context context, String... perms) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true;
        }else {
            for (String perm : perms) {
                if (ContextCompat.checkSelfPermission(context, perm)
                        != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }
            }
        }
        return true;
    }
  //重新扫描
  void setNeedScan() {
    mStartTime = -1;
    mLockKey = null;
    if (mLocks != null)
      mLocks.clear();
    mCurLock = null;
  }

  //暂时不用重新扫描
  void setNoNeedScanInRightTime() {
    mLockKey = null;
    if (mLocks != null)
      mLocks.clear();
  }

  @Override
  public void onScanning() {
    Log.e(TAG,"扫描中");
  }

  @Override
  public void onScanFail(int i) {
    Log.e(TAG,"扫描失败");

    Map<String, Object> map = new HashMap<>();
    map.put("code", "1");
    map.put("message", "未发现蓝牙设备");
    flutterCallBack(map);
  }

  @Override
  public void onScanDetectedImmediately(Lock lock) {
// if startScan with immediately = true, you should call stopScan as soon as possible.
    Log.e(TAG,"正在扫描2");
if(mLockPid.equalsIgnoreCase(lock.getMac())){
  mCurLock=lock;
}

     if (!mBoolean) {
      mBoolean = true;
      Message msg = Message.obtain();
      msg.what = MSG_SCAN_STOP;
       msg.arg1 = 0x001;
      this.mMyHandler.sendMessageDelayed(msg, 100); //delay 100ms when detect first proper device;
    }
  }

  @Override
  public void onScanDetectedTogether(List<Lock> list) {
//        for (Lock l : list) {
//            if (l.getMac().equalsIgnoreCase(lock.getMac())) {
//                return;
//            }
//        }
    Log.e(TAG,"扫描完成");
    mLocks.addAll(list);
//        mLocks.add(lock);

    Message msg = Message.obtain();
    msg.what = MSG_SCAN_STOP;
    this.mMyHandler.sendMessageDelayed(msg, 100); //delay 100ms when detect first proper device;

//        if (!mBoolean) {
//            mBoolean = true;
//                    }
  }

  @Override
  public void onConnected() {
//        String code = "0";
    String message = ("已连接");
    Log.e(TAG,message);
//        if (code != null) {
//            Map<String, Object> map = new HashMap<>();
//            map.put("code", code);
//            map.put("message", message);
//            flutterCallBack(map);
//        }
  }

  @Override
  public void onDisconnected() {//断开则需要重新扫描
//    setNeedScan();
    String code = "1";
    Log.e(TAG,"已断开");
    String message = ("已断开");
//    if (code != null) {
//      Map<String, Object> map = new HashMap<>();
//      map.put("code", code);
//      map.put("message", message);
//      flutterCallBack(map);
//    }

  }

  @Override
  public void onTagAccessNotify(List<Access> list) {

  }


  @Override
  public void onOpenSuccess() {
    setNoNeedScanInRightTime();
    String code = "0";
    String message = ("开门成功");
    if (code != null) {
      Map<String, Object> map = new HashMap<>();
      map.put("code", code);
      map.put("message", message);
      flutterCallBack(map);
    }
    Log.e(TAG,message);
  }

  @Override
  public void onOpenFailed(int i) {
    String message = ("开门失败");

    //1 失败
    //2 密钥错误
    //3 无授权
    //4 获取门禁信息失败
    //5 超时
    //6 蓝牙未开启
    switch (i) {
      case 1:

        break;
      case 2:
        message = ("开门失败,密钥错误");
        break;
      case 3:
        message = ("开门失败,无授权");
        break;
      case 4:
        message = ("开门失败,获取门禁信息失败");
        break;
      case 5:
        message = ("开门失败,超时");
        break;
      case 6:
        message = ("开门失败,蓝牙未开启");
        break;
    }
    String code = "1";
    Log.e(TAG,message);
    if (code != null) {
      Map<String, Object> map = new HashMap<>();
      map.put("code", code);
      map.put("message", message);
      flutterCallBack(map);
    }

  }

  @Override
  public void onInitSuccess() {
    String code = "0";
    Log.e(TAG,"初始化成功");
    String message = ("初始化成功");
//    if (code != null) {
//      Map<String, Object> map = new HashMap<>();
//      map.put("code", code);
//      map.put("message", message);
//      flutterCallBack(map);
//    }

    Message msg = Message.obtain();
    msg.what = MSG_INIT_SUC;
    this.mMyHandler.sendMessage(msg); //delay 100ms when detect first proper device;

  }

  @Override
  public void onInitFail() {
    String code = "1";
Log.e(TAG,"连接失败");
    String message = ("连接失败");
    if (code != null) {
      Map<String, Object> map = new HashMap<>();
      map.put("code", code);
      map.put("message", message);
      flutterCallBack(map);
    }
  }

  @Override
  public void onSetLockSetSuccess() {

  }

  @Override
  public void onSetLockSetFail() {

  }
  private void initMyHandler() {
    mMyHandler = new Handler(getMainLooper()) {
      @Override
      public void handleMessage(Message msg) {


        switch (msg.what) {
          case MSG_SCAN_STOP:
            if(mCurLock!=null&&msg.arg1 == 0x001){
                LopeAPI.get().openLock(mCurLock.getMac(), mLockKey, mCurLock.getFwVersion());
              }
            LopeAPI.get().stopScan();

//                        Toast.makeText(MainActivity.this,
//                                String.format(Locale.ENGLISH, "detected %d device in %d ms", mLocks.size(), System.currentTimeMillis() - mStartTime),
//                                Toast.LENGTH_SHORT).show();

//                        if (!mLocks.isEmpty()&&) {
//                            mCurLock = mLocks.get(0);
//                        }
            break;
          case MSG_INIT_SUC:
            //初次进来
            if(TextUtils.isEmpty(mLockPid)&&(mLocks==null||mLocks.size()==0)&&(mCurLock==null||TextUtils.isEmpty(mCurLock.getMac()))&&mStartTime==-1) {
              if(mLocks==null)
                mLocks = new ArrayList<>();
              else
                mLocks.clear();
              mCurLock = new Lock();
              mStartTime = System.currentTimeMillis();
              LopeAPI.get().startScan(mScanDuration, false);
              mBoolean = false;
            }
            break;
          default: {
          }
        }
      }
    };
  }
}
