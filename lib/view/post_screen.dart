import 'package:brieftest/viewmodel/post_viewmodel.dart';
import 'package:redacted/redacted.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(builder: (context, value, child) {
      final isLoading = value.state == PostState.loading;
      if (isLoading) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) {
            return PostTile(
                    name: 'name name',
                    body:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book")
                .redacted(context: context, redact: true);
          },
        );
      } else {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: value.posts.length,
          itemBuilder: (context, index) {
            final post = value.posts.elementAt(index);

            return PostTile(name: post.name, body: post.body);
          },
        );
      }
    });
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.name,
    required this.body,
  });
  final String name;
  final String body;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: TextStyle(fontSize: 16),
                ).hide,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    body,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
