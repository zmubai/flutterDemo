import 'package:flutter/material.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/models/index.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRoute createState() =>  _LoginRoute();

}

class _LoginRoute extends State<LoginRoute> {

  TextEditingController _unameController = new TextEditingController();
    TextEditingController _pwdController = new TextEditingController();

    bool pwdShow = false;

    GlobalKey _formKey = new GlobalKey<FormState>();

    bool _nameAutoFocus = true;

  @override
  void initState() {
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = "login";
    return Scaffold(
      appBar: AppBar(title: Text(gm)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "userName or email",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v){
                  return v.trim().isNotEmpty ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                  labelText: "pwd",
                  hintText: "pwd",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      pwdShow ?Icons.visibility_off : Icons.visibility
                    ),
                    onPressed: (){
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  )
                ),
                obscureText: !pwdShow,
                validator: (v){
                  return v.trim().isNotEmpty ? null : "密码不能为空";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:25),
                child:  ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55),
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        _onLogin();
                      },
                      textColor: Colors.white,
                      child: Text("login"),
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
    if ((_formKey.currentContext as FormState).validate()) {
      // showLoading(context);
      User user;
      try {
        user = await Git(context).login(_unameController.text, _pwdController.text);
        Provider.of<UserModel>(context, listen:false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          //
        }
      } finally {
        Navigator.of(context).pop();
      }
      if (user != null){
        Navigator.of(context).pop();
      }
    }
  }
}