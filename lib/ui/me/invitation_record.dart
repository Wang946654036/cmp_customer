import 'package:cmp_customer/models/response/invitation_record_response.dart';
import 'package:cmp_customer/scoped_models/invitation_record_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//邀请好友记录
class InvitationRecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InvitationRecordState();
  }
}

class _InvitationRecordState extends State<InvitationRecordPage> {
  InvitationRecordStateModel _invitationRecordStateModel;

  Widget _buildLabel() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.symmetric(vertical: UIData.spaceSize8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Center(
              child: CommonText.darkGrey16Text('昵称'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: CommonText.darkGrey16Text('手机'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: CommonText.darkGrey16Text('日期'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: CommonText.darkGrey16Text('奖励状态'),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildItem(InvitationRecord record) {
    return Container(
        color: UIData.primaryColor,
        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize8),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: CommonText.darkGrey14Text(record?.toNickname ?? "",textAlign: TextAlign.center,overflow: TextOverflow.visible),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: CommonText.darkGrey14Text(record?.phone ?? "",textAlign: TextAlign.center,overflow: TextOverflow.visible),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: CommonText.darkGrey14Text(record?.updateDate ?? "",textAlign: TextAlign.center,overflow: TextOverflow.visible),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: CommonText.darkGrey14Text(record?.statusName ?? "",textAlign: TextAlign.center,overflow: TextOverflow.visible),
              ),
            ),
          ],
        ));
  }

  Widget _buildContent() {
    return ScopedModelDescendant<InvitationRecordStateModel>(
        builder: (context, child, model) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
                vertical: UIData.spaceSize8, horizontal: UIData.spaceSize16),
            alignment: Alignment.centerLeft,
            child: CommonText.darkGrey16Text(
                "你已成功邀请 ${model.list?.length ?? '-'} 位好友"),
          ),
          _buildLabel(),
          CommonDivider(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: model.list?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                InvitationRecord record = model.list[index];
                return _buildItem(record);
              },
              separatorBuilder: (BuildContext context, int index) {
                return CommonDivider();
              },
            ),
          )
        ],
      );
    });
  }

  Widget _buildBody() {
    return ScopedModel(
        model: _invitationRecordStateModel,
        child: ScopedModelDescendant<InvitationRecordStateModel>(
            builder: (context, child, model) {
          return CommonLoadContainer(
              state: model.listState,
              callback: () {
                model.loadList();
              },
              content: _buildContent());
        }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      appTitle: '邀请记录',
      bodyData: _buildBody(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _invitationRecordStateModel = new InvitationRecordStateModel();
    _invitationRecordStateModel.loadList();
  }
}
