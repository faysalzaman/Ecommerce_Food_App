// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/ImageBloc/Image_States_Events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  Future imagePermission() async {
    await Permission.photos.onDeniedCallback(() {
      debugPrint("Permission Denied");
    }).onGrantedCallback(() {
      debugPrint("Permission Granted");
    }).onPermanentlyDeniedCallback(() {
      debugPrint("Permission Permanently Denied");
    }).onRestrictedCallback(() {
      debugPrint("Permission Restricted");
    }).onLimitedCallback(() {
      debugPrint("Permission Limited");
    }).onProvisionalCallback(() {
      debugPrint("Permission Provisional");
    }).request();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  ImageBloc() : super(ImageInitialState()) {
    on<ImageLoadEvent>(
      (event, emit) async {
        emit(ImageLoadingState());
        try {
          await imagePermission();
          await imagePermission();
          _imageFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          emit(ImageSuccessState(imageUrl: _imageFile!));
          emit(ImageSuccessState(imageUrl: _imageFile!));
        } catch (e) {
          emit(
            ImageErrorState(error: e.toString().replaceAll("Exception:", "")),
          );
        }
      },
    );
  }
}
