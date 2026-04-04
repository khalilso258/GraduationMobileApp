import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syriatel/view/register.dart';

import '../bindings/register_binding.dart';
import '../controllers/login_controller.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';
import '../widgets/background_blur.dart';
import '../widgets/bottons.dart';
import '../widgets/circle.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/image_container.dart';

class Login extends GetView<LoginController> {
  final TextInputType? inputType;
  final int? maxLines;
  Login({Key? key, this.inputType, this.maxLines});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SizeConfig.init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Obx(() => Stack(
        children: [
          Form(
            key: controller.loginKey,
            child: Stack(
              children: [

                CircleWidget(
                  diameter: 227.66,
                  color: Color(0xFFF34B1B),
                  xPosition: -45.76,
                  yPosition: -36.37,
                ),
                CircleWidget(
                  diameter: 183.04,
                  color: Color(0xFFF34B1B),
                  xPosition: 180.75,
                  yPosition: 777.5,
                ),
                CircleWidget(
                  diameter: 264.85,
                  color: Color(0xFF1C8B3B),
                  xPosition: -70.93,
                  yPosition: 447.86,
                ),
                CircleWidget(
                  diameter: 400.08,
                  color: AppColors.secondaryColor,
                  xPosition: 231.09,
                  yPosition: 703.62,
                ),
                const BackgroundBlurWithRadialGradient(
                  opacity: 0.74,
                  color: Colors.white,
                ),

                // اللوجو
                Positioned(
                  left: SizeConfig.scaleWidth(43),
                  top: SizeConfig.scaleHeight(54),
                  child: MyImage(
                    imagePath: 'assets/images/image 2.png',
                    width: 342.07,
                    height: 130,
                  ),
                ),

                // العنوان
                Positioned(
                  left: SizeConfig.scaleWidth(156),
                  top: SizeConfig.scaleHeight(202),
                  child: Center(
                    child: Container(
                      width: SizeConfig.scaleWidth(120),
                      height: SizeConfig.scaleHeight(45),
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'ProtestStrike',
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' in',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                Positioned(
                  left: SizeConfig.scaleWidth(50),
                  top: SizeConfig.scaleHeight(293),
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.scaleHeight(16)),

                      CustomTextField(
                        controller: controller.phoneNumController,
                        labelText: 'Phone Number',
                        prefix: Icons.phone,
                        inputType: TextInputType.phone,
                        validator: (value) {
                          return controller.validatePhoneNum(value!);
                        },
                      ),
                      SizedBox(height: SizeConfig.scaleHeight(16)),

                      Obx(() => CustomTextField(
                        maxLines: 1,
                        controller: controller.passwordController,
                        inputType: TextInputType.visiblePassword,
                        labelText: 'Password',
                        prefix: Icons.lock,
                        obscureText: controller.isPassword.value,
                        suffix: controller.isPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        pss: () {
                          controller.changePasswordIcon();
                        },
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                      )),
                      SizedBox(height: SizeConfig.scaleHeight(16)),

                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.scaleWidth(200)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppColors.thirdColor,
                              fontSize: 12,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),

                      SizedBox(height: SizeConfig.scaleHeight(32)),

                      MainButton(
                        text: 'Login',
                        onPressed: () {
                          controller.doLogin();
                        },
                      ),

                      SizedBox(height: SizeConfig.scaleHeight(32)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account? ',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF888888),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF283FB1),
                              ),
                            ),
                            onTap: () {
                              Get.to(() => Register(), binding: RegisterBinding());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          if (controller.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      )),
    );
  }
}
