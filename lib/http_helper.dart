import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  // fetching from Api
  Future<List<Map>> fetchItems() async {
    List<Map> items = [];
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();
    }
    // Get the data from the Api
    return items;
  }

  // fetch details of one item
  Future<Map> getItem(itemId) async {
    Map item = {};

    http.Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));
    if (response.statusCode == 200) {
      String jsonString = response.body;
      item = jsonDecode(jsonString);
    }

    // Get the item from Api

    return item;
  }

  // Add item to Api
  Future<bool> addItem(Map data) async {
    bool status = false;

    http.Response response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    // Add the item from Api

    return status;
  }

  // Update one item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    http.Response response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    // update the item,call from Api

    return status;
  }

  // Delete one item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    http.Response response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));
    if (response.statusCode == 200) {
      status = true;
    }
    // delete the item from Databse

    return status;
  }
}
