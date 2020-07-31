import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///
/// 引导页
///
class IntroPage extends StatelessWidget {
  final int _bannerTotalCount = 4;

  Widget _buildImage(String imagePath) {
    return Image.asset(imagePath, fit: BoxFit.cover);
  }

  ///
  /// 轮播图
  ///
  Widget _buildSwiper() {
    return Container(
      alignment: Alignment.topCenter,
//      width: ScreenUtil.screenWidth,
//      height: _maxImageHeight,
      child: Swiper(
          autoplay: false,
          loop: false,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return _buildImage(UIData.imageIntro1);
                break;
              case 1:
                return _buildImage(UIData.imageIntro2);
                break;
              case 2:
                return _buildImage(UIData.imageIntro3);
                break;
              case 3:
//                return _buildImage(UIData.imageIntro4);
                return
//                  FittedBox(
//                  fit: BoxFit.cover,
//                  child:
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      _buildImage(UIData.imageIntro4),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(38)),
                          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize4),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: BorderSide(color: UIData.lighterRedColor)),
                              color: UIData.primaryColor),
                          child:
//                          Text('立即体验', style: TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize30))
                          CommonText.text18('立即体验', color: UIData.themeBgColor),
                        ),
                        onTap: () => Navigator.of(context).pushReplacementNamed(Constant.pageFirstPolicy),
                      )
                    ],
//                  ),
                );
                break;
              default:
                return Container();
            }
          },
          itemCount: _bannerTotalCount,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: UIData.dividerColor, activeColor: UIData.themeBgColor, size: 7, activeSize: 8))),
    );
  }

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    //初始化分享控件
    ShareUtil.init();
    return CommonScaffold(
      showAppBar: false,
      bodyData: _buildSwiper(),
    );
  }
}
