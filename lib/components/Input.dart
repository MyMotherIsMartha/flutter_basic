import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/global.dart';
import 'Icon.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final Function validator;
  final Function onChange;
  final Widget suffix;
  final TextInputType type;
  final int maxLength;
  final Widget suffixIcon;
  final String value;
  final bool readOnly;
  final bool suffixDivider;
  final Function onTap;
  final double labelWidth;
  final double suffixWidth;
  final WhitelistingTextInputFormatter inputFormatters;
  final MainAxisAlignment fontSize;
  final FocusNode focus;
  final double lineHeight;
  final Color textColor;
  Input(
      {@required this.controller,
      @required this.hintText,
      this.type,
      this.fontSize,
      this.label,
      this.validator,
      this.onChange,
      this.suffix,
      this.suffixIcon,
      this.maxLength,
      this.readOnly,
      this.onTap,
      this.labelWidth,
      this.suffixWidth,
      this.suffixDivider,
      this.inputFormatters,
      this.focus,
      this.lineHeight,
      this.textColor,
      this.value});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _hasdeleteIcon = false;
  FocusNode _focus = FocusNode();
  FocusNode _focusReadonly = FocusNode();
  @override
  void initState() {
    super.initState();
    setState(() {
      _focus = widget.focus == null ? FocusNode() : widget.focus;
    });
    _focus.addListener(() {
      if (!_focus.hasFocus) {
        setState(() {
          _hasdeleteIcon = false;
        });
      } else {
        setState(() {
          _hasdeleteIcon = widget.controller.text != null &&
              widget.controller.text.isNotEmpty;
        });
      }
    });
    if (widget.value != null && widget.value.isNotEmpty) {
      widget.controller.value = TextEditingValue(text: widget.value);
    }
  }

  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: hex('#eee'), width: G.setWidth(1)))),
        padding: EdgeInsets.symmetric(horizontal: G.setWidth(30)),
        child: TextFormField(
            textAlign: TextAlign.end,
            inputFormatters: widget.inputFormatters != null
                ? [widget.inputFormatters]
                : null,
            style: TextStyle(
                height: widget.lineHeight ?? 1.6,
                fontSize: widget.fontSize ?? G.setSp(30),
                color: widget.textColor != null
                    ? widget.textColor
                    : widget.readOnly ?? false ? hex('#999') : hex('#333')),
            keyboardType: widget.type,
            controller: widget.controller,
            focusNode: widget.readOnly != null ? _focusReadonly : _focus,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
            },
            maxLength: widget.maxLength,
            buildCounter: (context,
                {currentLength = 10, maxLength = 10, isFocused = false}) {
              return null;
            },
            readOnly: widget.readOnly ?? false,
            obscureText: widget.type == TextInputType.visiblePassword,
            decoration: InputDecoration(
                suffixIcon: Container(
                    width: widget.suffix != null
                        ? G.setWidth(widget.suffixWidth ?? 140)
                        : G.setWidth(widget.suffixWidth ?? 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        widget.suffixIcon != null
                            ? widget.suffixIcon
                            : _hasdeleteIcon
                                ? IconButton(
                                    icon: iconclose(color: hex('#999')),
                                    onPressed: () {
                                      clearText(widget.controller);
                                      widget.onChange(null);
                                    },
                                  )
                                : SizedBox(width: 0),
                        Container(
                          height: G.setWidth(36),
                          decoration: BoxDecoration(
                              border: widget.suffixDivider ?? false
                                  ? Border(
                                      left: BorderSide(
                                          color: hex('#CCC'),
                                          width: G.setWidth(1)))
                                  : Border()),
                        ),
                        widget.suffix != null
                            ? widget.suffix
                            : SizedBox(width: 0)
                      ],
                    )),
                border: InputBorder.none,
                hintText: widget.hintText,
                prefixIcon: Container(
                  alignment: Alignment.centerLeft,
                  width: widget.labelWidth ?? G.setWidth(160),
                  child: Text(
                    widget.label,
                    style: TextStyle(fontSize: G.setSp(30), color: hex('#666')),
                  ),
                )),
            onChanged: (str) {
              String newStr = str;
              if (widget.maxLength != null) {
                if (str.length <= widget.maxLength) {
                  widget.onChange(newStr);
                }
              } else {
                widget.onChange(newStr);
              }

              setState(() {
                _hasdeleteIcon = (str.isNotEmpty);
              });
            },
            validator: widget.validator));
  }

  void clearText(_controller) {
    setState(() {
      _hasdeleteIcon = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.clear());
  }
}
