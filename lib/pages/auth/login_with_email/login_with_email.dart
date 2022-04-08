import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:urban_home/pages/auth/register_module/controller/register_controller.dart';
import '../../../constant/constant.dart';
import '../../screens.dart';

class LoginWithEmail extends GetView<RegisterController> {
  RegisterController controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 30.0),
              Text(
                'Welcome\n Back.',
                style: grey14BoldTextStyle,
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextField(
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
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Obx(() => TextField(
                      style: black14MediumTextStyle,
                      keyboardType: TextInputType.text,
                      obscureText: controller.isPasswordObscure.value,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(left: 20.0),
                        hintText: 'Password',
                        hintStyle: black14MediumTextStyle,
                        //border: InputBorder.none,
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.isPasswordObscure(
                                !controller.isPasswordObscure.value);
                          },
                          child: Icon(controller.isPasswordObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    )),
              ),
              height20Space,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: BottomBar(),
                      ),
                    );
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
              Text(
                'OR',
                style: grey20BoldTextStyle,
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
              Text.rich(TextSpan(children: [
                TextSpan(text: "New User? ", style: black12MediumTextStyle),
                TextSpan(
                    text: "Sign Up",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => Register());
                      },
                    style: primary14MediumTextStyle)
              ])),
              height20Space,
            ],
          ),
        ],
      ),
    );
  }
}
