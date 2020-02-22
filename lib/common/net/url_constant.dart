///接口地址
class UrlConstant {

  static const String host = 'http://app.wanmagroup.com:8988/';

  ///登陆获取token
  static getToken() {
    return '${host}partner/app/getToken';
  }

  ///登陆
  static getLogin() {
    return '${host}androidWeb/loginService/login.do';
  }

  ///获取菜单数据
  static getAppMenus() {
    return '${host}partner/app/getAppMenus';
  }

  ///修改密码
  static updatePwd() {
    return '${host}androidWeb/loginService/changePwdNew.do';
  }
}