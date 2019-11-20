import 'package:flutter/material.dart';
import 'package:flutter_github_app/i10n/localization_intl.dart';
import 'package:flutter_github_app/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalizations.of(context);

    Widget _buildLanguageItem(String lan, String value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(
            color: localModel.locale == value ? color : null,
          ),
        ),
        trailing:
            localModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          localModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null),
        ],
      ),
    );
  }
}
