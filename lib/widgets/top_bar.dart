import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  String barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;

  late double _deviceHeigh;
  late double _deviceWidth;
  TopBar(
    this.barTitle, {
    super.key,
    this.primaryAction,
    this.secondaryAction,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    _deviceHeigh = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      height: _deviceHeigh * 0.1,
      width: _deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleBar(),
          if (primaryAction != null) primaryAction!,
          if (secondaryAction != null) secondaryAction!,
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      barTitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize:
            fontSize ??
            24, // if fontSize is null (not set with constructor), use 35
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
