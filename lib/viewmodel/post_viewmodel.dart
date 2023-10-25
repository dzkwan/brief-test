import 'package:brieftest/service/post_service.dart';
import 'package:brieftest/service/user_service.dart';
import 'package:brieftest/model/post_model.dart';
import 'package:flutter/material.dart';

enum PostState { none, loading }

class PostViewModel with ChangeNotifier {
  List posts = [];
  PostState state = PostState.none;

  Future getAllPost() async {
    state = PostState.loading;
    final response = await PostService().getAll();
    for (var i = 0; i < response.length; i++) {
      final responseUser =
          await UserService().getUserById(response[i]['userId']);

      response[i]['name'] = responseUser.name;
    }
    posts = (response)
        .map(
          (e) => Post(
            id: e['id'],
            userId: e['userId'],
            name: e['name'],
            title: e['title'],
            body: e['body'],
          ),
        )
        .toList();

    notifyListeners();
    changeState(PostState.none);
  }

  changeState(PostState s) {
    state = s;
    notifyListeners();
  }
}
