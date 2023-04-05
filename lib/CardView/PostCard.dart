import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Page/FormPostPage.dart';

import '../Class/Post.dart';
import '../Class/User.dart';

class PostCard extends StatefulWidget {

  Post post;
  User user;

  PostCard(this.post, this.user);

  @override
  State<StatefulWidget> createState() => PostCardState(post);
}

class PostCardState extends State<PostCard> {

  Post post;
  User userPost = User();

  PostCardState(this.post);


  @override
  void initState() {
    getUserPost();
  }

  getUserPost() async{
    var user = await User().getUser(post.userId);
    if (user != null && user is !Widget) {
      setState(() {
        this.userPost = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => goFormPage(),
      child: Card(
        child: Column(
          children: [
            Text(
              post.title!,
              style: TextStyle(
                fontSize: 27,
              ),
            ),
            Text(
              userPost.name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              post.body!,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }

  goFormPage() {
    if(widget.user.id == userPost.id) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => FormPostPage()));
    }
  }
  
}
