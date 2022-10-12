import 'package:flutter/material.dart';
import 'package:twt_mobile_assignment1/you_can_edit_here/post.dart';
import 'package:twt_mobile_assignment1/you_can_edit_here/post_card.dart';
import 'package:twt_mobile_assignment1/you_can_edit_here/wpy_service.dart';
import 'package:twt_mobile_assignment1/things_you_do_not_need_understand/wpy_storage.dart';
import 'package:twt_mobile_assignment1/things_you_do_not_need_understand/wpy_network.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CommonPreferences.init();
  await NetStatusListener.init();
  await HomePageFunctions.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '一份小作业',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  void Refresh() {
    setState((() {
      postList;
    }));
  }

  int length = 10;
  
  static List<Post> postList = [Post(id:114514,title:"试着刷新一下吧",content:"如题")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Text(
              '\n这就是个示例项目，请打开wpy_service看看吧\n我们最终要实现一个简易版的仅可读的微北洋论坛\n'
              '你需要完整地写好卡片的ui，并补充好网络请求部分，\n最后以合适的方式实现数据的获取\n'
              '遇到困难的时候请尽可能前往工作室寻求帮助\n',
            ),
            FutureBuilder
            (
              future: FeedbackService.getTokenByPassword(),
              builder: (BuildContext context, AsyncSnapshot<String> data) {
                if (data.data != null) {
                  String? str = data.data;
                  return Text("${str}", style: TextStyle(fontSize: 20),);
                }
                else {
                  return Text("遇到困难摆大烂", style: TextStyle(fontSize: 20),);
                }
              }
            ),
            FloatingActionButton(
            child: new Icon(Icons.refresh),
            tooltip: 'Refresh posts.',
            onPressed: () async {postList = await FeedbackService.getPosts(); Refresh();}),       
            ...List.generate(length, (index) => PostCard(postList[index]))
          ],
        ),
      ),
    );
  }
}

class HomePageFunctions
{
  static init() async
  {
    _MyHomePageState.postList = await FeedbackService.getPosts();
  }
}
