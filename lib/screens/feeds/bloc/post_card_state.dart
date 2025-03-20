import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final bool isLiked;
  final bool isSaved;
  final String? message;

  const PostState({
    required this.isLiked,
    required this.isSaved,
    this.message,
  });

  PostState copyWith({
    bool? isLiked,
    bool? isSaved,
    String? message,
  }) {
    return PostState(
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      message: message,
    );
  }

  @override
  List<Object?> get props => [isLiked, isSaved, message];
}
