

//查询内盘期货投资者帐号
import 'package:retrogression/Base/HttpRequest.dart';

GetRandomInfo({String time = '0'})async{
  String _url = "/GetRandomInfo?time=" + time + "&is_follow=0";
  Map<String, String> data = {
    // "\"exchangeNo\"": "\"" + exchangeNo + "\"",
  };
  return await httpHeader(kAddress, _url, data.toString(),HttpTypes: 'GET');
}