import 'package:api_crud/edit_post.dart';
import 'package:api_crud/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostsDetails extends StatelessWidget {
  PostsDetails(this.itemId, {super.key}) {
    _futurePost = HttpHelper().getItem(itemId);
  }

  String itemId;
  late Future<Map> _futurePost;
  late Map post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EditPost(post)));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                bool deleted = await HttpHelper().deleteItem(itemId);
                if (deleted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Post Deleted')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete')));
                }
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: FutureBuilder<Map>(
          future: _futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Some error occurred ${snapshot.error}');
            }
            if (snapshot.hasData) {
              post = snapshot.data!;

              return Column(
                children: [
                  Text(
                    '${post['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${post['body']}'),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
