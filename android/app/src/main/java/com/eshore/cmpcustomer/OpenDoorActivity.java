package com.eshore.cmpcustomer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import cellcom.com.cn.deling.bean.KeyInfo;
import cellcom.com.cn.deling.homepage.core.OpenDoorStatus;
import cellcom.com.cn.deling.homepage.core.OpenDoorUtil;
import cellcom.com.cn.deling.utils.FullCountDownTimer;

import android.Manifest;
import android.animation.ObjectAnimator;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Vibrator;
import android.provider.Settings;
import android.view.View;
import android.view.animation.LinearInterpolator;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.cmhk.uhome.R;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.List;

//弃用，直接调开门方法，不打开摇一摇开门页面
public class OpenDoorActivity extends AppCompatActivity implements OpenDoorUtil.IOpenDoorCallBack {

    public static final String TAG = OpenDoorActivity.class.getSimpleName();

    private String[] mPermissionLists = {
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION};

    //返回按钮
    private ImageButton mBackBtn;
    //开门按钮图标
    private ImageView mOpenDoorBtn;
    //提示语
    private TextView mTextView;
    //开门工具类
    private OpenDoorUtil openDoorUtils;
    //倒计时
    private FullCountDownTimer countDownTimer;
    //提示打开蓝牙
    private AlertDialog mTipForEnableBTDialog = null;

    //震动器(用于开门成功之后手机震动)
    private Vibrator mVibrator;
    //物理感应管理器
    private SensorManager mSensorManager;
    //检测摇动的时间间隔阀值
    private static final int UPDATE_INTERVAL = 100;
    //上一次检测摇动的时间
    private long mLastUpdateTime;
    //上一次检测摇动时，加速度在x、y、z方向上的分量，用于和当前加速度比较求差。
    private float mLastX, mLastY, mLastZ;
    //摇晃阈值，决定了对摇晃的敏感程度，越小越敏感。
    private int SHAKETHRESHOLD = 2100;// 3100

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_open_door);
        //配置状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(
