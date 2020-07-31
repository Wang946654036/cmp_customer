import 'dart:async';
import 'dart:io';

import 'package:cmp_customer/models/process_node.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

//拓展列表(暂时无法封装成统一，请用ExpansionTile自定义)
class CommonExpansionTile extends StatelessWidget {
  Widget title;
  List<Widget> children;
  CommonExpansionTile(this.title,this.children);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExpansionTile(
      title: title,
      children: children,
    );
  }
}


