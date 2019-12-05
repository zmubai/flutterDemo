import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/models/repo.dart';
import 'package:provider/provider.dart';
import 'package:flukit/flukit.dart';
import 'package:github_client_app/widgets/RepoItem.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: _buildBody(),
      // drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.login) {
      return Center(
        child: RaisedButton(
          child: Text("login"),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      // had login
      return InfiniteListView<Repo>(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async {
          var data = await Git(context).getRepos(
            refresh: refresh,
            queryParameters: {
              "page": page,
              "page_size": 20,
            },
          );
          items.addAll(data);
          return data.length == 20;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          return RepoItem(list[index]);
        },
      );
    }
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
