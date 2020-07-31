//通用分享页面
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/scoped_models/share_state_model.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/widgets.dart';

import 'common_text.dart';

class CommonShareBottomSheet extends StatelessWidget {
//  @override

  CommonShareModel shareModel; //分享的内容
  final bool close; //分享后是否关闭自己
  final Function callback; //如果不关闭自己就回调回去处理
  CommonShareBottomSheet(this.shareModel, {this.close = true, this.callback});

//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _ShareBottomSheet();
//  }
//}
//class _ShareBottomSheet extends State<CommonShareBottomSheet>{

  Widget _buildItem(CommonShareItemModel model) {
    return GestureDetector(
      child: Container(
        color: UIData.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              model.image,
              width: UIData.spaceSize30,
              height: UIData.spaceSize30,
            ),
            Padding(
              padding: EdgeInsets.only(top: UIData.spaceSize12),
              child: CommonText.darkGrey14Text(model.name),
            )
          ],
        ),
      ),
      onTap: () {
        if (close) {
          Navigate.closePage();
        } else {
          if (callback != null) callback();
        }
        ShareUtil.share(shareModel, model.platform);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: UIData.primaryColor,
        child: GridView.builder(
            physics: new NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: UIData.spaceSize1,
              crossAxisSpacing: UIData.spaceSize1,
              childAspectRatio: 1.5,
            ),
            itemCount: ShareUtil?.itemModels?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(ShareUtil.itemModels[index]);
            }));
  }
}
