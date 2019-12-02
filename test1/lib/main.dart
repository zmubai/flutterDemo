import 'package:flutter/material.dart';

/*
test1内容：
1.布局一些界面的元素。了解通过代码布局元素的基本方式。
2.进行界面的更新，了解通过代码更新界面的基本方式。
3.界面更新过程中，类直接的交互过程。
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(title: "主页"));
  }
}

class HomePage extends StatefulWidget {
  //构造函数，调用super
  HomePage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
  //定义变量，外部可访问
  final String title;
}

class _MyHomePageState extends State<HomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        /*每个state都有与之对应的widget实例，此widget 为HomePage实例。
        也就是说能通过widget来访问StatefulWidget实例。
        */
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: RaisedButton(
              child: Text("count,$count"),
              onPressed: (){
                setState(() {
                  ++count;
                });
              //  Scaffold.of(context).showSnackBar(SnackBar(content: Text('have a snack!'),)) ;
              },
            ),
          );
        },
      ),
    );
  }
}
