import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/Icon.dart';
import 'package:flutter_project/utils/global.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 头部
  Widget _header() {
    return Container(
      height: G.setWidth(260),
      width: G.setWidth(690),
      padding: EdgeInsets.all(G.setWidth(30)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(G.setWidth(10)),
        color: hex('#F3F4F6'),
        image: DecorationImage(
          image: AssetImage("lib/assets/bg1.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 头像
              Container(
                  width: G.setWidth(120),
                  height: G.setWidth(120),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(G.setWidth(60))),
                  child: Image.asset(
                    'lib/assets/vip.png',
                    width: G.setWidth(120),
                    height: G.setWidth(120),
                  )),
              G.spacing(20, dir: 'x'),
              // 用户名
              Text('小新买蜡笔',
                  style: TextStyle(color: hex('#FFF'), fontSize: G.setSp(36)))
            ],
          ),
          InkWell(
              onTap: () {
                // 箭头点击事件
              },
              child: iconarrow(color: hex('#FFF')))
        ],
      ),
    );
  }

  // 分栏标题
  Widget _categoryTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: G.setWidth(40)),
      child: Text(
        title,
        style: TextStyle(
            fontSize: G.setSp(36),
            color: hex('#333'),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  // 图标子菜单
  /**
   * menu 菜单名称
   * icon 图片地址
   * href 跳转地址 
   */
  Widget _menuWithIcon(String menu, String icon, String href, {Function fn}) {
    return InkWell(
        onTap: () {
          if (fn != null) {
            fn(href);
          } else if (href != null) {
            G.navigateTo(context, href);
          } else {
            print('缺少参数');
          }
        },
        child: Container(
          width: G.setWidth(100),
          // color: Colors.red,
          // height: G.setWidth(200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(G.setWidth(50))),
                child: Image.asset(icon,
                    width: G.setWidth(100), height: G.setWidth(100)),
              ),
              G.spacing(20),
              Text(menu,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: G.setSp(30), color: hex('#767676')))
            ],
          ),
        ));
  }

  // 图标子菜单列表
  Widget _menusList(menus, height, itemHeight) {
    return Container(
        height: G.setWidth(height),
        width: G.setWidth(750),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 100 / itemHeight,
                crossAxisSpacing: G.setWidth(20),
                mainAxisSpacing: G.setWidth(20)),
            itemCount: menus.length,
            itemBuilder: (context, index) {
              var menu = menus[index];
              return _menuWithIcon(menu['menu'], menu['icon'], menu['href']);
            }));
  }

  // 巡检点检管理
  Widget _controller() {
    List menus = [
      {'menu': '巡检管理', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
      {'menu': '点检管理', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
    ];
    // List<Widget> menuList = menus.map((menu) {
    //   return _menuWithIcon(menu['menu'], menu['icon'], menu['href']);
    // }).toList();
    return _menusList(menus, 160.00, 105.00);
  }

  // 运行耗能统计
  Widget _statistics() {
    List menus = [
      {'menu': '运行开机率统计', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
      {'menu': '耗能查询', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
      {'menu': '每日耗能查询', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
      {'menu': '运行查询', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
      {'menu': '实时运行查询', 'icon': 'lib/assets/agent.png', 'href': '/repair'},
    ];

    return _menusList(menus, 480.00, 130.00);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
          centerTitle: true,
          elevation: 0,
          leading: Container(),
        ),
        backgroundColor: hex('#FFF'),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: G.setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _header(),
                _categoryTitle('巡检点检管理'),
                _controller(),
                _categoryTitle('运行耗能统计'),
                _statistics(),
              ],
            ),
          ),
        ));
  }
}

class IconnMenuModel {
  String menu;
  String src;
  String href;
  Function fn;

  IconnMenuModel({this.menu, this.src, this.href, this.fn});
}
