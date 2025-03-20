import 'package:equatable/equatable.dart';


abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LikeToggled extends PostEvent {
  final String postId;
  const LikeToggled(this.postId);

  @override
  List<Object> get props => [postId];
}

class SaveToggled extends PostEvent {
  final String postId;
  const SaveToggled(this.postId);

  @override
  List<Object> get props => [postId];
}

class LoadPostPreferences extends PostEvent {
  final String postId;
  final bool initialLikedState;
  final bool initialSavedState;

  const LoadPostPreferences({
    required this.postId,
    required this.initialLikedState,
    required this.initialSavedState,
  });

  @override
  List<Object> get props => [postId, initialLikedState, initialSavedState];
}
