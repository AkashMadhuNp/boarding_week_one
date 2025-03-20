class Post {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isLiked = false,
    this.isSaved = false,
  });
}