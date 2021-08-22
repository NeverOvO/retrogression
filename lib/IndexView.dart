

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neveruseless/neveruseless.dart';
import 'package:retrogression/realtime/realTimeView.dart';

class indexView extends StatefulWidget {
  final arguments;

  const indexView({Key? key, this.arguments}) : super(key: key);
  @override
  _indexViewState createState() => _indexViewState();
}

class _indexViewState extends State<indexView>  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  int currentIndex = 0;
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
    neverBus.emit('pageController', index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  @override
  void deactivate() {
    var bool = ModalRoute.of(context)!.isCurrent;
    if (bool) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  final pages = [
    realTimeView(),
    Container(),
    // MarketView(),
    // DigitalCurrencyView(),real time
    // WPFuturesIndexView(),
    // NPFuturesIndexView(),
    // AccountAssetsView(),
    // SettingViewController(),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Container(
              padding: EdgeInsets.all(5),
              child: Image(image: AssetImage('images/Moon.png'),fit: BoxFit.contain,width: 30,),
              alignment: Alignment.center,
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(5),
              child: Image(image: AssetImage('images/Sun.png'),fit: BoxFit.contain,width: 30,),
              alignment: Alignment.center,
            ),
            label: "实时",//title: Text("消息",style: TextStyle(color: currentIndex == 0 ? Colors.white : Colors.grey),),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon:Container(
              padding: EdgeInsets.all(5),
              child: Image(image: AssetImage('images/Star.png'),fit: BoxFit.contain,width: 30,),
              alignment: Alignment.center,
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(5),
              child: Image(image: AssetImage('images/Planet.png'),fit: BoxFit.contain,width: 30,),
              alignment: Alignment.center,
            ),
            label: "热门",//title: Text("消息",style: TextStyle(color: currentIndex == 0 ? Colors.white : Colors.grey),),
          ),
        ],
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize :12.0,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedFontSize : 12.0,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        onTap: onTap,
      ),
    );
  }
}
