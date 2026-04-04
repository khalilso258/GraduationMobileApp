import 'package:get/get.dart';
import '../auth/api_service.dart';
import '../models/activated_packages.dart';
import '../services/storage_service.dart';

class ActivatedPackagesController extends GetxController {
  var activatedPackages = <ActivatedPackageModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchActivatedPackages();
  }

  Future<void> fetchActivatedPackages() async {
    try {
      isLoading.value = true;
      final token = await StorageService.getToken();
      if (token == null) {
        print('❌ التوكين غير موجود');
        return;
      }

      final packages = await ApiService.getActivatedPackages(token);
      activatedPackages.assignAll(packages);
    } catch (e) {
      print('❌ خطأ أثناء تحميل الباقات المفعلة: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
