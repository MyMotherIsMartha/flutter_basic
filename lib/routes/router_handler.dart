import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/addDeviceForm.dart';
import 'package:flutter_project/pages/home.dart';
import 'package:flutter_project/pages/repair-create.dart';
import 'package:flutter_project/pages/repair.dart';
import 'package:flutter_project/pages/splash_page.dart';

// splash 页面
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SplashPage();
});

Handler indexHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

Handler repairHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RepairPage();
});

Handler repairCreateHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RepairCreatePagePage();
});

Handler addDeviceFormHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AddDeviceForm();
});
