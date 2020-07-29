import 'package:flutter/material.dart';
import 'package:flutter_project/utils/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      goPage();
    });
  }

  void goPage() async {
    G.navigateTo(context, '/addDeviceForm', replace: true);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    G.setContext(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: true,
          left: false,
          right: false,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            child: Image.asset('lib/assets/logo.png', width: 75, height: 75),
          ),
        ));
  }
}
