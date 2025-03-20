import 'package:bw_project/screens/feeds/bloc/post_card_event.dart';
import 'package:bw_project/screens/feeds/bloc/post_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final String postId;

  PostBloc({required this.postId, required bool initialLikedState, required bool initialSavedState})
      : super(PostState(isLiked: initialLikedState, isSaved: initialSavedState)) {
    on<LoadPostPreferences>(_onLoadPostPreferences);
    on<LikeToggled>(_onLikeToggled);
    on<SaveToggled>(_onSaveToggled);
  }

  Future<void> _onLoadPostPreferences(
    LoadPostPreferences event,
    Emitter<PostState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final isLiked = prefs.getBool('post_liked_${event.postId}') ?? event.initialLikedState;
    final isSaved = prefs.getBool('post_saved_${event.postId}') ?? event.initialSavedState;

    emit(PostState(isLiked: isLiked, isSaved: isSaved));
  }

  Future<void> _onLikeToggled(
    LikeToggled event,
    Emitter<PostState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final newLikedState = !state.isLiked;
    
    await prefs.setBool('post_liked_${event.postId}', newLikedState);
    
    emit(state.copyWith(
      isLiked: newLikedState,
      message: newLikedState ? "Post liked" : "Like removed"
    ));
  }

  Future<void> _onSaveToggled(
    SaveToggled event,
    Emitter<PostState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final newSavedState = !state.isSaved;
    
    await prefs.setBool('post_saved_${event.postId}', newSavedState);
    
    emit(state.copyWith(
      isSaved: newSavedState,
      message: newSavedState ? "Post saved" : "Post unsaved"
    ));
  }
}
