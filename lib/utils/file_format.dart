
class FileFormat{
    //上传的文件格式
  static final List<String> fileFormats=[
    ".doc",".docx",".xls",".xlsx",".ppt",".pptx",".wps",".pdf",".txt",".log",".accdb",".mpp",".pub",".mdb",  //文档格式
    ".jpg",".jpeg",".png",".gif",".eps",".tga",".tiff",".bmp",".svg",".ico",   //图片格式
    ".mp3",".amr",".aac",".m4a",//音频格式
    ".mp4",".m4v",".mov",".wav",".mpg",".mpeg",//视频格式
    ".rar",".zip",".tar",//压缩格式
  ];

  //是否包含
   static bool contains(String format){
     if(format==null||format.isEmpty){
       return false;
     }else{
       return fileFormats.contains(format);
     }
   }
}