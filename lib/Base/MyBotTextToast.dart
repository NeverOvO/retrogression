import 'dart:convert';
import 'dart:math';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

closeMyCustomBotLoading(){
  BotToast.closeAllLoading();
}

showMyCustomText(String text,{int seconds = 2}) {
  BotToast.showCustomText(
    duration: Duration(seconds: seconds),
    onlyOne: true,
    clickClose: false,//点击关闭
    crossPage: true,//跨页面
    ignoreContentClick: true,//穿透
    backgroundColor: Colors.transparent,
    backButtonBehavior: BackButtonBehavior.none,
    animationDuration: Duration(milliseconds: 200),
    animationReverseDuration: Duration(milliseconds: 200),
    toastBuilder: (_) => Align(
      alignment: Alignment(0, 0.8),
      child: Container(
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(text,style: TextStyle(fontSize: 13,color: Colors.black87),),
            ),
          ],
        ),
      ),
    ),
  );
}

//帮助文本弹窗
showMyCustomHelpText(String text,{double fontSize = 14.0}) {
  BotToast.showCustomText(
    duration: Duration(seconds: 600),
    onlyOne: true,
    clickClose: true,//点击关闭
    crossPage: false,//跨页面
    ignoreContentClick: false,//穿透
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
    backButtonBehavior: BackButtonBehavior.close,
    animationDuration: Duration(milliseconds: 200),
    animationReverseDuration: Duration(milliseconds: 200),
    toastBuilder: (_) => Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      alignment: Alignment(0, 0),
      child: Container(
        decoration: new BoxDecoration(
          //背景
          color: Color.fromRGBO(37, 50, 58, 1),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Text(text,style: TextStyle(fontSize:fontSize,color: Colors.white),),
            ),
          ],
        ),
      ),
    ),
  );
}

showMyCustomLoading(String text,{double fontSize = 14.0,int seconds = 10}) {

  BotToast.showCustomLoading(
      clickClose: false,//点击关闭
      allowClick: false,//
      backButtonBehavior: BackButtonBehavior.none,
      ignoreContentClick: false,
      animationDuration: Duration(milliseconds: 200),
      animationReverseDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: seconds,),
      backgroundColor: Color(0x42000000),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return _CustomLoadWidget(cancelFunc: cancelFunc,text: text,);
      });
}

class _CustomLoadWidget extends StatefulWidget {
  final CancelFunc? cancelFunc;
  final String? text;
  const _CustomLoadWidget({Key? key, this.cancelFunc,this.text}) : super(key: key);

  @override
  __CustomLoadWidgetState createState() => __CustomLoadWidgetState();
}

class __CustomLoadWidgetState extends State<_CustomLoadWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    animationController!.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController!.forward();
      }
    });
    animationController!.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FadeTransition(
              opacity: animationController!,
              child: Image(image: AssetImage('image/AppLogo.png'),
                width: 60,
                height: 60,),
            ),
            SizedBox(height: 10,),
            Text(widget.text!,),
          ],
        ),
      ),
    );
  }
}