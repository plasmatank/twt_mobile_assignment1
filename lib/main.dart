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

  void initState() {
      super.initState();
      SealedFresh.add(Refresh);
      /*
      _MyHomePageState.scrollController.addListener(() async 
      { 
        if(scrollController.position.pixels>scrollController.position.maxScrollExtent-40)
        {
          current_page++;
          postList = await FeedbackService.getPosts(page:current_page); Refresh();
        }
      });
      */
  }

  void Refresh() {
    setState((() {
      print(postList[0].title);
    }));
  }

  Future<void> OnRefresh() async
  {
    print("Refreshing...");
    postList = await FeedbackService.getPosts(page:current_page); 
    Refresh();
  }

  int length = 10;

  static int current_page = 1;
  
  static List<Post> postList = [];

  static ScrollController scrollController = new ScrollController();

  static List<Function> SealedFresh = [];
  @override
    Widget build(BuildContext context) {
        return Container(
            child:Scaffold(
                appBar: AppBar(
                    title:Text("DemoBBS"),
                    actions: <Widget>[
                          new IconButton(
                          icon: new Icon(Icons.arrow_back),
                          tooltip: 'Go Back',
                          onPressed: () async {if (current_page > 1) {current_page--; _MyHomePageState.postList = await FeedbackService.getPosts(page:current_page); Refresh();}}),
                          new IconButton(
                          icon: new Icon(Icons.arrow_forward),
                          tooltip: 'Go Forward',
                          onPressed: () async {current_page++; _MyHomePageState.postList = await FeedbackService.getPosts(page:current_page); Refresh();}),
                          ],
                ),
                body:
                RefreshIndicator(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: length,
                        itemBuilder: (context,index){
                            Widget tip = Text("");
                            if(index == length-1){
                                tip = Text("没有更多了");
                            } 
                            return Column(
                                children: <Widget>[
                                    PostCard(postList[index]),
                                    Divider(thickness: 1, height: 2,),
                                    tip
                                ],
                            );
                        },   
                    ), 
                    onRefresh:OnRefresh
                )
            )
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

    /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DemoBBS"),),
      body: SafeArea(
        child: ListView(
          children: <Widget>[            
            FutureBuilder
            (
              future: FeedbackService.getTokenByPassword(),
              builder: (BuildContext context, AsyncSnapshot<String> data) {
                SealedFresh.length == 0 ? SealedFresh.add(Refresh) : (){};
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
            onPressed: () async {postList = await FeedbackService.getPosts(); Refresh(); }),       
            ...List.generate(length, (index) => PostCard(postList[index]))
          ],
        ),
      ),
    );
  }
}
*/