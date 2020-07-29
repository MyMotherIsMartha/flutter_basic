import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';

import '../utils/global.dart';

class Button extends StatelessWidget {
  final String text;
  final String textColor;
  final Function fn;
  final double width;
  final double height;
  final double fs;
  final bool disabled;
  final List<BoxShadow> shadown;
  final List<int> rgbStart;
  final List<int> rgbEnd;
  Button(
      {@required this.text,
      @required this.fn,
      this.shadown,
      this.width = 590,
      this.height = 100,
      this.fs = 36,
      this.rgbStart = const [104, 90, 255],
      this.rgbEnd = const [105, 165, 255],
      this.textColor = '#FFF',
      this.disabled = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: G.setWidth(width),
      height: G.setHeight(height),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(G.setHeight(height / 4)),
          gradient: LinearGradient(
              colors: [_rgbColor(rgbStart), _rgbColor(rgbEnd)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: shadown),
      child: FlatButton(
        child: Text(text,
            style: TextStyle(color: hex(textColor), fontSize: G.setSp(fs))),
        onPressed: disabled ? null : fn,
      ),
    );
  }

  Color _rgbColor(List<int> rgb) {
    return rgba(rgb[0], rgb[1], rgb[2], disabled ? .3 : 1);
  }
}
