import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/property_notice_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 附件列表
///
class AttachmentContainer extends StatelessWidget {
  final List<Attachment> attachList;

  AttachmentContainer(this.attachList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: attachList?.length ?? 0,
      itemBuilder: (context, index) {
        Attachment attachment = attachList[index];
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: UIData.spaceSize8),
            child: Row(
              children: <Widget>[
                UIData.iconAttachment,
                SizedBox(width: UIData.spaceSize4),
                CommonText.red15Text(attachment?.attachmentName ?? ''),
              ],
            ),
          ),
          onTap: () {
            stateModel.launchURL(HttpOptions.showPhotoUrl(attachment?.attachmentUuid ?? ''));
          },
        );
      },
    );
  }
}