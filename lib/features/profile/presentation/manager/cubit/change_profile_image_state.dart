part of 'change_profile_image_cubit.dart';

sealed class ChangeProfileImageState extends Equatable {
  const ChangeProfileImageState();

  @override
  List<Object> get props => [];
}

final class ChangeProfileImageInitialState
    extends ChangeProfileImageState {}

final class ChangeProfileImageLoadingState
    extends ChangeProfileImageState {}
final class ChangeProfileImageSelectedState
    extends ChangeProfileImageState {
        final File? selectedImage;
  final String selectedAvatarPath;
  const ChangeProfileImageSelectedState({
    required this.selectedImage,
    required this.selectedAvatarPath,
  });
}

final class ChangeProfileImageSuccessState
    extends ChangeProfileImageState {}

final class ChangeProfileImageErrorState
    extends ChangeProfileImageState {
  final String error;

  const ChangeProfileImageErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
