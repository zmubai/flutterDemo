import 'package:flutter/material.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/widgets/RepoItem.dart';
import 'package:provider/provider.dart';
import 'package:github_client_app/widgets/MyDrawer.dart';
import 'package:flukit/flukit.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: ThemeModel()),
          ChangeNotifierProvider.value(value: UserModel()),
          ChangeNotifierProvider.value(value: LocalModel()),
        ],
        child: Consumer2<ThemeMode, LocalModel>(
          builder: (BuildContext context, themeModel, localModel, Widget child){
            return MaterialApp(
              theme: ThemeData(
                // primarySwatch: themeModel.theme,
              ),
              onGenerateTitle: (context){
                //return GmLocalizations.of(context).title;
                return "国际化名称";
              },
              home: HomeRoute(),
              locale: localModel.getLocal(),
              supportedLocales: [
                const Locale("en", "US"),
                const Locale("zh", "CN"),
              ],
              localizationsDelegates: [
                // GlobalMaterialLocalizations.delegate,
                // GlobalMaterialLocalizations.delegate,
                // GmLocalizationsDelegate()
              ],
              localeResolutionCallback: (Locale _locale, Iterable<Locale> supportedLocales){
                if (localModel.getLocal() != null) {
                  return localModel.getLocal();
                } else {
                  Locale locale;
                  if (supportedLocales.contains(_locale)) {
                    locale = _locale;
                  }
                  else{
                    locale = Locale("en","US");
                  }
                  return locale;
                }
              },
              routes: <String,WidgetBuilder>{
                // "login" (context) => LoginRoute(),
                // "themes" (context) => ThemeChangeRoute(),
                // "language" (context) => LanguageRoute(),
              },
            );
          },
        ),
    );
  }
}

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: _buildBody(), // 构建主页面
      drawer: MyDrawer(), //抽屉菜单
    );
  }
  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.login) {
      //用户未登录，显示登录按钮
      return Center(
        child: RaisedButton(
          child: Text("login"),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      //已登录，则展示项目列表
      return InfiniteListView<Repo>(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async {
          var data = await Git(context).getRepos(
            refresh: refresh,
            queryParameters: {
              'page': page,
              'page_size': 20,
            },
          );
          //把请求到的新数据添加到items中
          items.addAll(data); 
          // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
          return data.length==20;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          // 项目信息列表项
          return RepoItem(list[index]);
        },
      );
    }
  }
}