import 'dart:convert';
import 'dart:io';
import 'package:retrogression/Base/MyBotTextToast.dart';
import 'package:retrogression/main.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

import 'package:neveruseless/neveruseless.dart';

const String kAddress = "https://api.tophub.fun";

httpHeader(String baseUrl,String url,String signMessage,{String HttpTypes = 'POST'}) async {

  var dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 100000,
    receiveTimeout: 100000,
    // 5s
    headers: {
      HttpHeaders.userAgentHeader: 'Mozilla/5.0',
      HttpHeaders.acceptLanguageHeader : "zh-Hans-CN;q=1, en-CN;q=0.9",
      HttpHeaders.acceptHeader : "*/*",
      HttpHeaders.contentTypeHeader : "application/x-www-form-urlencoded",
    },
    // followRedirects: false,
    // validateStatus: (status) { return status! < 500 ; }
  ));
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
    client.badCertificateCallback=(cert, host, port){
      return true;
    };
  };
  try {
    Response _response ;
    if(HttpTypes == 'POST'){
      _response = await dio.post(
        url,
        data: signMessage,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    }else if(HttpTypes == 'GET'){
      _response = await dio.get(
        url,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    }else if(HttpTypes == 'GETBODY'){
      _response = await dio.get(
        url,
        queryParameters : jsonDecode(signMessage),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    }else{
      _response = await dio.post(
        url,
        data: signMessage,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    }
    // print(_response);
    try{
      Map<String, dynamic> _responseData = convert.jsonDecode(_response.toString());
      if(_responseData.containsKey("code")){
        if((_responseData["code"] == 200 || _responseData["code"] == 2001) ){
          return _responseData;
        }else if(_responseData['code'] == 2023 || _responseData['code'] == 2000) {
        }else{
          return _responseData;
        }
      }else{
        return _responseData;
      }
    }catch(e){
      showMyCustomText('解析有问题，检查DIO组');
    }
  } on DioError catch (e) {
    return e.error;
  }
}
