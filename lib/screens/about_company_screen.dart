import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:homchf/utils/SharedPreferenceUtil.dart';
import 'package:homchf/utils/app_toolbar.dart';
import 'package:homchf/utils/constants.dart';
import 'package:homchf/utils/localization/language/languages.dart';

class AboutCompanyScreen extends StatefulWidget {
  @override
  _AboutCompanyScreenState createState() => _AboutCompanyScreenState();
}

class _AboutCompanyScreenState extends State<AboutCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ApplicationToolbar(
          appbarTitle: Languages.of(context)!.labelAboutCompany,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/ic_background_image.png'),
            fit: BoxFit.cover,
          )),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Html(
                              data: SharedPreferenceUtil.getString(
                                  Constants.appAboutCompany)),
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
