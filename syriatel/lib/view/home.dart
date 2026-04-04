import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syriatel/theme/colors.dart';
import 'package:syriatel/theme/size_config.dart';
import 'package:syriatel/widgets/custom_appbar.dart';

import '../controllers/home_controller.dart';
import '../widgets/custom_gradient_box.dart';
import '../widgets/custom_radial_bar.dart';
import '../widgets/donut_chart.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Syriatel Offers', iconImagePath: 'assets/images/bell.png'),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(width: SizeConfig.scaleWidth(427),
                height: SizeConfig.scaleHeight(62),
                color: Color(0xFFF34B1B),
                child:
                Center(
                    child:
                    Text('Consumption per month',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins',
                      fontSize: 16
                    ),),
                ),),
                SizedBox(
                  height: SizeConfig.scaleHeight(50),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From 1-6 Dec, 2020',style: TextStyle(color:
                    Colors.black.withOpacity(0.5),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                ),),
                    Center(
                      child: Obx(() => DonutChart(
                        value1: controller.internet.value,
                        value2: controller.calls.value,
                        value3: controller.messages.value,
                      )),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                          left:SizeConfig.scaleWidth(11),
                          right: SizeConfig.scaleWidth(11),
                          top: SizeConfig.scaleHeight(60),
                      bottom:SizeConfig.scaleHeight(40) ),
                      child: Row(
                        children: [
                          CustomGradientBox(
                            title: 'Internet',
                            dotColor: AppColors.thirdColor,
                            // مثلاً:
                              percentage: controller.internet.value,
                          ),
                          SizedBox(width: SizeConfig.scaleWidth(17),),
                          CustomGradientBox(
                            title: 'Calls',
                            dotColor: Color(0xFFEE2200).withOpacity(0.5),
                            // مثلاً:
                            percentage: controller.calls.value,
                          ),
                          SizedBox(width: SizeConfig.scaleWidth(17),),
                          CustomGradientBox(
                            title: 'Messages',
                            dotColor: Color(0xFFEE2200).withOpacity(0.3),
                            // مثلاً:
                            percentage: controller.messages.value,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(width: SizeConfig.scaleWidth(427),
                        height: SizeConfig.scaleHeight(62),
                        color: Color(0xFFF34B1B),
                        child:
                        Center(
                          child:
                          Text('Your consumption from the current offer',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins',
                              fontSize: 16
                          ),),
                        ),
                      ),
                    ),

                    Obx(()=>Center(
                      child: Row(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: SizeConfig.scaleWidth(88),top: SizeConfig.scaleHeight(45)),
                                child: StyledRadialBar(
                                  percentage: controller.callsOffer.value,
                                  label: 'from Calls',
                                  fillColor: Color(0xFF969599)!,
                                  progressColor: Color(0xFF969599)!,
                                  size: SizeConfig.scaleWidth(105),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: SizeConfig.scaleWidth(59.85),top: SizeConfig.scaleHeight(20.67)),
                                child: StyledRadialBar(
                                  percentage: controller.internetOffer.value,
                                  label: 'from messages',
                                  fillColor: AppColors.secondaryColor!,
                                  progressColor: AppColors.secondaryColor!,
                                  size: 128,
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10),top: SizeConfig.scaleHeight(15)),
                            child: StyledRadialBar(
                              percentage: controller.messagesOffer.value,
                              label: 'from messages',
                              fillColor: AppColors.thirdColor!,
                              progressColor: AppColors.thirdColor!,
                              size: 160,
                            ),
                          ),
                        ],
                      ),
                    ),),
                    SizedBox(height: SizeConfig.scaleHeight(150),),


                    


                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
