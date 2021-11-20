import 'package:dio/dio.dart';
import 'package:homchf/model/banner_response.dart';
import 'package:homchf/model/order_setting_api_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:homchf/model/TrackingModel.dart';
import 'package:homchf/model/UserAddressListModel.dart';
import 'package:homchf/model/app_setting_model.dart';
import 'package:homchf/model/balance.dart';
import 'package:homchf/model/check_opt_model.dart';
import 'package:homchf/model/check_otp_model_for_forgot_password.dart';
import 'package:homchf/model/common_res.dart';
import 'package:homchf/model/cuisine_vendor_details_model.dart';
import 'package:homchf/model/exploreRestaurantsListModel.dart';
import 'package:homchf/model/faq_list_model.dart';
import 'package:homchf/model/favorite_list_model.dart';
import 'package:homchf/model/login_model.dart';
import 'package:homchf/model/order_history_list_model.dart';
import 'package:homchf/model/orders_response.dart';
import 'package:homchf/model/order_status.dart';
import 'package:homchf/model/payment_setting_model.dart';
import 'package:homchf/model/promoCode_model.dart';
import 'package:homchf/model/cart_tax_modal.dart';
import 'package:homchf/model/register_model.dart';
import 'package:homchf/model/search_list_model.dart';
import 'package:homchf/model/send_otp_model.dart';
import 'package:homchf/model/single_order_details_model.dart';
import 'package:homchf/model/top_restaurants_model.dart';
import 'package:homchf/model/user_details_model.dart';
import 'package:homchf/model/AllCuisinesModel.dart';
import 'package:homchf/model/nearByRestaurantsModel.dart';
import 'package:homchf/model/vegRestaurantsModel.dart';
import 'package:homchf/model/nonVegRestaurantsModel.dart';
import 'package:homchf/model/update_address_model.dart';
import 'package:homchf/model/single_restaurants_details_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://homchf.one/api/')
//Please don't remove "/api/".
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("user_register")
  Future<RegisterModel> register(@Body() Map<String, String?> map);

  @POST("check_otp")
  Future<CheckOTPModel> checkOtp(@Body() Map<String, String> map);

  @POST("check_otp")
  Future<CheckOTPForForgotPasswordModel> checkOtpForForgotPassword(
      @Body() Map<String, String> map);

  @POST("send_otp")
  Future<SendOTPModel> sendOtp(@Body() Map<String, String?> map);

  @POST("user_login")
  Future<LoginModel> userLogin(@Body() Map<String, String> map);

  @POST("update_image")
  Future<CommenRes> updateImage(@Body() Map<String, String?> map);

  @GET("user")
  Future<UserDetailsModel> user();

  @POST("update_user")
  Future<CommenRes> updateUser(@Body() Map<String, String> map);

  @GET("faq")
  Future<FAQListModel> faq();

  @GET("order_setting")
  Future<OrderSettingModel> orderSetting();

  @GET("cuisine")
  Future<AllCuisinesModel> allCuisine();

  @GET("payment_setting")
  Future<PaymentSettingModel> paymentSetting();

  @POST("near_by")
  Future<NearByRestaurantModel> nearBy(@Body() Map<String, String> map);

  @POST("top_rest")
  Future<TopRestaurantsListModel> topRest(@Body() Map<String, String> map);

  @POST("veg_rest")
  Future<VegRestaurantModel> vegRest(@Body() Map<String, String> map);

  @POST("nonveg_rest")
  Future<NonVegRestaurantModel> nonVegRest(@Body() Map<String, String> map);

  @POST("explore_rest")
  Future<ExploreRestaurantListModel> exploreRest(
      @Body() Map<String, String> map);

  @POST("faviroute")
  Future<CommenRes> favorite(@Body() Map<String, String> map);

  @POST("book_order")
  Future<CommenRes> bookOrder(
    @Body() map,
  );

  @POST("add_address")
  Future<CommenRes> addAddress(@Body() Map<String, String> map);

  @GET("get_order_schedule")
  Future<CommenRes> getOrderSchedule(@Body() map);

  @POST("apply_promo_code")
  Future<String?> applyPromoCode(@Body() Map<String, String> map);

  @POST("search")
  Future<SearchListModel> search(@Body() Map<String, String> map);

  @POST("add_feedback")
  Future<CommenRes> addFeedback(
    @Body() map,
  );

  @POST("add_review")
  Future<CommenRes> addReview(
    @Body() map,
  );

  @GET("user_address")
  Future<UserAddressListModel> userAddress();

  @GET("show_order")
  Future<OrderHistoryListModel> showOrder();

  @GET("user_order_status")
  Future<OrderStatus> userOrderStatus();

  @POST("update_address/{id}")
  Future<UpdateAddressModel> updateAddress(
      @Path() int? id, @Body() Map<String, String?> map);

  @GET("promo_code/{id}")
  Future<PromoCodeModel> promoCode(
    @Path() int? id,
  );

  @GET("single_order/{id}")
  Future<SingleOrderDetailsModel> singleOrder(
    @Path() int? id,
  );

  @POST("cancel_order")
  Future<CommenRes> cancelOrder(@Body() Map<String, String> map);

  @POST("refund")
  Future<CommenRes> refund(@Body() Map<String, String> map);

  @POST("bank_details")
  Future<CommenRes> bankDetails(@Body() Map<String, String> map);

  @GET("tracking/{id}")
  Future<TrackingModel> tracking(
    @Path() int? id,
  );

  @GET("remove_address/{id}")
  Future<CommenRes> removeAddress(@Path() int? id);

  @GET("tax")
  Future<CartTaxModal> getTax();

  @GET("single_vendor/{id}")
  Future<SingleRestaurantsDetailsModel> singleVendor(@Path() int? id);

  @POST("rest_faviroute")
  Future<FavoriteListModel> restFavorite();

  @GET("setting")
  Future<AppSettingModel> setting();

  @POST("user_forgot_password")
  Future<CommenRes> changeForgot(@Body() Map<String, String> map);

  @POST("user_change_password")
  Future<CommenRes> changePassword(@Body() Map<String, String> map);

  @POST("filter")
  Future<ExploreRestaurantListModel> filter(@Body() Map<String, String?> map);

  @GET("cuisine_vendor/{id}")
  Future<CuisineVendorDetailsModel> cuisineVendor(@Path() int? id);

  @GET("user_balance")
  Future<Balance> getBalanceHistory();

  @GET("wallet_balance")
  Future<CommenRes> getWalletBalance();

  @GET("banner")
  Future<BannerResponse> getBanner();

  @POST("add_balance")
  Future<CommenRes> addBalance(@Body() Map<String, String?> map);
}
