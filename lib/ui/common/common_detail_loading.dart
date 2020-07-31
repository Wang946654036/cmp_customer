import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class CommonDetailLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(UIData.imageLoadingDetail), fit: BoxFit.fill)
      ),
    );
  }
}
