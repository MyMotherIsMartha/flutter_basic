// import 'package:agent37_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/home.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String root = '/';
  static String index = '/index';
  static String repairPage = '/repair';
  static String repairCreatePage = '/repairCreate';
  static String addDeviceForm = '/addDeviceForm';
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
      return HomePage();
    });
    router.define(root, handler: splashHandler);
    router.define(index, handler: indexHandler);
    router.define(repairPage, handler: repairHandler);
    router.define(repairCreatePage, handler: repairCreateHandler);
    router.define(addDeviceForm, handler: addDeviceFormHandler);
  }
}
