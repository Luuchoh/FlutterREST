import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Class/Post.dart';

class FormPostPage extends StatefulWidget {

  Post post;

  FormPostPage(this.post);

  @override
  State<StatefulWidget> createState() => FormPostPageState(post);

}
class FormPostPageState extends State<FormPostPage> {

  Post post;
  TextEditingController ctrlTitle = TextEditingController();
  TextEditingController ctrlPost = TextEditingController();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  FormPostPageState(this.post);


  @override
  void initState() {
    if(post != null) {
      ctrlTitle.text = post.title!;
      ctrlPost.text = post.body!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text((this.post != null) ? 'Editar Post': 'Nuevo Post'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Column(
      children: [
        formItemDesign(
          Icons.title_rounded,
          TextFormField(
            controller: ctrlTitle,
            decoration: InputDecoration(
              labelText: 'Titulo',
            ),
          ),
        ),
        formItemDesign(
          Icons.textsms_rounded,
          TextFormField(
            controller: ctrlPost,
            decoration: InputDecoration(
              labelText: 'Contenido',
            ),
            minLines: 1,
            maxLines: 6,
            maxLength: 200,
          ),
        ),

        ElevatedButton(
          onPressed: save,
          child: Text(
            'Guardar',
            style: TextStyle(
              color: Colors.greenAccent,
              backgroundColor: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(8.0),
            backgroundColor: Colors.white,
            foregroundColor: Colors.greenAccent
          ),
        ),
      ],
    );
  }

  formItemDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(
        child: ListTile(
          leading: Icon(
            icon
          ),
          title: item,
        ),
      ),
    );
  }

  save() async{
    if(post != null) {
      var data = await Post().update(getText(post).toMap());
      if(data != null) error(data);
    }
  }

  error(data) {
    if(data is Widget) {
      scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: data, backgroundColor: Colors.blue,));
    } else {
      Navigator.of(context).pop();
    }
  }

  Post getText(Post post) {
    post.title = ctrlTitle.text;
    post.body = ctrlPost.text;
    return post;
  }
}