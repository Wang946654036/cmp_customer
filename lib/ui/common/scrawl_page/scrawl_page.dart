import 'dart:io';

import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:signature/signature.dart';

import '../common_divider.dart';
import '../common_scaffold.dart';
import '../common_text.dart';
import '../common_toast.dart';
import 'file_utils.dart';

class ScrawlPage extends StatefulWidget {

  ScrawlPage();

  @override
  State<StatefulWidget> createState() => _ScrawlState();
}

class _ScrawlState extends State<ScrawlPage> {
  static final List<Color> colors = [
//    Colors.redAccent,
//    Colors.lightBlueAccent,
//    Colors.greenAccent,
    UIData.darkGreyColor
  ];

//  static final List<double> lineWidths = [5.0, 8.0, 10.0];
  static final List<double> lineWidths = [5.0];
  File imageFile;
  int selectedLine = 0;
  int curFrame = 0;
  bool isClear = false;
bool isChilk = false;
  final GlobalKey _repaintKey = new GlobalKey();

  double get strokeWidth => lineWidths[selectedLine];

  var _signatureCanvas = Signature(
//    height: 300,
    backgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
//    stateModel.workOtherTaskCommitState =
//        ListState.HINT_DISMISS;
    getScreenShotFile().then((file) {
      setState(() {
        imageFile = file;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '签名',
      bodyData: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: UIData.primaryColor,
                padding: EdgeInsets.symmetric(vertical: UIData.spaceSize8, horizontal: UIData.spaceSize16),
                child: CommonText.red14Text('请签名确认您已经仔细阅读并清楚了解了相关的协议'),
              ),
              CommonFullScaleDivider(),
              _signatureCanvas,
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
              onPressed: () => setState(() {
                return _signatureCanvas.clear();
              }),
              child: Text('重签')),
          FlatButton(
              onPressed: () async {
                if(!isChilk){
                isChilk = true;
                if (_signatureCanvas.isNotEmpty) {
                  var data = await _signatureCanvas.exportBytes();
                  saveScreenShotUint8List2DataDir(data, success: (String tempPath) {
                    isChilk = false;
                    CommonToast.show(type: ToastIconType.SUCCESS, msg: '签名成功');
                    Navigate.closePage(tempPath);
                  }, fail: () {
                    isChilk = false;
                    CommonToast.show(type: ToastIconType.FAILED, msg: '签名失败');
                  });
                }else{
                  isChilk = false;
                  CommonToast.show(type: ToastIconType.FAILED, msg: '请先签名');
                }
              }},
              child: Text('确认'))
        ],
      ),
    );
  }
}
