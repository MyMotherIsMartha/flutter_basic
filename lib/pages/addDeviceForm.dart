

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_project/components/Button.dart';
import 'package:color_dart/hex_color.dart';
import 'package:flutter_project/components/Input.dart';

import 'package:flutter_project/utils/global.dart';
import 'package:flutter_project/components/Icon.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_project/utils/validate.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class AddDeviceForm extends StatefulWidget {
  final String uploadJson;

  AddDeviceForm({this.uploadJson});
  @override
  _AddDeviceFormState createState() => _AddDeviceFormState();
}

class _AddDeviceFormState extends State<AddDeviceForm> {
  final _formKey = GlobalKey<FormState>();

  String checkDate;
  DateTime checkDateVal = DateTime(1990, 01, 01, 0, 0, 0);
  String patrolTime;
  DateTime patrolTimeVal = DateTime(1990, 01, 01, 0, 0, 0);
  String sex;
  String classVal;
  String resultVal;
  String attachmentPath;
  

  List<dynamic> jobList = [];
  List<dynamic> categoryList = [
    { 'name': '类别1', 'code': 'category1'},
    { 'name': '类别2', 'code': 'category2'},
    { 'name': '类别3', 'code': 'category3'}
  ];

  List<dynamic> companyList = [
    { 'name': '单位1', 'code': 'company1'},
    { 'name': '单位2', 'code': 'company2'},
    { 'name': '单位3', 'code': 'company3'}
  ];


  Map uploadData;

  final checkDateCtrl = TextEditingController();
  final deviceCtrl = TextEditingController();
  final patrolTimeCtrl = TextEditingController();
  final patrolCategoryCtrl = TextEditingController();
  final patrolPersonCtrl = TextEditingController();
  final patrolCompanyCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();


  final jobCodeCtrl = TextEditingController();
  final areaCtrl = TextEditingController();

  String jobCode;
  String areaCode;
  String areaName;
  String addressStr;
  String enterpriseName;
  String registerCode;
  String legalPerson;

  Map formValidate = {
    'checkDate': false,

    'jobCode': false,
    'areaCode': false,
    'registerCode': false,
    'enterpriseName': false,
    'addressStr': false,
    'legalPerson': false
  };

  @override
  void initState() {
    super.initState();
  }

  // _getTradeList() async {
    
