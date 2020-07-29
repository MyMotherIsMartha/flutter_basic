import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class G {
  static Router router;
  static navigateTo(context, String path,
      {replace: false, TransitionType transition: TransitionType.inFromRight}) {
    router.navigateTo(context, path, replace: replace, transition: transition);
  }

  static GlobalKey<NavigatorState> key = GlobalKey(debugLabel: 'navigate_key');

  static SharedPreferences sp;

  static initSp() async {
    sp = await SharedPreferences.getInstance();
  }

  static setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static setSp(double fontsize) {
    return ScreenUtil().setSp(fontsize);
  }

  // 状态栏高度 刘海屏会更高  单位px
  static double statusHeight = ScreenUtil.statusBarHeight;
  // 底部安全区距离，适用于全面屏下面有按键的
  static double bottomHeight = ScreenUtil.bottomBarHeight;

  /// 获取时间戳
  /// 不传值 代表获取当前时间戳
  static int getTime([DateTime time]) {
    if (time == null) {
      return (DateTime.now().millisecondsSinceEpoch / 1000).round();
    } else {
      return (time.millisecondsSinceEpoch / 1000).round();
    }
  }

  static getPref(key) {
    return sp.getString(key);
  }

  static setPref(key, value) {
    sp.setString(key, value);
    return value;
  }

  static void removePref(key) {
    sp.remove(key);
  }

  static void clearPref() {
    sp.clear();
  }

  static BuildContext currentContext;

  static setContext(BuildContext context) {
    currentContext = context;
  }

  static Widget spacing(double height, {Color color, String dir = 'y'}) {
    return Container(
      height: dir == 'y' ? G.setHeight(height) : 0,
      width: dir == 'x' ? G.setWidth(height) : 0,
      color: color,
    );
  }

  static setTextEdit(String val) {
    return TextEditingValue(
        text: val,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: val.length)));
  }

  static String imgBaseUrl = 'lib/assets/images/';

  static setClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // toast('复制成功');
  }

  /// 每隔 x位 加 pattern
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text?.replaceAllMapped(RegExp("(.{$digit})"), (Match match) {
      return "${match.group(0)}$pattern";
    });
    if (text != null && text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  static String moneyToStr(double money) {
    if (money < 10000) {
      return money.toStringAsFixed(2);
    } else {
      return (money / 10000).toStringAsFixed(2) + 'W';
    }
  }

  static mixMobile(String mobile) {
    return mobile.substring(0, 3) + '****' + mobile.substring(7, 11);
  }
}
