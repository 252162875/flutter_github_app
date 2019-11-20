import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_app/common/GitApi.dart';
import 'package:flutter_github_app/common/funs.dart';
import 'package:flutter_github_app/i10n/localization_intl.dart';
import 'package:flutter_github_app/models/Repo.dart';
import 'package:flutter_github_app/states/ProfileChangeNotifier.dart';
import 'package:flutter_github_app/widgets/RepoItem.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed("login");
          },
          child: Text(GmLocalizations.of(context).login),
        ),
      );
    } else {
      return InfiniteListView<Repo>(
          onRetrieveData: (int page, List<Repo> items, bool refresh) async {
        var data = await Git(context).getRepo(
            refresh: refresh, queryParameters: {"page": page, "page_size": 20});
        items.addAll(data);
        return data.length == 20;
      }, itemBuilder: (List list, int index, BuildContext context) {
        return RepoItem(list[index]);
      });
    }
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Expanded(child: _buildMenus()),
            ],
          )),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel value, Widget child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: value.isLogin
                      ? gmAvatar(value.user.avatarUrl, width: 80.0)
                      : Image.asset(
                          "images/avatar-default.png",
                          width: 80.0,
                        ),
                ),
              ),
              Text(
                value.isLogin
                    ? value.user.login
                    : GmLocalizations.of(context).login,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          ),
        ),
        onTap: () {
          if (!value.isLogin) {
            Navigator.of(context).pushNamed("login");
          }
        },
      );
    });
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel value, Widget child) {
      var gm = GmLocalizations.of(context);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(gm.theme),
            onTap: () => Navigator.of(context).pushNamed("themes"),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(gm.language),
            onTap: () => Navigator.of(context).pushNamed("language"),
          ),
          if (value.isLogin)
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text(gm.logout),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(gm.cancel)),
                          FlatButton(
                              onPressed: () {
                                value.user = null;
                                Navigator.pop(context);
                              },
                              child: Text(gm.yes)),
                        ],
                      );
                    });
              },
            ),
        ],
      );
    });
  }
}
