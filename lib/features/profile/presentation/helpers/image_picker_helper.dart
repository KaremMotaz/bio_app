import 'dart:io';
import 'package:bio_app/features/profile/presentation/manager/cubit/change_profile_image_cubit.dart';
import 'package:image_picker/image_picker.dart';

Future<void>  pickImageFromGallery({required ChangeProfileImageCubit cubit}) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    cubit.selectImage(image: File(pickedImage.path), avatarPath: null);
  }
}
