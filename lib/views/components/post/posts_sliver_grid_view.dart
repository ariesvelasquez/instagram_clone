import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/post/post_thumbnail_view.dart';

import '../../../state/posts/models/post.dart';
import '../../post_details/post_details_view.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsSliverGridView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final post = posts.elementAt(index);
          return PostThumbnailView(
            post: post,
            onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailsView(
                    post: post,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
