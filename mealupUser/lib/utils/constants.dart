import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'localization/language/languages.dart';

class Constants {
  /*map key*/
  static final String androidKey = 'ENTER_YOUR_GOOGLE_ANDROID_KEY';
  static final String iosKey = 'ENTER_YOUR_GOOGLE_iOS_KEY';

  static int colorBlack = 0xFF090E21;
  static int colorGray = 0xFF999999;
  static int colorLightGray = 0xFFe8e8e8;
  static int colorLike = 0xFFff6060;
  static int colorLikeLight = 0xFFe2bcbc;
  static int colorTheme = 0xFF06C168;
  static int colorOrderPending = 0xFFF4AE36;
  static int colorOrderPickup = 0xFFd1286b;
  static int colorThemeOp = 0xFF9BE6C2;
  static int colorBackground = 0xFFFAFAFA;
  static int colorRate = 0xFFffc107;
  static int colorBlue = 0xFF1492e6;
  static int colorScreenBackGround = 0xFFf2f2f2;
  static int colorHint = 0xFFb9b9b9;
  static String appFont = 'Proxima';
  static String appFontBold = 'ProximaBold';

  static String registrationOTP = 'regOTP';
  static String registrationEmail = 'regEmail';
  static String registrationPhone = 'regPhone';
  static String registrationUserId = 'userId';

  static String bankIFSC = 'bank_IFSC';
  static String bankMICR = 'bank_MICR';
  static String bankACCName = 'bank_ACC_Name';
  static String bankACCNumber = 'bank_ACC_Number';

  static String loginOTP = 'loginOTP';
  static String loginEmail = 'loginEmail';
  static String loginPhone = 'loginPhone';
  static String loginUserId = 'loggeduserId';
  static String loginUserImage = 'loggedImage';
  static String loginUserName = 'loggedName';

/*  static String loginLanguage = 'loginLanguage';
  static String loginIFSC_CODE = 'loginIFSC_CODE';
  static String loginMICR_CODE = 'loginMICR_CODE';
  static String loginBankAccountName = 'loginBankAccountName';
  static String loginBankAccountNumber = 'loginBankAccountNumber';*/

  static String headerToken = 'headerToken';
  static String isLoggedIn = 'isLoggedIn';
  static String stripePaymentToken = 'stripePaymentToken';

  static String selectedAddress = 'selectedAddress';
  static String selectedAddressId = 'selectedAddressId';
  static String recentSearch = 'recentSearch';

  static String appSettingCurrency = 'appSettingCurrency';
  static String appSettingCurrencySymbol = 'appSettingCurrencySymbol';
  static String appSettingPrivacyPolicy = 'appSettingPrivacyPolicy';
  static String appSettingTerm = 'appSettingTerm';
  static String appAboutCompany = 'appAboutCompany';
  static String appSettingHelp = 'appSettingHelp';
  static String appSettingAboutUs = 'appSettingAboutUs';
  static String appSettingDriverAutoRefresh = 'appSettingDriverAutoRefresh';
  static String appSettingBusinessAvailability = 'appSettingBusiness_availability';
  static String appSettingBusinessMessage = 'appSettingBusiness_message';
  static String appSettingCustomerAppId = 'appSettingCustomerAppId';
  static String appSettingAndroidCustomerVersion = 'appSetting_android_customer_version';
  static String appSettingIsPickup = 'appSetting_isPickup';
  static String appPushOneSingleToken = 'push_oneSingleToken';

  static String previousLat = 'previousLat';
  static String previousLng = 'previousLng';

  // payment Setting
  static String appPaymentWallet = 'appPaymentWallet';
  static String appPaymentCOD = 'appPaymentCOD';
  static String appPaymentStripe = 'appPaymentStripe';
  static String appPaymentRozerPay = 'appPaymentRozerPay';
  static String appPaymentPaypal = 'appPaymentPaypal';
  static String appStripePublishKey = 'appStripePublishKey';
  static String appStripeSecretKey = 'appStripeSecretKey';
  static String appPaypalProduction = 'appPaypalProducation';
  static String appPaypalClientId = 'appPaypal_client_id';
  static String appPaypalSecretKey = 'appPaypal_secret_key';
  static String appPaypalSendBox = 'appPaypalSendbox';
  static String appRozerpayPublishKey = 'appRozerpayPublishKey';

  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      Constants.toastMessage("No Internet Connection");
      return false;
    }
  }

  static var kAppLabelWidget =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, fontFamily: Constants.appFontBold);

  static var kTextFieldInputDecoration = InputDecoration(
    hintStyle: TextStyle(color: Color(Constants.colorHint)),
    errorStyle: TextStyle(fontFamily: Constants.appFontBold, color: Colors.red),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0,right: 14),
    errorMaxLines: 2,
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    enabledBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    disabledBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    focusedBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    errorBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 0.5, color: Colors.red),
    ),
    focusedErrorBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 1, color: Colors.red),
    ),
  );

  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  static onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(width : 20),
                new Text(Languages.of(context)!.labelPleaseWait),
              ],
            ),
          ),
        );
      },
    );
  }
  static hideDialog(BuildContext context){
    Navigator.pop(context);
  }
}
