import 'package:flutter/material.dart';
import 'package:flutter_rest_api/CardView/PostCard.dart';
import 'package:flutter_rest_api/Class/Post.dart';
import 'package:flutter_rest_api/Class/User.dart';
import 'package:flutter_rest_api/Page/FormPostPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<AnimatedListState> key = GlobalKey();
  User user = User();
  var data;


  @override
  void initState() {
    getProfile();
    getListPost();
  }

  getProfile() async{
    var user = await User().getUser(1);

      if (user != null && user is !Widget) {
        setState(() {
          this.user = user;
        });
      }

  }

  getListPost() async{
    var data = await Post().getPost();
    if(mounted) {
      setState(() {
        this.data = data;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
            //   currentAccountPicture: Container(
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: NetworkImage(this.user.image, scale: 1.0)
            //       )
            //     ),
            //   ),
              accountName: Text('nombres: ${this.user.name}'),
              accountEmail: Text('email: ${this.user.email}')
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (data is Widget)
              ? data
              : (data != null)
                ? loadListView()
                : LinearProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        onPressed: newPost,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  newPost() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormPostPage(voidCallBackParams: insertPost, user: user,)));
  }

  insertPost(post) {
    this.data.insert(this.data.length, post);
    this.key.currentState?.insertItem(this.data.length-1);
  }

  loadListView() {
    return AnimatedList(
      key: key,
      initialItemCount: data.length,
      shrinkWrap: false,
      itemBuilder: (context, index, animation) {
        return PostCard(this.data[index], this.user);
      }
    );
  }

}
