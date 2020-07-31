import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/utils/log_util.dart';

import 'common_strings_helper.dart';

class FailedCodeTrans {
  static var failedCodes = {
//    '99': '系统异常，请联系管理员！',
//    '-1': '暂无权限，请联系管理员开通权限！',
//    '-2': '认证校验失败',
//    '-3': '用户名不能为空',
//    '-4': '密码不能为空',
//    '-5': '密码错误',
//    '-6': '用户名不存在或不可用',
//    '-8': '登录错误次数已达上限，请明天再试',
    'Authorize.illegal.username': '用户名不能为空，且长度大于3!',
    'Authorize.illegal.password': '密码不能为空并且必需不少于六个字符!',
    'Authorize.not.exist.user': '用户名不存在!',
    'Authorize.invalid.user': '用户已经被注销!',
    'Authorize.error.password': '密码错误！',
    'Authorize.not.exist.company': '该公司没有注册！',
    'Authorize.invalid.company': '公司已被注销!',
    'socket time out': '连接超时，请重试！',
    'can\'t resolve host': '网络不可用，请检查网络！',
    'null': '连接无信息返回，请重试！',
    '设备未登录.': '设备未登录或会话已过期，请重新登录！',
    'user.device.nologin': '设备未登录或会话已过期，请重新登录！',
    'html': '连接失败，请联系管理员！',
    'Failed to connect to': '服务器连接失败，请联系管理员！',
    'failed to connect to': '服务器连接失败，请联系管理员！',
    'Unable to resolve host': '无法连接到服务器，请联系管理员！',
    'DioError [DioErrorType.CONNECT_TIMEOUT]: Connecting timeout[${HttpOptions.connectTimeout}ms]':
        '连接超时，请重试！',
    'Connecting timeout[${HttpOptions.connectTimeout}ms]':
    '连接超时，请重试！',
    'Connection timed out': '连接超时，请重试！',
    'Receiving data timeout': '连接超时，请重试！',
    'Network is unreachable': '亲，您的手机网络不大顺畅哦，请检查网络设置',
    'Connection failed': '亲，您的手机网络不大顺畅哦，请检查网络设置',
    'Connection refused': '连接失败，请联系管理员！',
    'Failed host lookup': '连接失败，请检查网络并打开允许使用数据',
    'Forbidden': '暂无权限，请联系管理员开通权限！',
    'SocketException: OS Error: No route to host': '连接失败，请联系管理员！',
    'Software caused connection abort': '连接失败，请重试！',
    'Unable to find instance for': '连接失败，请重试!!',
    '拒绝连接': '连接失败，请重试!!！',
//    '1': '请登陆！',
//    '2': '参数错误！',
//    '3': '数据不存在或者您暂无操作该数据的权限！',
//    '4': '数据已存在！',
//    '11': '账号或密码错误！',
//    '20': '订舱成功状态才可一键抛货！',
//    '21': '不可多次一键抛货！',
//    '50': '航线不存在！',
//    '51': '航线组不存在！',
//    '80': '手机号已存在',
//    '81': '邮箱已存在！',
//    '82': '企业全称已存在！',
//    '83': '企业简称已存在！',
//    '84': '非三大运营商手机号！',
//    '85': '验证码错误！',
//    '100': 'po已存在！',
//    '101': 'cfs系统数据获取错误！',
  };

  static String enTochsTrans({String failCode, String failMsg}) {
    if (StringsHelper.isNotEmpty(failCode) && failedCodes[failCode] != null) {
//      if (failedCodes[failCode] != null) {
//        print('failCode 2 failCode:' + failedCodes[failCode]);
        return failedCodes[failCode];
//      }
    } else if (StringsHelper.isNotEmpty(failMsg)) {
//      print('failMsg: $failMsg');
      String key = failedCodes.keys.firstWhere((String key) => failMsg.contains(key), orElse: () => failMsg);
      if (StringsHelper.isNotEmpty(key) && failedCodes[key] != null) {
//        if (failedCodes[key] != null) {
//        print('failMsg 2 failCode:' + failedCodes[failMsg]);
          return failedCodes[key];
//        }
      }else {
        return failMsg;
      }
    } else {
      LogUtils.printLog('not connected 2 failCode: 连接无信息返回，请重试！');
      return '连接失败，请重试！';
    }
    return failMsg;
  }
}
