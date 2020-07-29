import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_project/components/Icon.dart';
import 'package:flutter_project/utils/global.dart';

class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  List itemList = [
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
  ];
  Future _fetchList({bool refresh = false}) async {
    var newList = [
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
      {"category": "电压不稳", "dev_no": "电能", "reson": "机器温度过高"},
    ];
    return await Future.delayed(Duration(seconds: 1), () {
      print(mounted);
      print(refresh);
      if (mounted) {
        if (refresh != null && refresh) {
          setState(() {
            itemList = newList;
          });
        } else {
          itemList.addAll(newList);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            G.navigateTo(context, '/repairCreate');
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
          backgroundColor: Colors.white,
        ),
        appBar: AppBar(
          title: Text('报修管理'),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // 搜索事件
              },
              icon: iconsearch(),
            )
          ],
        ),
        backgroundColor: hex('#F3F4F6'),
        body: Container(
            width: G.setWidth(750),
            padding: EdgeInsets.symmetric(horizontal: G.setWidth(30)),
            child: EasyRefresh(
              controller: _refreshController,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: G.setHeight(10),
                        color: hex('#ccc'),
                      ),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return RepairItem(itemList[index]);
                  }),
              onRefresh: () async {
                _fetchList(refresh: true);
              },
              onLoad: () async {
                _fetchList();
              },
            )));
  }
}

class RepairItem extends StatelessWidget {
  final item;
  RepairItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: G.setWidth(180),
      width: G.setWidth(690),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(item['category']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('标准设备编号：' + item['dev_no']),
              Text('故障原因：' + item['reson']),
            ],
          )
        ],
      ),
    );
  }
}
