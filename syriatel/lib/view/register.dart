import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syriatel/controllers/register_controller.dart';
import 'package:syriatel/view/login.dart';

import 'package:syriatel/widgets/RegisterTextField.dart';
import 'package:syriatel/widgets/custom_text_form_field.dart';
import '../controllers/ctrl.dart';
import '../controllers/drop_down_controller.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';
import '../widgets/bottons.dart';
import '../widgets/custom_drop_down_buttom.dart';
import '../widgets/background_blur.dart';
import '../widgets/circle.dart';
import '../widgets/image_container.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {



  final RegisterController registerController = Get.put(RegisterController());

  final List<String> items = ['Male', 'Female'];



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );



    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Obx(()=>Stack(
        children: [

          CircleWidget(
              diameter: 227.66,
              color: Color(0xFFF34B1B),
              xPosition: -45.76,
              yPosition: -36.37),
          CircleWidget(
              diameter: 183.04,
              color: Color(0xFFF34B1B),
              xPosition: 180.75,
              yPosition: 777.5),
          CircleWidget(
              diameter: 264.85,
              color: Color(0xFF1C8B3B),
              xPosition: -70.93,
              yPosition: 447.86),
          CircleWidget(
              diameter: 400.08,
              color: AppColors.secondaryColor,
              xPosition: 231.09,
              yPosition: 703.62),
          const BackgroundBlurWithRadialGradient(
              opacity: 0.74, color: Colors.white),



          ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: registerController.registerKey,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: SizeConfig.scaleHeight(54)),
                      child: MyImage(
                        imagePath: 'assets/images/image 2.png',
                        width: 342.07,
                        height: 130,
                      ),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(18)),
                    Center(
                      child: Container(
                        width: SizeConfig.scaleWidth(120),
                        height: SizeConfig.scaleHeight(45),
                        alignment: Alignment.center,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'ProtestStrike',
                              fontWeight: FontWeight.w900,
                            ),
                            children: [
                              TextSpan(text: 'Sign', style: TextStyle(color: Colors.black)),
                              TextSpan(text: ' Up', style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: registerController.nameController,
                      validator: (value){
                        return registerController.validateName(value!);
                      },

                      labelText: 'Name',prefix: Icons.person,inputType: TextInputType.emailAddress,

                    ),
                    SizedBox(height: SizeConfig.scaleHeight(10)),
                    CustomDropdownField(
                      prefix: Icons.male,
                      label: 'Gender',
                      items: ['Male', 'Female'],
                      selectedValue: registerController.selectedGender,
                      validator: (value) => registerController.validateGender(value ?? ''),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(24)),
                    CustomTextField(
                      controller: registerController.phoneNumController,
                      validator: (value){
                        return registerController.validatePhoneNum(value!);
                      },

                      labelText: 'Phone Number',prefix: Icons.phone,inputType: TextInputType.phone,

                    ),
                    SizedBox(height: SizeConfig.scaleHeight(10)),

                    SizedBox(height: SizeConfig.scaleHeight(10)),
                    CustomTextField(
                      controller: registerController.addressController,
                      validator: (value){
                        return registerController.validateAddress(value!);
                      },

                      labelText: 'Address',prefix: Icons.location_on_outlined,inputType: TextInputType.emailAddress,

                    ),
                    SizedBox(height: SizeConfig.scaleHeight(10)),
                    CustomTextField(
                      controller: registerController.ageController,
                      validator: (value) {
                        return registerController.validateAge(value!);
                      },
                      labelText: 'Age',
                      prefix: Icons.calendar_today,
                      inputType: TextInputType.number,
                    ),

                    SizedBox(height: SizeConfig.scaleHeight(10)),
                    CustomDropdownField(
                      prefix: Icons.payment,
                      label: 'Sim type',
                      items: ['prepayed', 'Postpayed'],
                      selectedValue: registerController.simTypeController,
                      validator: (value) => registerController.validateSimType(value ?? ''),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(24)),
                    Obx(()=>CustomTextField(
                      maxLines: 1,
                      controller: registerController.passwordController,
                      inputType: TextInputType.visiblePassword,
                      labelText: 'Password',prefix: Icons.lock,
                      obscureText: registerController.isPassword.value,
                      suffix: registerController.isPassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      pss: () {
                        registerController.changePasswordIcon();
                      },
                      validator: (value){
                        return registerController.validatePassword(value!);
                      },

                    )),
                    SizedBox(height: SizeConfig.scaleHeight(16)),
                    SizedBox(height: SizeConfig.scaleHeight(16)),


                    MainButton(
                      text: 'Sign Up',
                      onPressed: () {
                        registerController.doSignup();
                      },
                    ),








                    // لا تستخدم Obx على الكل، فقط حول المتغيرات التي ستتغير وتؤثر على الـ widget مباشرة
                    // لا تستخدم Obx على الكل، فقط حول المتغيرات التي ستتغير وتؤثر على الـ widget مباشرة









                  ],
                ),
              ),

            ),
          ),
          if (registerController.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),)
    );
  }
}