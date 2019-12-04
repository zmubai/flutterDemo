

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/models/repo.dart';
import 'package:provider/provider.dart';
import 'package:flukit/flukit.dart';
import 'package:github_client_app/widgets/RepoItem.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeRouteState();
  }
}

 class _HomeRouteState  extends State<HomeRoute> {

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
 }

 Widget _buildBody () {
   UserModel userModel = Provider.of<UserModel>(context);
   if (!userModel.login){
     return Center(
       child: RaisedButton(
         child: Text("login"),
         onPressed: ()=> Navigator.of(context).pushNamed("login"),
       ),
     );
   }
   else {
     // had login 
     return InfiniteListView<Repo>(
       onRetrieveData: (int page, List<Repo> items, bool refresh) async{
          var data = await Git(context).getRepos(
            refresh: refresh,
            queryParameters: {
              "page":page,
              "page_size" : 20,
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
}