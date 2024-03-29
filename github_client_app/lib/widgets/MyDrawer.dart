import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/GmLocalizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //移除顶部padding
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(), //构建抽屉菜单头部
            Expanded(child: _buildMenus()), //构建功能菜单
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                    child: value.login
                        ? gmAvatar(value.user.avatar_url, width: 80)
                        : Image.asset(
                            "imgs/avatar-default.png",
                            width: 80,
                          ),
                  ),
                ),
                Text(
                  "xxxx",
                  // value.login
                  //     ? value.user.login
                  //     : GmLocalizations.of(context).login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.login) Navigator.of(context).pushNamed("login");
          },
        );
      },
    );
  }

  // 构建菜单项
  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        var gm = "gm";
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              // title: Text(gm.theme),
              title: Text(""),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              // title: Text(gm.language),
              title: Text(""),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
            if (userModel.login)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                // title: Text(gm.logout),
                title: Text(""),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      //退出账号前先弹二次确认窗
                      return AlertDialog(
                        // content: Text(gm.logoutTip),
                        content: Text("xx"),
                        actions: <Widget>[
                          FlatButton(
                            // child: Text(gm.cancel),
                            child: Text("gm.cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            // child: Text(gm.yes),
                            child: Text("gm.yes"),
                            onPressed: () {
                              //该赋值语句会触发MaterialApp rebuild
                              userModel.user = null;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Widget gmAvatar(
    String url, {
    double width = 30,
    double height,
    BoxFit fit,
    BorderRadius borderRadius,
  }) {
    var placeholder = Image.asset("imgs/avatar-default.png", //头像占位图，加载过程中显示
        width: width,
        height: height);
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  }
}
