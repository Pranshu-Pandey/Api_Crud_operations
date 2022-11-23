import 'package:api_crud/http_helper.dart';
import 'package:api_crud/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Map>> _futurePosts = HttpHelper().fetchItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Api Crud'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map thisItem = posts[index];
                  return ListTile(
                      title: Text('${thisItem['title']}'),
                      subtitle: Text(
                        '${thisItem['body']}',
                        maxLines: 2,
                      ),
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PostsDetails(thisItem['id'].toString())));
                      }));
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
