import 'package:api_crud/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

class EditPost extends StatefulWidget {
  EditPost(this.posts, {super.key});
  Map posts;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerTitle.text = widget.posts['title'];
    _controllerBody.text = widget.posts['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              controller: _controllerTitle,
            ),
            TextFormField(
              controller: _controllerBody,
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, String> dataToUpdate = {
                    'title': _controllerTitle.text,
                    'body': _controllerBody.text,
                  };
                  bool status = await HttpHelper()
                      .updateItem(dataToUpdate, widget.posts['id'].toString());
                  if (status) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Posts updated')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update')));
                  }
                },
                child: Text('Submit')),
          ],
        )),
      ),
    );
  }
}
