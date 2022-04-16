import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:urban_home/pages/auth/login_with_email/login_with_email.dart';
import 'package:urban_home/web_services/api_provider.dart';

import '../../constant/constant.dart';
import '../screens.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime currentBackPressTime;
  String phoneNumber = '';
  String phoneIsoCode;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  loadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Please Wait..',
                      style: grey14MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.fade,
                child: Register())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: WillPopScope(
        child: ListView(
          children: [
            SizedBox(height: 100.0),
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
                SizedBox(height: 30.0),
                Text(
                  'Signin with phone number',
                  style: grey14BoldTextStyle,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: blackColor.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: InternationalPhoneNumberInput(
                      textStyle: black14RegularTextStyle,
                      //autoValidate: false,
                      selectorTextStyle: black16MediumTextStyle,
                      initialValue: number,
                      textFieldController: controller,
                      inputBorder: InputBorder.none,
                      inputDecoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(left: 0.0),
                        hintText: 'Phone Number',
                        hintStyle: black14RegularTextStyle,
                        border: InputBorder.none,
                      ),
                      //selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                  ),
                ),
                heightSpace,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () async {
                      if (controller.text.toString().length == 11) {
                        final number =
                            controller.text.toString().removeAllWhitespace;
                        loadingRing(context);
                        final response =
                            await ApiProvider.sendOTP(number.toString());
                        Navigator.pop(context);
                        if (response.statusCode >= 200 &&
                            response.statusCode <= 210) {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: OTPScreen(
                                number: number.toString(),
                              ),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Some error occured try again later');
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Enter correct 10 digit mobile number',
                            backgroundColor: primaryColor,
                            toastLength: Toast.LENGTH_LONG);
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
                heightSpace,
                Text(
                  'We’ll send otp for verification',
                  style: black14MediumTextStyle,
                ),
                height20Space,
                height20Space,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF3B5998),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/facebook.png',
                          width: 37.0,
                          height: 37.0,
                          fit: BoxFit.cover,
                        ),
                        width20Space,
                        Text(
                          'Log in with Facebook',
                          style: white14MediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                height20Space,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          width: 37.0,
                          height: 37.0,
                          fit: BoxFit.cover,
                        ),
                        width20Space,
                        Text(
                          'Log in with Google',
                          style: black14MediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                height20Space,
                // Text.rich(TextSpan(children: [
                //   TextSpan(
                //       text: "Already have an account? ",
                //       style: black12MediumTextStyle),
                //   TextSpan(
                //       text: "Sign In",
                //       recognizer: TapGestureRecognizer()
                //         ..onTap = () {
                //           Get.to(() => LoginWithEmail());
                //         },
                //       style: primary14MediumTextStyle)
                // ])),
                // height20Space,
              ],
            ),
          ],
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            //exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
