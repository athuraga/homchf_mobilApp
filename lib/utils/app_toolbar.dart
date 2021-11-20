import 'package:flutter/material.dart';

import 'constants.dart';

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  ApplicationToolbar({required this.appbarTitle});
  final String? appbarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(color: Color(Constants.colorAppbarback)),
      elevation: 0.0,
      title: Text(
        appbarTitle!,
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            fontFamily: Constants.appFontBold,
            color: Color(Constants.colorAppbarback)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
