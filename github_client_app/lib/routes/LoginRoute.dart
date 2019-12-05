import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';

class LoginRoute extends StatefulWidget {
  
  _LoginRoute createState =>  _LoginRoute();
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
              TextFormField(),
              TextFormField(),
              Padding(
                padding: const EdgeInsets.only(top:25),
                child:  ConstrainedBox(
                  child: RaisedButton(
                    
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

  }
}