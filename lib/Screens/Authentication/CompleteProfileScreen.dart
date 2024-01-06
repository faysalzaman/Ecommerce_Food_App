// ignore_for_file: file_names

import 'dart:io';

import 'package:food_ecommerce_app/Bloc/Complete_Profile/Complete_Profile_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/Complete_Profile/Complete_Profile_States_Events.dart';
import 'package:food_ecommerce_app/Screens/TabsScreen/TabsScreen.dart';
import 'package:food_ecommerce_app/Utils/Global/AppLoading.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:food_ecommerce_app/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  // image permission
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

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

  CompleteProfileBloc? completeProfileBloc = CompleteProfileBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width(),
        height: context.height(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await imagePermission();
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    setState(() {
                      _imageFile = image;
                    });
                  },
                  child: Container(
                    width: context.width() * 0.6,
                    height: context.height() * 0.3,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.image,
                            size: 150,
                            color: Colors.white,
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      TextFieldWidget(
                        text: "Full Name",
                        hint: "Enter full name",
                        obscureText: false,
                        controller: fullNameController,
                      ),
                      TextFieldWidget(
                        text: "Phone No",
                        hint: "Enter phone no",
                        obscureText: false,
                        controller: phoneNoController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                BlocListener<CompleteProfileBloc, CompleteProfileState>(
                  bloc: completeProfileBloc,
                  listener: (context, state) {
                    if (state is CompleteProfileLoadingState) {
                      AppLoading(context);
                    } else if (state is CompleteProfileSuccessState) {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const TabsScreen(),
                        ),
                      );
                    } else if (state is CompleteProfileFailureState) {
                      Navigator.pop(context);
                      toast(state.error);
                    }
                  },
                  child: ButtonWidget(
                    text: "Finish Profile Setup",
                    onPressed: () {
                      if (_imageFile == null &&
                          fullNameController.text.isEmpty &&
                          phoneNoController.text.isEmpty) {
                        FocusScope.of(context).unfocus();
                        return;
                      }
                      if (_imageFile == null ||
                          fullNameController.text.isEmpty ||
                          phoneNoController.text.isEmpty) {
                        toast("Please select image and fill all the fields");
                        return;
                      }
                      completeProfileBloc!.add(
                        CompleteProfileButtonClickEvent(
                          fullName: fullNameController.text,
                          phoneNo: phoneNoController.text,
                          image: _imageFile!,
                        ),
                      );
                    },
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
