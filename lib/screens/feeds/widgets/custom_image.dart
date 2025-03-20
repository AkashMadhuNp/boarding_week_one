import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/feeds/model/model_feed.dart';
import 'package:flutter/material.dart';

class custom_image extends StatelessWidget {
  const custom_image({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      child: Image.network(
        post.imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 200,
            width: double.infinity,
            color: AppColors.grey,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: AppColors.grey,
            child: const Center(
              child: Icon(Icons.error, size: 40),
            ),
          );
        },
      ),
    );
  }
}
