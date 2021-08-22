import 'dart:convert' as convert;
import 'package:retrogression/Base/MyBotTextToast.dart';
import 'package:neveruseless/neveruseless.dart';

Map personMap = {
  'email' : '',
  'phone' : '',
  'uid' : '',
  'id' : '',
  'accountName' : '',
  'token' : '',
  "country" : '',
  'gaauthKey' : '',
  'securityPolicy' : '',
  'cashPwd' : "",
  'tradePolicy' : '',
  'inviteCode' : '',
};
//读取当前信息
getUserUnlockInfoWithUnid({String unid = '',Map? data}) async{
  if(unid == '' || unid == null){
    try{
      showMyCustomText('未获取到信息,请尝试重新登录');
    }catch(e){

    }
    return;
  }else{
    String _str = 'kAccountUnid' + unid;
    var _mapDic = await neverLocalStorageRead(_str);//这个没有的话 就是第一次登录
    if(_mapDic.toString() == "null" || _mapDic.toString() == ''){

    }else{
      Map _dic = convert.jsonDecode(_mapDic);
      personMap.update('email', (value) => _dic['email']);
      personMap.update('phone', (value) => _dic['phone']);
      personMap.update('token', (value) => _dic['token']);
      personMap.update('uid', (value) => _dic['uid']);
      personMap.update('id', (value) => _dic['id']);
      personMap.update('accountName', (value) => _dic['accountName']);
      personMap.update('country', (value) => _dic['country']);
      personMap.update('gaauthKey', (value) => _dic['gaauthKey']);
      personMap.update('securityPolicy', (value) => _dic['securityPolicy']);
      personMap.update('cashPwd', (value) => _dic['cashPwd']);
      personMap.update('tradePolicy', (value) => _dic['tradePolicy']);
      personMap.update('inviteCode', (value) => _dic['inviteCode']);
    }
    if(data != null){
      personMap.update('email', (value) => data['email']);
      personMap.update('phone', (value) => data['mobNo']);
      personMap.update('token', (value) => data['token']);
      personMap.update('uid', (value) => data['uid']);
      personMap.update('id', (value) => data['id']);
      personMap.update('accountName', (value) => data['accountName']);
      personMap.update('country', (value) => data['country']);
      personMap.update('gaauthKey', (value) => data['gaauthKey']);
      personMap.update('securityPolicy', (value) => data['securityPolicy']);
      personMap.update('cashPwd', (value) => data['cashPwd']);
      personMap.update('tradePolicy', (value) => data['tradePolicy']);
      personMap.update('inviteCode', (value) => data['inviteCode']);
    }
  }
}

//切换账户
getUserInfoSwitchWithUnid({String unid = ''}) async{
  if(unid == '' || unid == null){
    try{
      showMyCustomText('未获取到UNID,请尝试重新登录');
    }catch(e){

    }
    return;
  }else{
    String _mapDic = await neverLocalStorageRead(unid);//这个没有的话 就是第一次登录
    if(_mapDic == null || _mapDic == ''){
      personMap.update('enableFingerprint', (value) => false);
      personMap.update('enableGesture', (value) => false);
      // personMap.update('suggest', (value) => false);
    }else{
      Map _dic = convert.jsonDecode(_mapDic);
      personMap.update('email', (value) => _dic['email']);
      personMap.update('phone', (value) => _dic['phone']);
      personMap.update('token', (value) => _dic['token']);
      personMap.update('uid', (value) => _dic['uid']);
      personMap.update('id', (value) => _dic['id']);
      personMap.update('accountName', (value) => _dic['accountName']);
      personMap.update('country', (value) => _dic['country']);
      personMap.update('gaauthKey', (value) => _dic['gaauthKey']);
      personMap.update('securityPolicy', (value) => _dic['securityPolicy']);
      personMap.update('cashPwd', (value) => _dic['cashPwd']);
      personMap.update('tradePolicy', (value) => _dic['tradePolicy']);
      personMap.update('inviteCode', (value) => _dic['inviteCode']);
    }
  }
}

//存储信息
getSynchronizeUnlockInfo({String unid = ''}) async {
  if(unid == '' || unid == null){
    try{
      showMyCustomText('未获取到UNID,请尝试重新登录');
    }catch(e){

    }
    return;
  }
  String _str = 'kAccountUnid' + unid;
  neverLocalStorageWrite(_str, convert.jsonEncode(personMap));
  //存储所有账户 kUserDefaultsAllAccountNew

  var _allStr = await neverLocalStorageRead('kUserDefaultsAllAccountNew');
  if(_allStr.toString() == "null" || _allStr.toString() == ''){//单账户模式
    String _account;
    if(personMap['email'].toString().contains("@")){
      _account = personMap['email'];
    }else{
      _account = personMap['phone'];
    }
    print(_account);
    Map _allDic = {
      _account  : 'kAccountUnid' + unid,
    };
    neverLocalStorageWrite('kUserDefaultsAllAccountNew', convert.jsonEncode(_allDic));
  }else{//存在历史账户
    Map _allDic = convert.jsonDecode(_allStr);
    String _account;
    if(personMap['email'].toString().contains("@")){
      _account = personMap['email'];
    }else{
      _account = personMap['phone'];
    }
    if(!_allDic.containsKey(personMap['email']) && !_allDic.containsKey(personMap['phone'])){
      _allDic[_account] = 'kAccountUnid' + unid;
      neverLocalStorageWrite('kUserDefaultsAllAccountNew', convert.jsonEncode(_allDic));
    }else{
      neverLocalStorageWrite('kUserDefaultsAllAccountNew', convert.jsonEncode(_allDic));
    }
  }
}

