import 'package:flutter/material.dart';
/*
test内容：
搭建最简单的界面
了解main.dart结构，其中的类和其用法。
主页面结构。ui生命周期。
Widget 、 state、
build()方法
state 中的setState()方法
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }

}

class _MyHomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("标题"),
      ),
    );
  }
}

