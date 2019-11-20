import 'package:flutter/material.dart';
import 'package:flutter_github_app/common/Global.dart';
import 'package:flutter_github_app/i10n/localization_intl.dart';
import 'package:flutter_github_app/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';

class ThemeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: Container(
                color: e,
                height: 40.0,
              ),
            ),
            onTap: () {
              Provider.of<ThemeModel>(context).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
