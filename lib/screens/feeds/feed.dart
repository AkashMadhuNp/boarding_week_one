import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/feeds/model/model_feed.dart';
import 'package:bw_project/screens/feeds/widgets/post_card.dart';
import 'package:flutter/material.dart';



class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  
  final List<Post> _posts = [
    Post(
      id: '1',
      imageUrl: 'https://picsum.photos/id/1/500/300',
      title: 'Morning Sunrise',
      description: 'Beautiful sunrise captured at the beach. The colors are amazing!',
    ),
    Post(
      id: '2',
      imageUrl: 'https://picsum.photos/id/10/500/300',
      title: 'Mountain Adventure',
      description: 'Hiking through the mountains was an incredible experience.',
    ),
    Post(
      id: '3',
      imageUrl: 'https://picsum.photos/id/100/500/300',
      title: 'City Lights',
      description: 'The city comes alive at night with all its beautiful lights.',
    ),
    Post(
      id: '4',
      imageUrl: 'https://picsum.photos/id/1000/500/300',
      title: 'Desert Exploration',
      description: 'The vastness of the desert is both intimidating and captivating.',
    ),
    Post(
      id: '5',
      imageUrl: 'https://picsum.photos/id/1001/500/300',
      title: 'Forest Retreat',
      description: 'Finding peace and tranquility in the heart of the forest.',
    ),
  ];

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        _posts[postIndex].isLiked = !_posts[postIndex].isLiked;
      }
    });
  }

  void _toggleSave(String postId) {
    setState(() {
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        _posts[postIndex].isSaved = !_posts[postIndex].isSaved;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.blueWhiteGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Feed",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            final post = _posts[index];
            return PostCard(
              post: post,
              onLikePressed: () => _toggleLike(post.id),
              onSavePressed: () => _toggleSave(post.id),
            );
          },
        ),
      ),
    );
  }
}

