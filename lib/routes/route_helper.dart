import 'package:foddies_app/models/order_model.dart';
import 'package:foddies_app/pages/address/add_address_page.dart';
import 'package:foddies_app/pages/auth/signin_page.dart';
import 'package:foddies_app/pages/cart/cart_page.dart';
import 'package:foddies_app/pages/home/main_food_page.dart';
import 'package:foddies_app/pages/payment/payment_page.dart';
import 'package:get/get.dart';

import '../pages/address/pick_address_map.dart';
import '../pages/food/popular_food_detail.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";
  static const String signIn = "/sign-in";

  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splashPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage() => '$orderSuccess';

  static List<GetPage> routes = [
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(
        name: signIn, page: () => SignInPage(), transition: Transition.fade),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: addAddress, page: () => AddAddressPage()),
    GetPage(
      name: payment,
      page: () => PaymentScreen(
        orderModel: OrderModel(
          userID: int.parse(Get.parameters["userID"]!),
          id: int.parse(Get.parameters['id']!),
        ),
      ),
    ),
    // GetPage(name: orderSuccess, page: ()=>OrderSuccessPage());
  ];
}
