part of 'splash_load_bloc.dart';

enum PostStatus {
  initial,
  loading,
  showintro,
  gologin,
  gohome,
  goinformation,
}

class SplashLoadState extends Equatable {
  final PostStatus postStatus;

  const SplashLoadState({
    this.postStatus = PostStatus.initial,
  });

  @override
  List<Object> get props => [postStatus];

  SplashLoadState copyWith({
    String? errorText,
    PostStatus? postStatus,
    bool? alarmStatus,
  }) {
    return SplashLoadState(
      postStatus: postStatus ?? this.postStatus,
    );
  }
}
