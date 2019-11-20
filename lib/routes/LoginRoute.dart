import 'package:flutter/material.dart';
import 'package:flutter_github_app/common/GitApi.dart';
import 'package:flutter_github_app/common/Global.dart';
import 'package:flutter_github_app/common/funs.dart';
import 'package:flutter_github_app/i10n/localization_intl.dart';
import 'package:flutter_github_app/models/User.dart';
import 'package:flutter_github_app/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null && _unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: gm.userName,
                  hintText: gm.userName,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (u) {
                  return u.trim().isNotEmpty ? null : gm.userNameRequired;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                  labelText: gm.password,
                  hintText: gm.password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      }),
                ),
                obscureText: !pwdShow,
                validator: (p) {
                  return p.trim().isNotEmpty ? null : gm.passwordRequired;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    onPressed: _onLogin,
                    child: Text(gm.login),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        user = await Git(context)
            .login(_unameController.text, _pwdController.text);
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          showToast(e.toString());
        }
      } finally {
        Navigator.pop(context);
      }
      if (user != null) {
        Navigator.pop(context);
      }
    }
  }
}
