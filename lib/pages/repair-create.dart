// import 'package:agent37_flutter/components/Icon.dart';
import 'package:color_dart/color_dart.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_project/components/Button.dart';
import 'package:flutter_project/components/Icon.dart';
import 'package:flutter_project/components/Input.dart';
import 'package:flutter_project/utils/global.dart';
import 'package:flutter_project/utils/validate.dart';

class RepairCreatePagePage extends StatefulWidget {
  @override
  _RepairCreatePagePageState createState() => _RepairCreatePagePageState();
}

class _RepairCreatePagePageState extends State<RepairCreatePagePage> {
  final idNoController = TextEditingController();
  final devNoController = TextEditingController();
  String dev_name;
  String dev_no;

  Map formValidate = {
    'dev_name': true,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('报修申请'),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: hex('#f3f4f6'),
        body: SingleChildScrollView(
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // 触摸收起键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      color: hex('#FFF'),
                      padding: EdgeInsets.symmetric(horizontal: G.setWidth(30)),
                      child: Column(
                        children: <Widget>[
                          Input(
                            controller: idNoController,
                            hintText: '请输入设备名称',
                            label: '名称',
                            maxLength: 18,
                            // suffixWidth: 150,
                            suffixIcon: InkWell(
                              onTap: () {
                                // 扫描
                              },
                              child: Icon(
                                Icons.photo_camera,
                                color: hex('#999'),
                              ),
                            ),
                            labelWidth: G.setWidth(240),
                            onChange: (e) {
                              dev_name = e;
                              // var reg =
                              //     r"(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}$)";
                              setState(() {
                                formValidate['dev_name'] = !Validate.isNon(e);
                              });
                            },
                          ),
                          Input(
                            controller: devNoController,
                            hintText: '点击选择',
                            readOnly: true,
                            suffixIcon: iconarrow(color: hex('#999')),
                            onTap: () {
                              _showPickerJobs(context);
                            },
                            label: '标准设备编号',
                            labelWidth: G.setWidth(240),
                          ),
                          Input(
                            controller: devNoController,
                            hintText: '点击选择',
                            readOnly: true,
                            suffixIcon: iconarrow(color: hex('#999')),
                            onTap: () {
                              _showPickerJobs(context);
                            },
                            label: '标准设备编号',
                            labelWidth: G.setWidth(240),
                          ),
                          Input(
                            controller: idNoController,
                            hintText: '请输入内容',
                            label: '描述',
                            labelWidth: G.setWidth(240),
                            onChange: (e) {
                              dev_name = e;
                              // var reg =
                              //     r"(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}$)";
                              setState(() {
                                formValidate['dev_name'] = !Validate.isNon(e);
                              });
                            },
                          ),
                          Input(
                            controller: idNoController,
                            hintText: '请输入内容',
                            label: '维修方法',
                            labelWidth: G.setWidth(240),
                            onChange: (e) {
                              dev_name = e;
                              // var reg =
                              //     r"(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}$)";
                              setState(() {
                                formValidate['dev_name'] = !Validate.isNon(e);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: G.setWidth(20),
                      color: hex('#f3f4f6'),
                    ),
                    Container(
                      color: hex('#FFF'),
                      padding: EdgeInsets.all(G.setWidth(30)),
                      alignment: Alignment.centerLeft,
                      child: Text('故障原因',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: G.setSp(28),
                              fontWeight: FontWeight.bold,
                              color: hex('#333'))),
                    ),
                    Container(
                      height: G.setWidth(240),
                      color: hex('#FFF'),
                      padding: EdgeInsets.fromLTRB(G.setWidth(30),
                          G.setWidth(0), G.setWidth(30), G.setWidth(30)),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: G.setWidth(1), color: hex('#ccc'))),
                          padding:
                              EdgeInsets.symmetric(horizontal: G.setWidth(30)),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            minLines: 3,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          )),
                    ),
                    G.spacing(80),
                    Button(
                      text: '确定',
                      rgbStart: [15, 187, 69],
                      rgbEnd: [15, 187, 69],
                      fs: 32,
                      height: 80,
                      disabled:
                          formValidate.containsValue(false), // 如果包含false验证不通过
                      fn: () {
                        // 提交
                      },
                    ),
                    G.spacing(80),
                  ],
                ))));
  }

  _showPickerJobs(BuildContext context) {
    // List<PickerItem<dynamic>> testArray = jobList
    //     .map<PickerItem>(
    //         (item) => PickerItem(text: Text(item['name']), value: item['code']))
    //     .toList();
    Picker picker = new Picker(
        adapter: PickerDataAdapter(data: [
          new PickerItem(
              text: Icon(Icons.title),
              value: Icons.title,
              children: [
                new PickerItem(text: Icon(Icons.more_vert)),
                new PickerItem(text: Icon(Icons.ac_unit)),
                new PickerItem(text: Icon(Icons.access_alarm)),
                new PickerItem(text: Icon(Icons.account_balance)),
              ]),
        ]),
        cancelText: '取消',
        confirmText: '确认',
        // changeToFirst: true,
        // textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          devNoController.value = TextEditingValue(text: value.toString());
          setState(() {
            dev_no = value.toString();
          });
        });
    picker.showModal(context);
  }
}
