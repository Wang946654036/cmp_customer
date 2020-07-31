import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class BottomInputView extends StatefulWidget  {
  Function sendCallBack;

  String title;

  TextEditingController controller;

  String hint;

  Widget outputView;

  BottomInputView(this.title,this.sendCallBack,this.controller,{Key key,this.hint,this.outputView}): super(key: key);



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomInputViewState();
  }

}
class BottomInputViewState extends State<BottomInputView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(widget.controller==null){
      widget.controller = new TextEditingController();
    }
    return Scaffold(
      backgroundColor: UIData.opacity5BlackColor,
      body: GestureDetector(onTap: (){
        Navigator.pop(context);
      },child: new Container(
        color: UIData.opacity50BlackColor,
      ),),
      bottomSheet: Container(
//            margin: EdgeInsets.only(bottom: 500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(
                left: UIData.spaceSize16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CommonText.darkGrey16Text(widget.title),
                  FlatButton(onPressed: () {
                    if(widget.sendCallBack!=null){
                      widget.sendCallBack();
                    }

                  }, child: Container(
                      margin: EdgeInsets.only(left: UIData.spaceSize8),
                      padding: EdgeInsets.symmetric(
                          vertical: UIData.spaceSize2,
                          horizontal: UIData.spaceSize4),
                      child: CommonText.blue15Text('确认')),),
                ],
              ),
            ),

            widget.outputView??Container(),

            Container(
              color: UIData.primaryColor,
              child: inputWidget(
                controller: widget.controller,
                hint_text: widget.hint??hint_text_required,
                maxLength: 200,
                bottomSpace: UIData.spaceSize16,
                editBotPadding: UIData.spaceSize30,
              ),),
          ],
        ),
      ),
    );


  }
}

