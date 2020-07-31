import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/near_info_list.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:url_launcher/url_launcher.dart';

///有偿服务历史
class NearInfoListPage extends StatefulWidget {
  NearInfoListPage();

  @override
  _NearInfoListPageState createState() => new _NearInfoListPageState();
}

class _NearInfoListPageState extends State<NearInfoListPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CommonScaffold(appTitle: '周边信息', bodyData: _buildContent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateModel.nearInfoHistoryHandleRefresh();

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (stateModel.nearInfoListLoadState != ListState.HINT_LOADING) {
          stateModel.nearInfoHandleLoadMore();
        }
      }
    });

//    if (stateModel.customerId == null) {
//      CommonToast.show(msg: '请先注册',type: ToastIconType.INFO);
//    }
    if (stateModel.defaultProjectId == null) {
      CommonToast.show(msg: '请先选择社区',type: ToastIconType.INFO);
    }
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: model.nearInfoListLoadState,
            content: _buildList(),
            callback: () => _refresh());
      },
    );
  }

  Future _refresh() async{
    MainStateModel.of(context).nearInfoHistoryHandleRefresh(preRefresh: true);
  }

  Widget _buildList() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _loadMoreScrollController,
          itemCount: model.nearInfos.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (model.nearInfos?.length == index) {
              return CommonLoadMore(model.historyMaxCount);
            }

            NearInfo info = model.nearInfos[index];

            return CommonShadowContainer(
              margin: EdgeInsets.only(
                  top: UIData.spaceSize12,left: UIData.spaceSize16,right: UIData.spaceSize16),
              padding: EdgeInsets.only(top
                  :UIData.spaceSize12,bottom:UIData.spaceSize12,left: UIData.spaceSize16,right: UIData.spaceSize16),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CommonText.black16Text(info.name??''),
                        SizedBox(
                          height: UIData.spaceSize8,
                        ),
                        CommonText.lightGrey14Text('联系人：${info.linkPerson??''}'),
                        SizedBox(
                          height: UIData.spaceSize8,
                        ),
                        CommonText.lightGrey14Text('电话：${info.tel??''}'),
                        SizedBox(
                          height: UIData.spaceSize8,
                        ),
                        CommonText.lightGrey14Text('地址：${info.address??''}'),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(UIData.imagePhone),
                    onPressed: () {
                      if (StringsHelper.isNotEmpty(info?.tel??'')) {
                        _launchPHONE(phone: info?.tel);
                      }
                    },
                  ),
                ]),
              ),
            );
          },
        ),
      );
    });
  }


  _launchPHONE({String phone = ''}) async {
    String url = 'tel://' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
