import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/common/common_file_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/file_picker_state_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_big.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/image_picker/image_picker.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'image_picker/image_picker_loading.dart';

//文件选择布局
class CommonFilePicker extends StatefulWidget {
  List<Attachment> attachmentList; //文件列表
  ValueChanged<List<Attachment>> callbackWithInfo; //选择文件回调
  String title; //标题
  FilePickerStateModel fileModel; //图片的数据控制器(非不要，若想使用里面的方法，可以传入自定义对象)
  CommonFilePicker(
      {this.attachmentList,
      this.callbackWithInfo,
      this.title = '附件',
      this.fileModel});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FilePicker();
  }
}

class _FilePicker extends State<CommonFilePicker> {
  FilePickerStateModel _stateModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = widget.fileModel ?? new FilePickerStateModel();
    _stateModel.initData(widget.attachmentList, widget.callbackWithInfo);
  }

  //添加标题
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16),
            child: CommonText.darkGrey15Text(widget.title)),
        IconButton(
            icon: Icon(Icons.add, color: UIData.themeBgColor),
            onPressed: () {
              _stateModel.getLocalFile();
            }),
      ],
    );
  }

  //文件布局
  Widget _buildItem(CommonFileModel model) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize12),
          child:UIData.iconAttachment,
        ),
        Expanded(
          child:GestureDetector(
            child: CommonText.lightGrey12Text(model.fileName ?? ""),
            onTap: () {
              if(model.filePath!=null){
                stateModel.openFile(model.filePath);
              }else if(model.uuid!=null){
                stateModel.launchURL(HttpOptions.showPhotoUrl(model.uuid));
              }
            },
          ),
        ),
        Visibility(
            visible: model.fileState=='5',
            child: Container(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.error_outline,
                    size: 20,
                    color: UIData.themeBgColor,
                  ),
                  onPressed: () {
                    _stateModel.uploadLocalFile(model);
                  },
                ))),
        Visibility(
          visible: model.fileState=='4',
          child: IconButton(
            icon: ImagePickerLoading(),
            onPressed: (){},
          ),
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          color: UIData.lightGreyColor,
          iconSize: ScreenUtil.getInstance().setWidth(20),
          onPressed: () {
            _stateModel.removeFile(model);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _stateModel,
        child: ScopedModelDescendant<FilePickerStateModel>(
            builder: (context, child, model) {
          return Container(
              color: UIData.primaryColor,
              child: Column(
                children: <Widget>[
                  _buildTitle(),
                  ListView.separated(
                      physics: new NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.files?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildItem(model.files[index]);
                      },
                  separatorBuilder:(BuildContext context, int index){
                       return CommonDivider();
                  },),
                ],
              ));
        }));
  }
}
