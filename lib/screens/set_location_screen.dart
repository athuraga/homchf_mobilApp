import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homchf/model/UserAddressListModel.dart';
import 'package:homchf/retrofit/api_header.dart';
import 'package:homchf/retrofit/api_client.dart';
import 'package:homchf/retrofit/base_model.dart';
import 'package:homchf/retrofit/server_error.dart';
import 'package:homchf/screen_animation_utils/transitions.dart';
import 'package:homchf/screens/bottom_navigation/dashboard_screen.dart';
import 'package:homchf/utils/SharedPreferenceUtil.dart';
import 'package:homchf/utils/app_toolbar.dart';
import 'package:homchf/utils/constants.dart';
import 'package:homchf/utils/localization/language/languages.dart';
import 'dart:ui' as ui;

import 'package:homchf/screens/address/add_address_screen.dart';
import 'package:homchf/screens/address/edit_address_screen.dart';
import 'package:homchf/utils/app_toolbar_with_btn_clr.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';

class SetLocationScreen extends StatefulWidget {
  @override
  _SetLocationScreenState createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
 // final _controller = TextEditingController();

  // String _streetNumber = '';
  // String _street = '';
  // String _city = '';
  // String _zipCode = '';

  List<UserAddressListData> _userAddressList = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isSyncing = false;
  // Position currentLocation;
  LocationData? _locationData;
  Location _location = Location();
  late Position currentLocation;
  double? _currentLatitude = 0.0;

  double? _currentLongitude = 0.0;
  BitmapDescriptor? _markerIcon;
  
  
  
  // @override
  // void initState() {
  //   super.initState();
  //   Constants.checkNetwork().whenComplete(() => callGetUserAddresses());
  // }

  Future<BaseModel<UserAddressListModel>> callGetUserAddresses() async {
    UserAddressListModel response;
    try{
      Constants.onLoading(context);
      _userAddressList.clear();
      response  = await  RestClient(RetroApi().dioData()).userAddress();
      print(response.success);
        Constants.hideDialog(context);
      if (response.success!) {
        setState(() {
          _userAddressList.addAll(response.data!);
        });
      } else {
        Constants.toastMessage(Languages.of(context)!.labelNoData);
      }

    }catch (error, stacktrace) {
      Constants.hideDialog(context);
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  // getUserLocation() async {
  //   currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   _currentLatitude = currentLocation.latitude;
  //   _currentLongitude = currentLocation.longitude;
  //   print('selectedLat $_currentLatitude');
  //   print('selectedLng $_currentLongitude');
  // }
  Future<void> getUserLocation() async {
    _locationData = await _location.getLocation();
    if (_locationData != null) {
      _currentLatitude = _locationData!.latitude;
      _currentLongitude = _locationData!.longitude;
      print('selectedLat $_currentLatitude');
      print('selectedLng $_currentLongitude');
    }
  }
void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Constants.checkNetwork().whenComplete(() => callGetUserAddresses());
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _createMarkerImageFromAsset(context);
    Constants.checkNetwork().whenComplete(() => callGetUserAddresses());
    getUserLocation();
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      BitmapDescriptor bitmapDescriptor =
          await _bitmapDescriptorFromSvgAsset(context, 'images/ic_marker.svg');
      //  _updateBitmap(bitmapDescriptor);
      setState(() {
        _markerIcon = bitmapDescriptor;
      });
    }
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await (image.toByteData(format: ui.ImageByteFormat.png));
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenWidth = MediaQuery.of(context).size.width;
    dynamic screenHeight = MediaQuery.of(context).size.height;

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: screenWidth,
            maxHeight: screenHeight),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    return SafeArea(
      child: Scaffold(
        appBar: ApplicationToolbarWithClrBtn(
          appbarTitle: Languages.of(context)!.labelSetLocation,
          strButtonTitle: '+ ${Languages.of(context)!.labelAddAddress}',
          btnColor: Color(Constants.colorThemeW),
          onBtnPress: () {
            if (_currentLongitude != 0.0) {
              Navigator.pop(context);
              Navigator.of(context).push(Transitions(
                  transitionType: TransitionType.fade,
                  curve: Curves.bounceInOut,
                  reverseCurve: Curves.fastLinearToSlowEaseIn,
                  // widget: HereMapDemo())
                  widget: AddAddressScreen(
                    isFromAddAddress: true,
                    currentLat: _currentLatitude,
                    currentLong: _currentLongitude,
                    marker: _markerIcon,
                  )));
            }
            else 
            {
              getUserLocation();
              _currentLatitude =  currentLocation.latitude;
              _currentLongitude = currentLocation.longitude;
    
              Navigator.pop(context);
              Navigator.of(context).push(Transitions(
                  transitionType: TransitionType.fade,
                  curve: Curves.bounceInOut,
                  reverseCurve: Curves.fastLinearToSlowEaseIn,
                  // widget: HereMapDemo())
                  widget: AddAddressScreen(
                    isFromAddAddress: true,
                    currentLat: _currentLatitude,
                    currentLong: _currentLongitude,
                    marker: _markerIcon,
                  )));
            }
          },
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/ic_background_image.png'),
            fit: BoxFit.cover,
          )),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(30),
                            top: ScreenUtil().setHeight(5),
                            bottom: ScreenUtil().setHeight(5)),
                        child: Text(
                          Languages.of(context)!.labelSavedAddress,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontFamily: Constants.appFontBold),
                        ),
                      ),
                      _userAddressList.length == 0
                          ? Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    width: ScreenUtil().setWidth(100),
                                    height: ScreenUtil().setHeight(100),
                                    image: AssetImage('images/ic_no_rest.png'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(10)),
                                    child: Text(
                                      'No Data Available. \n Please Add Address.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(18),
                                        fontFamily: Constants.appFontBold,
                                        color: Color(Constants.colorTheme),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _userAddressList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  SharedPreferenceUtil.putString('selectedLat',
                                      _userAddressList[index].lat!);
                                  SharedPreferenceUtil.putString('selectedLng',
                                      _userAddressList[index].lang!);
                                  SharedPreferenceUtil.putString(
                                      Constants.selectedAddress,
                                      _userAddressList[index].address!);
                                  SharedPreferenceUtil.putInt(
                                      Constants.selectedAddressId,
                                      _userAddressList[index].id);
                                  Navigator.of(context).push(Transitions(
                                      transitionType: TransitionType.slideUp,
                                      curve: Curves.bounceInOut,
                                      reverseCurve:
                                          Curves.fastLinearToSlowEaseIn,
                                      widget: DashboardScreen(0)));
                                },
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 30, bottom: 8),
                                      child: Text(
                                        _userAddressList[index].type != null
                                            ? _userAddressList[index].type!
                                            : '',
                                        style: TextStyle(
                                            fontFamily: Constants.appFontBold,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'images/ic_map.svg',
                                          width: 18,
                                          height: 18,
                                          color: Color(Constants.colorTheme),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, top: 2),
                                            child: Text(
                                              _userAddressList[index].address!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      Constants.appFont,
                                                  color: Color(Constants.colorBlack),
                                              )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Color(0xffcccccc),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
