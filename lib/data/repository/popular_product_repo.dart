import 'package:foddies_app/data/api/api_client.dart';
import 'package:foddies_app/utils/app_consts.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
