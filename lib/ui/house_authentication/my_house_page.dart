import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/house_authentication/house_auth_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_list.dart';
import 'package:cmp_customer/ui/house_authentication/tourist_no_record.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//房屋类型
enum HouseType {
  Certified, //已认证
  Certificating, //认证中
}

///
/// 我的房屋
///
class MyHousePage extends StatefulWidget {
  @override
  _MyHousePageState createState() => _MyHousePageState();
}

class _MyHousePageState extends State<MyHousePage> {
  ListPageModel listPageModel = ListPageModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh({bool preRefresh = false}) async {
    await stateModel.getAllHouseData(listPageModel, preRefresh: preRefresh);
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.builder(
            padding: EdgeInsets.only(top: UIData.spaceSize16),
            itemCount: listPageModel?.list?.length ?? 0,
            itemBuilder: (context, index) {
              var info = listPageModel.list[index];
              return HouseList(info,
                  onTap: () {
//            if (info.houseType == HouseType.Certified) {
                    navigatorKey.currentState.push<bool>(MaterialPageRoute(builder: (context) {
                      int custHouseRelationId;
                      int houseCustAuditId;
                      if (info?.auditStatus == houseAuditSuccess)
                        custHouseRelationId = info?.custHouseRelationId;
                      else
                        houseCustAuditId = info?.houseCustAuditId;
                      return HouseDetailPage(
                          custHouseRelationId: custHouseRelationId,
                          houseCustAuditId: houseCustAuditId,
                          callback: () => _handleRefresh(preRefresh: true));
                    })).then((bool value) {
                      if (value != null && value) {
                        _handleRefresh(preRefresh: true);
                      }
                    });
//            }
                  },
                  callback: () => _handleRefresh(preRefresh: true));
            }),
        onRefresh: _handleRefresh);
  }

  Widget _buildContent() {
    switch (listPageModel.listPage.tag) {
      case '251': //251:游客没有房屋认证记录;
        return TouristNoRecord(() {
          _handleRefresh(preRefresh: true);
        });
        break;
      case '252': //252:游客有房屋认证记录;
        return _buildList();
//      navigatorKey.currentState.push(MaterialPageRoute(builder: (context){
//        return HouseDetailPage(listPageModel.list[0]);
//      }));
        break;
      case '253': //253:客户
        return _buildList();
        break;
      case '254': //253:客户没有已认证房屋记录
        return _buildList();
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '我的房屋',
      appBarActions: stateModel.customerType == 2 //已经经过认证的客户可以添加房屋
          ? [
              IconButton(
                  icon: Icon(Icons.add, color: UIData.darkGreyColor),
                  onPressed: () {
                    navigatorKey.currentState.push<bool>(MaterialPageRoute(builder: (context) {
                      return HouseAuthPage(
                        houseAuthType: HouseAuthType.AddAuth,
                      );
                    })).then((bool value) {
                      if (value != null && value) {
                        _handleRefresh(preRefresh: true);
                      }
                    });
                  })
            ]
          : null,
      bodyData: ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
        return CommonLoadContainer(
          state: listPageModel.listPage.listState,
          content: _buildContent() ?? Container(),
          callback: () {
            _handleRefresh(preRefresh: true);
          },
        );
      }),
    );
  }
}