//                    View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|
                    View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            getWindow().setStatusBarColor(ContextCompat.getColor(
                    OpenDoorActivity.this,R.color.colorWhite));
        }else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            getWindow().setStatusBarColor(ContextCompat.getColor(
                    OpenDoorActivity.this,R.color.colorBar));
        }

        //开启蓝牙
        switchBT(true);

        //初始化视图
        initView();
        //初始化开门工具类
        initOpenDoorUtils();
        //初始化开门成功的震动器
        initShake();
        //初始化数据
        initData();
        //设置监听
        initLisenter();

        //请求位置权限
        mOpenDoorBtn.post(new Runnable() {
            @Override
            public void run() {
                //检查定位和写入权限
                // API level 大于等于 23(Android 6.0) 时需要打开定位权限
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (hasPermissions(OpenDoorActivity.this, mPermissionLists)) {

                    }else {
                        //如果没有权限则先请求权限，等用户拒绝或允许完请求权限后，再进行跳转
                        requestPermissions(mPermissionLists,1);
                        return;
                    }
                }
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mSensorManager != null) {// 注册监听器
            // 第一个参数是Listener，第二个参数是所得传感器类型，第三个参数值获取传感器信息的频率
            //获取的传感器类型为加速度传感器。
            mSensorManager.registerListener(sensorEventListener,
                    mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_GAME);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        //关闭蓝牙未开启提示
        dismissBTTip();
        // 取消震动器监听器
        if (mSensorManager != null) {
            mSensorManager.unregisterListener(sensorEventListener);
        }
        //释放开门工具类
        openDoorUtils.onDestroy();
    }

    public void initOpenDoorUtils(){
        openDoorUtils = OpenDoorUtil.openDoorInit(this);
        int result = openDoorUtils.bleInit(this);
        switch (result) {
            case 0://初始化成功
                break;
            case -4:
                mTextView.setText("您的手机不支持ble,无法使用手机开门！");
                openDoorUtils.mEnableOpen = false;
                break;
        }
    }

    public void initShake(){
        // 震动器
        mVibrator = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
        // 感应器
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
    }

    public void initView(){
        mTextView = findViewById(R.id.tv_tip);
        mOpenDoorBtn = findViewById(R.id.openDoorBtn);
        mBackBtn= findViewById(R.id.iv_back);
    }

    public void initData(){
        String pid=getIntent().getStringExtra("pid");
        String lockid=getIntent().getStringExtra("lockid");
        //设置开门的钥匙列表
        List<KeyInfo> keyInfos = new ArrayList<>();
        KeyInfo keyInfo = new KeyInfo();
//        keyInfo.setLock_id("1758368186");
//        keyInfo.setLock_id("2037148781");
        keyInfo.setLock_id(lockid);
        keyInfo.setPid(pid);
        keyInfos.add(keyInfo);

//        KeyInfo keyInfo2 = new KeyInfo();
//        keyInfo2.setLock_id("1758368186");
//        keyInfo2.setPid("39C80C7B");
//        keyInfos.add(keyInfo2);

        if (keyInfos != null) {
            openDoorUtils.setMyKeys(keyInfos);
        }

        //设置倒计时
        countDownTimer = new FullCountDownTimer(5000, 1000) {
            public void onTick(long millisUntilFinished) {
                int num = (int) (millisUntilFinished / 1000);
                if (mTextView == null)
                    return;
                if (num != 5) {
                    mTextView.setText("正在开门中，请耐心等待" + num + "秒");
                }
            }

            public void onFinish() {
                //设置可开门
                openDoorUtils.mEnableOpen = true;
                mTextView.setText("摇一摇或点我就可以开门咯！");
            }
        };
    }

    //初始化监听
    public void initLisenter(){
        mOpenDoorBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openDoorUtils.openTheDoorByClick();
            }
        });
        mBackBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();;
            }
        });
    }

    //切换蓝牙
    private void switchBT(boolean open) {
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (bluetoothAdapter != null) {
            if (open) {
                if (!bluetoothAdapter.isEnabled())
                    //这个方法打开蓝牙不会弹出提示
                    //需要友好的提示用户打开
                    bluetoothAdapter.enable();
            } else {
                if (bluetoothAdapter.isEnabled())
                    //关闭蓝牙
                    bluetoothAdapter.disable();
            }
        }
    }

    //摇一摇动画
    public void doSharkAnimation() {
        if (mOpenDoorBtn == null)
            return;
        ObjectAnimator bounce = ObjectAnimator.ofFloat(mOpenDoorBtn, "rotation", -30, -10, 10, 30, -5, 5, -3, 3, -2, 2, 0);
        bounce.setInterpolator(new LinearInterpolator());
        bounce.setDuration(1000);
        bounce.start();
    }

    //显示蓝牙未开启提示框
    private void tipForEnableBT() {
        // 检查蓝牙的连接状态
        if (mTipForEnableBTDialog == null) {
            mTipForEnableBTDialog = new AlertDialog.Builder(this).setTitle("温馨提示").setMessage("亲,打开蓝牙才能摇一摇哦！")
                    .setPositiveButton("打开蓝牙", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();
                            OpenDoorActivity.this.startActivity(new Intent(Settings.ACTION_BLUETOOTH_SETTINGS));
                            mTipForEnableBTDialog = null;
                        }
                    }).setNegativeButton("稍后打开", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();
                            mTipForEnableBTDialog = null;
                        }
                    }).create();
            mTipForEnableBTDialog.setCancelable(false);
        }
        mTipForEnableBTDialog.show();
    }

    //关闭蓝牙提示
    public void dismissBTTip() {
        if (mTipForEnableBTDialog != null && mTipForEnableBTDialog.isShowing())
            mTipForEnableBTDialog.dismiss();
    }

    @Override
    public void onOpening(int code) {
        switch (code) {
            /**
             * 蓝牙未开启
             */
            case OpenDoorStatus.BLUETOOTH_DISABLE:
                toast("蓝牙未开启");
                tipForEnableBT();
                break;
            /**
             * 没有钥匙
             */
            case OpenDoorStatus.KEY_EMPTY:
                toast("钥匙列表为空 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;
            /**
             * 开始扫描设备
             */
            case OpenDoorStatus.SCAN_START:
                //设置不可开门
                openDoorUtils.mEnableOpen = false;
                //启动抖动动画
                doSharkAnimation();
                //启动倒计时
                if (countDownTimer != null)
                    countDownTimer.start();
                break;
            /**
             * 连接超时
             */
            case OpenDoorStatus.CONNECT_OVERTIME:
                toast("连接超时 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;
            /**
             * 其它连接错误
             */
            case OpenDoorStatus.CONNECT_ERROR:

                break;
            /**
             * 未检测到蓝牙信号，请重新开门
             */
            case OpenDoorStatus.SCAN_EMPTY:
                toast("未检测到蓝牙信号，请重新开门 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;
            /**
             * 没有该门禁钥匙
             */
            case OpenDoorStatus.KEY_NONE:
                toast("没有该门禁钥匙 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;
            /**
             * 开门成功
             */
            case OpenDoorStatus.OPEN_SUCCESS:
                toast("开门成功 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                mVibrator.vibrate(new long[]{500, 200, 500, 200}, -1);// 手机震动
                break;
            /**
             * 开门失败
             */
            case OpenDoorStatus.OPEN_FAILURE:
                toast("开门失败 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;
            /**
             * 蓝牙信号弱
             */
            case OpenDoorStatus.SCAN_SIGNALWEAK:
                toast("蓝牙信号弱 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;
            /**
             * 密码错误
             */
            case OpenDoorStatus.OPEN_WRONG_PASSWORD:
                toast("密码错误 Pid = " + openDoorUtils.openPid + " 信号值 = " + openDoorUtils.mRssi);
                break;

        }
    }

    //物理感应器摇动回调监听器
    private SensorEventListener sensorEventListener = new SensorEventListener() {
        //当传感器监测到的数值发生变化时就会调用
        @Override
        public void onSensorChanged(SensorEvent event) {
            long currentTime = System.currentTimeMillis();
            // 检测两次摇动的间隔是否小于阀值
            long diffTime = currentTime - mLastUpdateTime;
            if (diffTime < UPDATE_INTERVAL) {
                return;
            }
            mLastUpdateTime = currentTime;
            float x = event.values[0];// x轴方向的重力加速度，向右为正
            float y = event.values[1];// y轴方向的重力加速度，向前为正
            float z = event.values[2];// z轴方向的重力加速度，向上为正
            float deltaX = x - mLastX;
            float deltaY = y - mLastY;
            float deltaZ = z - mLastZ;
            mLastX = x;
            mLastY = y;
            mLastZ = z;
            /**
             * 亮灯状态下,此函数调用频繁做平方根运算很耗资源.稍微处理下
             */
            if (Math.abs(deltaX) < 16 && Math.abs(deltaY) < 16)
                return;
            float delta = (float) (Math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ) / diffTime * 10000);
            if (delta > SHAKETHRESHOLD)
                //满足摇晃阀值就开锁
                openDoorUtils.openTheDoorByShake();
        }

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {

        }
    };

    //toast
    public void toast(String message){
        ToastUtils.showBottomToast(this,message);
    }

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
}
