import 'package:get/get.dart';

class HomeController extends GetxController {
  RxDouble internet = 40.0.obs;
  RxDouble calls = 30.0.obs;
  RxDouble messages = 30.0.obs;
  RxDouble internetOffer = 43.0.obs;
  RxDouble callsOffer = 92.0.obs;
  RxDouble messagesOffer = 77.0.obs;



  void updateWeekValues(double v1, double v2, double v3) {
    internet.value = v1;
    calls.value = v2;
    messages.value = v3;
  }

  void updateOfferValues(double v1, double v2, double v3) {
    internetOffer.value = v1;
    callsOffer.value = v2;
    messagesOffer.value = v3;
  }
}
