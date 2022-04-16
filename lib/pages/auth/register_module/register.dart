import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:urban_home/pages/auth/register_module/controller/register_controller.dart';
import 'package:urban_home/web_services/api_provider.dart';
import '../../../constant/constant.dart';
import '../../screens.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //RegisterController controller = Get.put(RegisterController());
  File _image;
  final picker = ImagePicker();
  final name = TextEditingController();
  final email = TextEditingController();

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {

      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      // setState(() {
      //   _image = null;
      // });
    }
  }

  /// Get image from gallery
  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('picked from gallery');
      setState(() {
        _image = File(pickedFile.path);
      });
      //setState(() {});
    } else {
      // setState(() {
      //   _image = null;
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: blackColor,
                ),
              )
            ],
          ),
          SizedBox(height: 70.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon.png',
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fitWidth,
              ),
              // SizedBox(height: 30.0),
              Text(
                'Register your account',
                style: grey14BoldTextStyle,
              ),
              height20Space,
              Container(
                height: 160.0,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: width - fixPadding * 4.0,
                      alignment: Alignment.center,
                      child: Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70.0),
                            image: _image == null
                                ? DecorationImage(
                                    image: AssetImage(
                                      'assets/dp.jpeg',
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        width: width - fixPadding * 4.0,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () => _selectOptionBottomSheet(context),
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: 140.0,
                            padding: EdgeInsets.symmetric(
                                vertical: fixPadding * 0.6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: primaryColor,
                              border: Border.all(
                                width: 2.0,
                                color: whiteColor,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 16.0,
                                  color: whiteColor,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  'Upload Profile',
                                  style: white12MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: name,
                  style: black14MediumTextStyle,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.only(left: 20.0),
                    hintText: 'Full Name',
                    hintStyle: black14MediumTextStyle,
                    //border: InputBorder.none,
                  ),
                ),
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
                  controller: email,
                  style: black14MediumTextStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.only(left: 20.0),
                    hintText: 'Email',
                    hintStyle: black14MediumTextStyle,
                    //border: InputBorder.none,
                  ),
                ),
              ),
              height20Space,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: InkWell(
                  onTap: () async {
                    if (email.text.isNotEmpty &&
                        name.text.isNotEmpty &&
                        _image != null) {
                      loadingRing(context);
                      final response = await ApiProvider.registerUser(
                          name.text.toString(),
                          email.text.toString(),
                          _image.path.toString());
                      Navigator.pop(context);
                      if (response.statusCode >= 200 &&
                          response.statusCode <= 210) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: BottomBar(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Some error occured try again later',
                            backgroundColor: primaryColor);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Fill all fields and upload profile pic',
                          backgroundColor: primaryColor);
                    }
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Continue',
                      style: white14BoldTextStyle,
                    ),
                  ),
                ),
              ),
              height20Space,
            ],
          ),
        ],
      ),
    );
  }

  void _selectOptionBottomSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Choose Option',
                            textAlign: TextAlign.center,
                            style: black18BoldTextStyle,
                          ),
                        ),
                        heightSpace,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: fixPadding),
                          width: width,
                          height: 1.0,
                          color: greyColor.withOpacity(0.5),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            getCameraImage();
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Camera', style: black14MediumTextStyle),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            getGalleryImage();
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.photo_album,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Upload from Gallery',
                                  style: black14MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
