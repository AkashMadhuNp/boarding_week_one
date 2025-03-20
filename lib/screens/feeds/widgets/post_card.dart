import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/feeds/model/model_feed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post, required void Function() onLikePressed, required void Function() onSavePressed,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.isLiked;
    isSaved = widget.post.isSaved;
    _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool('post_liked_${widget.post.id}') ?? widget.post.isLiked;
      isSaved = prefs.getBool('post_saved_${widget.post.id}') ?? widget.post.isSaved;
    });
  }

  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    final newLikedState = !isLiked;
    
    await prefs.setBool('post_liked_${widget.post.id}', newLikedState);
    
    setState(() {
      isLiked = newLikedState;
    });
    
    _showMessage(
      context, 
      newLikedState ? "Post liked" : "Like removed"
    );
  }


Future<void> _toggleSave()async{
  final prefs = await SharedPreferences.getInstance();
  final newSavedState = !isSaved;
  await prefs.setBool('post_saved_${widget.post.id}', newSavedState);

  setState(() {
    isSaved = newSavedState;
  });

  _showMessage(
    context,
   newSavedState ? "Post saved" : "Post unsaved"
   );
}
 
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.network(
              widget.post.imageUrl,
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
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              widget.post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Text(
              widget.post.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? AppColors.red : AppColors.grey,
                  ),
                  onPressed: _toggleLike,
                ),
                
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.blue : AppColors.grey,
                  ),
                  onPressed: _toggleSave,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}