import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/feeds/bloc/post_card_bloc.dart';
import 'package:bw_project/screens/feeds/bloc/post_card_event.dart';
import 'package:bw_project/screens/feeds/bloc/post_card_state.dart';
import 'package:bw_project/screens/feeds/model/model_feed.dart';
import 'package:bw_project/screens/feeds/widgets/custom_image.dart';
import 'package:bw_project/screens/feeds/widgets/post_description.dart';
import 'package:bw_project/screens/feeds/widgets/post_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final Function() onLikePressed;
  final Function() onSavePressed;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLikePressed,
    required this.onSavePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        postId: post.id,
        initialLikedState: post.isLiked,
        initialSavedState: post.isSaved,
      )..add(LoadPostPreferences(
          postId: post.id,
          initialLikedState: post.isLiked,
          initialSavedState: post.isSaved,
        )),
      child: BlocConsumer<PostBloc, PostState>(
        listenWhen: (previous, current) => previous.message != current.message && current.message != null,
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                custom_image(post: post),
                
                PostTitle(post: post),
                
                Description(post: post),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          state.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: state.isLiked ? AppColors.red : AppColors.grey,
                        ),
                        onPressed: () {
                          context.read<PostBloc>().add(LikeToggled(post.id));
                          onLikePressed();
                        },
                      ),
                      
                      IconButton(
                        icon: Icon(
                          state.isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: state.isSaved ? AppColors.blue : AppColors.grey,
                        ),
                        onPressed: () {
                          context.read<PostBloc>().add(SaveToggled(post.id));
                          onSavePressed();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


