import 'package:foddies_app/data/api/api_client.dart';
import 'package:foddies_app/utils/app_consts.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