  //   var result = await DicApi().getTradeList();
  //   List resultData = result.data['data']['records'];
  //   if (resultData != null) {
  //     jobList = List.from(resultData.map((item) {
  //       return {
  //         'name': item['tradeName'],
  //         'code': item['tradeId']
  //       };
  //     }));
  //   } else {
  //     jobList = [];
  //   }
  // }
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: hex('#f3f4f6'),
      appBar: AppBar(
        title: Text('设备添加'),
        centerTitle: true,
        
        // leading: BackButton(onPressed: () {
        //   G.navigateTo(context, '/resultPage?status=1', replace: true, transition: TransitionType.inFromLeft);
        // },),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: hex('#F3F4F6'),
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.all(15),
              //   alignment: Alignment.centerLeft,
              //   child: Text('收货地址',
              //       style: TextStyle(color: hex('#999'), fontSize: G.setSp(30))),
              // ),
              Container(
                height: G.setHeight(20)
              ),
              Container(
                color: hex('#FFF'),
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Input(
                        controller: checkDateCtrl,
                        hintText: '请选择日期',
                        label: '点检日期',
                        textColor: hex('#333'),
                        readOnly: true,
                        suffix: iconarrow(size: G.setSp(36)),
                        suffixWidth: G.setWidth(10),
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              maxTime: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              onChanged: (date) {}, onConfirm: (date) {
                            String dateStr =
                                formatDate(date, [yyyy, '-', mm, '-', dd]);
                            checkDateCtrl.value =
                                TextEditingValue(text: dateStr);
                            setState(() {
                              checkDateVal = date;
                              checkDate = dateStr;
                              formValidate['checkDate'] = !Validate.isNon(dateStr);
                            });
                            print(formValidate);
                            print(formValidate.containsValue(false));
                          },
                              currentTime: checkDateVal,
                              locale: LocaleType.zh);
                        },
                      ),
                      _selectClass(),
                      Input(
                        controller: deviceCtrl,
                        hintText: '请输入设备名称',
                        type: TextInputType.text,
                        maxLength: 18,
                        label: '设备名称',
                        suffixWidth: G.setWidth(10),
                        onChange: (e) {
                          setState(() {
                            formValidate['device'] = !Validate.isNon(e);
                          });
                        },
                      ),
                      Input(
                        controller: patrolTimeCtrl,
                        hintText: '请选择时间',
                        label: '巡检时间',
                        textColor: hex('#333'),
                        readOnly: true,
                        suffix: iconarrow(size: G.setSp(36)),
                        suffixWidth: G.setWidth(10),
                        onTap: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true,
                              onChanged: (date) {}, onConfirm: (date) {
                            String timeStr =
                                formatDate(date, [HH, ':', nn, ':', ss]);
                            patrolTimeCtrl.value =
                                TextEditingValue(text: timeStr);
                            setState(() {
                              patrolTimeVal = date;
                              patrolTime = timeStr;
                              formValidate['birthday'] = !Validate.isNon(timeStr);
                            });
                            print(formValidate);
                            print(formValidate.containsValue(false));
                          },
                              currentTime: patrolTimeVal,
                              locale: LocaleType.zh);
                        },
                      ),
                      Input(
                        controller: patrolCategoryCtrl,
                        hintText: '请选择巡检类别',
                        label: '巡检类别',
                        textColor: hex('#333'),
                        readOnly: true,
                        suffix: iconarrow(size: G.setSp(36)),
                        suffixWidth: G.setWidth(10),
                        onTap: () {
                          _showCategory(context);
                        },
                      ),
                      _selectResult(),
                      Input(
                        controller: patrolPersonCtrl,
                        hintText: '请输入姓名',
                        type: TextInputType.text,
                        maxLength: 18,
                        label: '巡检人',
                        suffixWidth: G.setWidth(10),
                        onChange: (e) {
                          setState(() {
                            formValidate['device'] = !Validate.isNon(e);
                          });
                        },
                      ),
                      Input(
                        controller: patrolCompanyCtrl,
                        hintText: '请选择单位',
                        label: '巡检单位',
                        textColor: hex('#333'),
                        readOnly: true,
                        suffix: iconarrow(size: G.setSp(36)),
                        suffixWidth: G.setWidth(10),
                        onTap: () {
                          _showCompany(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: G.setHeight(30)),
              Container(
                color: hex('#fff'),
                width: double.infinity,
                padding: EdgeInsets.all(G.setWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('添加图片/附件', style: TextStyle(fontSize: G.setSp(30))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: G.setHeight(15)),
                      child: Container(
                        width: G.setWidth(330),
                        child: Column(
                          children: <Widget>[
                            uploadImg('front', 1),
                            // Text('上传正面照', style: TextStyle(height: 2),)
                          ],
                        ),
                      ),
                    )
                  ]
                ),
              ),
              SizedBox(height: G.setHeight(30)),
              Container(
                color: hex('#fff'),
                width: double.infinity,
                padding: EdgeInsets.all(G.setWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('备注', style: TextStyle(fontSize: G.setSp(30))),
                    SizedBox(height: G.setWidth(10)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: G.setWidth(30), vertical: G.setWidth(15)),
                      decoration: BoxDecoration(
                        border: Border.all(color: hex('#ccc'), width:  G.setWidth(1))
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white30),
                            labelStyle: TextStyle(color: Colors.white)),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: G.setSp(28),
                        ),
                        controller: remarkCtrl,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Empty value";
                          }
                        },
                      )
                    )
                  ]
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 60, bottom: 30),
                child: Button(
                  // disabled: formValidate.containsValue(false),
                  text: '提交',
                  fn: () async {
                    //  字端根据ui图从上到下一个顺序
                    Map params = {
                      'checkDate': checkDate,
                      'class': classVal,
                      'deviceName': deviceCtrl.value.text,
                      'patrolTime': patrolTime,
                      'patrolCategory': patrolCategoryCtrl.text,
                      'patrolResult': resultVal,
                      'patrolPerson': patrolPersonCtrl.value.text,
                      'patrolCompany': patrolCompanyCtrl.text,
                      'attachment': attachmentPath,
                      'remark': remarkCtrl.value.text
                    };
                    print(params);
                  }
                )
              ),
            ],
          ),
        ),
      )
      );
  }


  void _takePhoto(source) async {
    bool flag;
    if (source == ImageSource.camera) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
      ].request();
      flag = statuses[Permission.camera] == PermissionStatus.granted;
      if (!flag) {
        print('请在设置里打开应用的相机权限');
      }
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.photos
      ].request();
      flag = statuses[Permission.storage] == PermissionStatus.granted && statuses[Permission.photos] == PermissionStatus.granted;
      if (!flag) {
        print('请在设置里打开应用的照片权限');
      }
      // pre = await Permission.photos.status;
    }
    Navigator.pop(context);
    // print(pre);
    // print('权限啊权限');
    if (!flag) {
      return;
    }
    File image = await ImagePicker.pickImage(source: source);
    print(image);
    if (image != null) {
      _uploadImage(image);
    }
  }

  _uploadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    // FormData formData = FormData.from({
    //   "userId": "10000024",
    //   "file": UploadFileInfo(new File(path), name,
    //       contentType: ContentType.parse("image/$suffix"))
    // });
    // FormData data = FormData.fromMap({
    //     "file": await MultipartFile.fromFile(path,filename: name + '.' + suffix)
    // });
  }

  Widget uploadImg(String type, int index) {
    return InkWell(
        onTap: () {
          G.setContext(context);
          // Oss.selectSource((path) {
          //   setState(() {
          //     if (index == 1) {
          //       if (type == 'front') {
          //         frontIdCardImg1 = path;
          //       } else {
          //         backIdCardImg1 = path;
          //       }
          //     } else if (index == 2) {
          //       if (type == 'front') {
          //         frontIdCardImg2 = path;
          //       } else {
          //         backIdCardImg2 = path;
          //       }
          //     }
          //   });
          // });
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text("拍照"),
                      onTap: () {
                        _takePhoto(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text("相册"),
                      onTap: () {
                        _takePhoto(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
          );
        },
        child: Stack(
            children: <Widget>[
              // Container(
              //   // alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //             // color: Colors.black26,
              //     image: DecorationImage(
              //       image: AssetImage('lib/assets/logo.png'),
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              //   width: G.setWidth(330),
              //   height: G.setHeight(206),
              //   // child: Image(image: new AssetImage('lib/assets/images/enterprise/idCardFront.png')),
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                width: G.setWidth(330),
                height: G.setHeight(206),
              ),
              Container(
                width: G.setWidth(330),
                height: G.setHeight(206),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: G.setWidth(80),
                      height: G.setWidth(80),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/plus.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
  }


  Widget _selectClass() {
    return Container(
      height: G.setWidth(100),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: hex('#eee'), width: G.setWidth(1)))
      ),
      padding: EdgeInsets.symmetric(horizontal: G.setWidth(30)),
      child: Row(
        children: <Widget>[
          Container(
              width: G.setWidth(160),
              child: Text('班次选择',
                  style: TextStyle(fontSize: G.setSp(30), color: hex('#666')))),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Radio(
                  value: 'day',
                  onChanged:(v){
                    setState(() {
                      classVal=v;
                    });
                  },
                  groupValue: classVal,
                ),
                Text('白班', style: TextStyle(fontSize: G.setSp(30))),
                SizedBox(width: G.setWidth(20)),
                Radio(
                  value: 'night',
                  onChanged:(v){
                    setState(() {
                      classVal=v;
                    });
                  },
                  groupValue: classVal,
                ),
                Text('夜班', style: TextStyle(fontSize: G.setSp(30)))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _selectResult() {
    return Container(
      height: G.setWidth(100),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: hex('#eee'), width: G.setWidth(1)))
      ),
      padding: EdgeInsets.symmetric(horizontal: G.setWidth(30)),
      child: Row(
        children: <Widget>[
          Container(
              width: G.setWidth(160),
              child: Text('巡检结果',
                  style: TextStyle(fontSize: G.setSp(30), color: hex('#666')))),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Radio(
                  value: 'good',
                  onChanged:(v){
                    setState(() {
                      resultVal=v;
                    });
                  },
                  groupValue: resultVal,
                ),
                Text('合格', style: TextStyle(fontSize: G.setSp(30))),
                SizedBox(width: G.setWidth(20)),
                Radio(
                  value: 'bad',
                  onChanged:(v){
                    setState(() {
                      resultVal=v;
                    });
                  },
                  groupValue: resultVal,
                ),
                Text('不合格', style: TextStyle(fontSize: G.setSp(30)))
              ],
            ),
          )
        ],
      ),
    );
  }
  
  _showPickerJobs(BuildContext context) {
    List<PickerItem<dynamic>> testArray = jobList.map<PickerItem>((item) => PickerItem(text: Text(item['name']), value: item['code'])).toList();
    Picker picker = new Picker(
      adapter: PickerDataAdapter(data: testArray),
      cancelText: '取消',
      confirmText: '确认',
      // changeToFirst: true,
      // textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues().first);
        jobCodeCtrl.value = TextEditingValue(text: picker.getSelectedValues().first);
        jobCode = picker.getSelectedValues().first;
        jobCodeCtrl.text = jobList[value.first]['name'];
        setState(() {
          formValidate['jobCode'] = true;
        });
        print(jobCodeCtrl.text);
      }
    );
    picker.showModal(context);
  }

  _showCategory(BuildContext context) {
    List<PickerItem<dynamic>> testArray = categoryList.map<PickerItem>((item) => PickerItem(text: Text(item['name']), value: item['code'])).toList();
    Picker picker = new Picker(
      adapter: PickerDataAdapter(data: testArray),
      cancelText: '取消',
      confirmText: '确认',
      // changeToFirst: true,
      // textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        jobCodeCtrl.value = TextEditingValue(text: picker.getSelectedValues().first);
        jobCode = picker.getSelectedValues().first;
        patrolCategoryCtrl.text = categoryList[value.first]['name'];
        setState(() {
          formValidate['jobCode'] = true;
        });
        print(patrolCategoryCtrl.text);
      }
    );
    picker.showModal(context);
  }

  _showCompany(BuildContext context) {
    List<PickerItem<dynamic>> testArray = companyList.map<PickerItem>((item) => PickerItem(text: Text(item['name']), value: item['code'])).toList();
    Picker picker = new Picker(
      adapter: PickerDataAdapter(data: testArray),
      cancelText: '取消',
      confirmText: '确认',
      // changeToFirst: true,
      // textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        jobCodeCtrl.value = TextEditingValue(text: picker.getSelectedValues().first);
        jobCode = picker.getSelectedValues().first;
        patrolCompanyCtrl.text = companyList[value.first]['name'];
        setState(() {
          formValidate['jobCode'] = true;
        });
        print(patrolCompanyCtrl.text);
      }
    );
    picker.showModal(context);
  }
}
