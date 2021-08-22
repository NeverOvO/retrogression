import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:octo_image/octo_image.dart';
import 'package:retrogression/Base/Global.dart';
import 'package:retrogression/Base/MyBotTextToast.dart';
import 'package:retrogression/realtime/realTimeHttp.dart';
import 'package:retrogression/realtime/realTimeResponseModel.dart';
class realTimeView extends StatefulWidget {
  final arguments;
  const realTimeView({Key? key, this.arguments}) : super(key: key);

  @override
  _realTimeViewState createState() => _realTimeViewState();
}

class _realTimeViewState extends State<realTimeView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  int _time = 0;
  bool _hasNextPage = false;

  List<realTimeResponseData>? _realTimeList = [];
  realTimeResponseModel? _realTimeResponse ;
  @override
  void initState() {
    super.initState();
    _GetRandomInfoHttp();
  }

  //内盘期货 新增API 新增
  Future _GetRandomInfoHttp() async{
    var response = await GetRandomInfo(time: _time.toString());
    if (response is Map) {
      if(!mounted){
        return;
      }
      if(response['Code'] == 0){
        setState(() {
          _realTimeResponse = realTimeResponseModel.fromJson(response);
          if (_time == 0) {
            _realTimeList = _realTimeResponse!.data;
          } else {
            _realTimeList!.addAll(_realTimeResponse!.data!);
          }


          _hasNextPage = _realTimeResponse!.page! > _time;
        });

        print(_time);
        print(_realTimeList!.length);
        print(_hasNextPage);
      }else {
        if(response.containsKey('Message')){
          showMyCustomText(response["Message"]);
        }else{
          showMyCustomText('遇到问题，请检查网络或重新刷新');
        }
      }
    }else {
      try{
        showMyCustomText(response.error.toString());
      }catch(e){
        showMyCustomText('遇到问题，请检查网络或重新刷新');
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      right: true,
      bottom: false,
      left: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("实时"),
        ),
        body:EasyRefresh.custom(
          header: TaurusHeader(),
          footer: _hasNextPage ? TaurusFooter() : null,
          firstRefresh: true,
          firstRefreshWidget: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SizedBox(
                height: 200.0,
                width: 300.0,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        child: SpinKitFadingCube(
                          color: Theme.of(context).primaryColor,
                          size: 25.0,
                        ),
                      ),
                      Container(
                        child: Text("加载中～"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _time = 0;
                  _GetRandomInfoHttp();
                });
              }
            });
          },
          onLoad:_hasNextPage ? () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _time += 1;
                  _GetRandomInfoHttp();
                });
              }
            });
          }: null,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return realTimeCell(_realTimeList![index]);
              },
                childCount:_realTimeList!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget realTimeCell(realTimeResponseData data){
    return GestureDetector(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 50),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                data.icon != ""?
                                CachedNetworkImage(
                                  height: 20,
                                  width: 20,
                                  fadeInDuration : const Duration(milliseconds: 0),
                                  imageUrl: data.icon!,
                                  placeholder: (context, url) => Icon(Icons.people_alt,color: Colors.transparent,size: 15,),
                                  errorWidget: (context, url, error) => Container(height: 20,width: 20,color: Colors.grey,),
                                ) : Container(height: 20,width: 20,color: Colors.amber,),
                                Container(
                                  child: Text(data.type!,style: TextStyle(fontSize: 11)),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                ),
                                Container(
                                  child: Text(formatDate(DateTime.fromMillisecondsSinceEpoch((int.tryParse(data.createTime!) ?? 0) * 1000),
                                      [HH, ':', nn, ':', ss]),style: TextStyle(fontSize: 11,)),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(5, 3, 0, 0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              child: Text(data.title!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),maxLines: 3,softWrap:true,overflow:TextOverflow.ellipsis),
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                      )
                  ),
                  data.imgUrl != '' ?
                  Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      height: 100,
                      width: 120,
                      fadeInDuration : const Duration(milliseconds: 100),
                      imageUrl: data.imgUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Container(),
                    ),
                  ):Container()
                ],
              ),
            ),
          ),
          const Divider(height: 1,color: Colors.black,),
        ],
      ),
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if(data.url == ''){
          showMyCustomText("无法打开对应页面哦");
        }

        String _thisUrl = data.url!;

        if(_thisUrl.startsWith("//")){
          _thisUrl = "https:" + _thisUrl;
        }
        Navigator.pushNamed(context, "/WebView" ,arguments: {
          "url" : _thisUrl,
          "title" : data.title,
        });
      },
    );
  }
}



