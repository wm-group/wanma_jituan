import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/result_dao.dart';
import 'package:wanma_jituan/common/db/provider/user_info_db_provider.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:wanma_jituan/common/model/User.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';
import 'package:wanma_jituan/common/redux/user_reducer.dart';
import 'package:wanma_jituan/common/utils/common_utils.dart';
import 'package:wanma_jituan/common/net/code.dart';

class UserDao {
  ///登录
  static login(userName, password, store) async {
//    String type = userName + ':' +password;
//    var bytes = utf8.encode(type);
//    var base64Str = base64.encode(bytes);
//    if(Config.DEBUG) {
//      print("base64Str login " + base64Str);
//    }
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
//    await LocalStorage.save(Config.USER_BASIC_CODE, base64Str);

    Map<String, dynamic> requestParams = {
      'app_type': 'ios',
      'userId': userName,
      'password': password
    };

    HttpManager.clearAuthorization();

    var res = await HttpManager.netFetch(UrlConstant.getLogin(), requestParams, null, Options(method: 'post'));
    var resultData;
    if(res != null && res.result) {

      var resultData;
      if(res.data['result']){
        await LocalStorage.save(Config.PW_KEY, password);

        User user = User(userName: userName, password: password);
        //存入数据库
        UserInfoDbProvider provider = UserInfoDbProvider();
        provider.insert(userName, password);

        //取出头像照片地址
        var imagePath = await LocalStorage.get(Config.AVATAR);
        user.image = imagePath;
        //保存用户信息
        LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));

        resultData= ResultDao(user, res.result);
        if (Config.DEBUG) {
          print("user result " + resultData.result.toString());
          print(resultData.data);
          print(res.data.toString());
        }
        store.dispatch(UpdateUserAction(resultData.data));
//        Code.errorHandleFunction(200, res.data['msg'], false);
      }else{
        resultData = ResultDao(Code.errorHandleFunction(res.code, res.data['msg'], false), false);
        return ResultDao(resultData, false);
      }
    }
    return ResultDao(resultData, res.result);
  }

  ///修改密码
  static updatePwd(oldPwd, newPwd, newPwd2) async {

    var resultData;
    var _userId = await LocalStorage.get(Config.USER_NAME_KEY);

    Map<String, dynamic> requestParams = {
      'userId': _userId,
      'newpwd': newPwd,
      'oldPwd': oldPwd,
    };

    var res = await HttpManager.netFetch(UrlConstant.updatePwd(), requestParams, null, Options(method: 'post'));
    if(res.data['result']){
      resultData = ResultDao(res.data['msg'], true);
    }else {
      resultData = ResultDao(Code.errorHandleFunction(res.code, res.data['msg'], false), false);
    }

    return ResultDao(resultData ?? null, res.result);
  }

  ///获取用户信息
//  static getUserInfo(String userName) async {
//    UserInfoDbProvider provider = UserInfoDbProvider();
//    var res = await HttpManager.netFetch('', null, null, null);
//  }
  
  static clearAll(Store store) async {
    HttpManager.clearAuthorization();
    LocalStorage.remove(Config.USER_INFO);
    store.dispatch(new UpdateUserAction(User.empty()));
  }

  ///初始化用户信息
  static initUserInfo(Store store) async {
    
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    ResultDao res = await getUserInfoLocal();

    if(res != null && res.result && token != null) {
      store.dispatch(UpdateUserAction(res.data));
    }
    
    //读取主题
    String themeIndex = await LocalStorage.get(Config.THEME_COLOR);
    if(themeIndex != null && themeIndex.length != 0) {
      CommonUtils.pushTheme(store, int.parse(themeIndex));
    }

    return ResultDao(res.data, (res.result && (token != null)));
  }

  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if(userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return ResultDao(user, true);
    }else {
      return ResultDao(null, false);
    }
  }
}