import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homchf/model/update_address_model.dart';
import 'package:homchf/retrofit/api_header.dart';
import 'package:homchf/retrofit/api_client.dart';
import 'package:homchf/retrofit/base_model.dart';
import 'package:homchf/retrofit/server_error.dart';
import 'package:homchf/screen_animation_utils/transitions.dart';
import 'package:homchf/screens/manage_your_location.dart';
import 'package:homchf/utils/constants.dart';
import 'package:homchf/utils/localization/language/languages.dart';
import 'package:homchf/utils/rounded_corner_app_button.dart';
import 'package:homchf/utils_google_map/address_search.dart';
import 'package:homchf/utils_google_map/place_service.dart';

import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class EditAddressScreen extends StatefulWidget {
  final int? addressId, userId;

  final String? strAddress, strAddressType, latitude, longitude;
  BitmapDescriptor? marker = BitmapDescriptor.defaultMarker;

   EditAddressScreen(
      {Key? key,
      required this.addressId,
      required this.userId,
      required this.latitude,
      required this.longitude,
      required this.strAddress,
      required this.strAddressType,
      required this.marker})
      : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late LatLng _initialCameraPosition;
  late GoogleMapController _controller;
  BitmapDescriptor? _markerIcon;



  TextEditingController _textFullAddress = new TextEditingController();
  TextEditingController _textFullAddress1 = new TextEditingController();

  //TextEditingController _textLandmark = new TextEditingController();
  TextEditingController _textAddressLable = new TextEditingController();

  String? strLongitude = '',
      strLatitude = '',
      strSearchedAddress = '',
      strAddressLabel = '';

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      BitmapDescriptor bitmapDescriptor =
          await _bitmapDescriptorFromSvgAsset(context, 'images/ic_marker.svg');
      _updateBitmap(bitmapDescriptor);
    }
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        32 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: _initialCameraPosition,
        icon: widget.marker!,
      ),
    ].toSet();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
   /* _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(double.parse(widget.latitude!),
                  double.parse(widget.longitude!)),
              zoom: 18),
        ),
      );
    });*/
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      strLongitude = widget.longitude;
      strLatitude = widget.latitude;
      _initialCameraPosition = LatLng(double.parse(widget.latitude!), double.parse(widget.longitude!));
      strAddressLabel = widget.strAddressType;

      _textAddressLable.text = strAddressLabel ?? '';
      _textFullAddress.text = widget.strAddress!;
      strSearchedAddress = widget.strAddress;
    });
  }

  @override
  Widget build(BuildContext context) {


    _createMarkerImageFromAsset(context);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialCameraPosition,zoom: 18),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  markers: _createMarker(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _textFullAddress,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: 'type full address and tap "search location"',
                                    border: InputBorder.none),
                                maxLines: 3,
                                style: TextStyle(
                                  fontFamily: Constants.appFont,
                                  fontSize: 16,
                                  color: Color(Constants.colorGray),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // final sessionToken = Uuid().v4();
                          
                          // strSearchedAddress = '';
                          final query = _textFullAddress.text.toString();
                          var addresses = await Geocoder.google('AIzaSyBlPBZZgOLEDGUSQ9U7xFMWymaFlf9uyvQ').findAddressesFromQuery(query);
                          var first = addresses.first;
                          strSearchedAddress = first.addressLine.toString();
                          strLatitude = first.coordinates.latitude.toString();
                          strLongitude = first.coordinates.longitude.toString();
                          var strLatitude1 = first.coordinates.latitude.toString();
                          var strLongitude1 = first.coordinates.longitude.toString();
                          _controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: LatLng(
                                          double.parse(strLatitude1), double.parse(strLongitude1)),
                                      zoom: 18),
                                ),
                              );
                              _initialCameraPosition =
                                  LatLng(double.parse(strLatitude1), double.parse(strLongitude1));
                              _createMarker();
                          // if (result != null) {
                          //   final placeDetails = await PlaceApiProvider()
                          //       .getPlaceDetailFromId(result.placeId);
                          //   setState(() async {
                          //     String address = '';
                          //     address = result.description + '\n';
                          //     if (placeDetails.street != null)
                          //       address = address + placeDetails.street! + ' ';
                          //     if (placeDetails.city != null) address = address + placeDetails.city!;
                          //     _textFullAddress.text = address;
                          //     strSearchedAddress = address;
                          //     print(result.lat);
                          //     print(result.longi);
                          //     strLongitude = result.longi.toString();
                          //     strLatitude = result.lat.toString();
                              
                          //   });
                          // }
                        },
                        child: Container(
                        color: Color(Constants.colorTheme),
                        padding: const EdgeInsets.all(6),
                        
                          child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(right: ScreenUtil().setHeight(10)),
                                  child: SvgPicture.asset(
                                    'images/search.svg',
                                    width: ScreenUtil().setWidth(15),
                                    color: Color(Constants.colorLightGray),
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: Languages.of(context)!.labelSearchLocation,
                                style: TextStyle(
                                    color: Color(Constants.colorLightGray),
                                    fontFamily: Constants.appFontBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          strSearchedAddress!,
                          style: TextStyle(
                              color: Color(Constants.colorGray),
                              fontFamily: Constants.appFont),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          Languages.of(context)!.labelHouseNo,
                          style: TextStyle(
                              fontFamily: Constants.appFontBold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: ScreenUtil().setHeight(100),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _textFullAddress1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: Languages.of(context)!
                                        .labelTypeFullAddressHere,
                                    border: InputBorder.none),
                                maxLines: 3,
                                style: TextStyle(
                                    fontFamily: Constants.appFont,
                                    fontSize: 16,
                                    color: Color(Constants.colorGray),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          Languages.of(context)!.labelLandmark,
                          style: TextStyle(
                              fontFamily: Constants.appFontBold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 2, bottom: 2),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  hintText: Languages.of(context)!
                                      .labelAnyLandmarkNearYourLocation,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: Constants.appFont,
                                    color: Color(Constants.colorGray),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: RoundedCornerAppButton(
                          onPressed: () {
                            showdialog();
                          },
                          btnLabel: Languages.of(context)!.labelEditAddress,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  showdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 0, top: 20),
              child: Container(
                height: ScreenUtil().setHeight(250),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context)!.labelAttachLabel,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            fontFamily: Constants.appFontBold,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffcccccc),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 2, bottom: 2),
                                child: TextField(
                                  controller: _textAddressLable,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: Languages.of(context)!
                                        .labelAddLabelForThisLocation,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: Constants.appFont,
                                      color: Color(Constants.colorGray),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'images/ic_map.svg',
                              width: 18,
                              height: ScreenUtil().setHeight(18),
                              color: Color(Constants.colorTheme),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 2),
                                child: Text(
                                  strSearchedAddress!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: Constants.appFont,
                                      color: Color(Constants.colorBlack),
                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xffcccccc),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  Languages.of(context)!.labelCancel,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Constants.appFontBold,
                                      color: Color(Constants.colorGray),
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    if (strSearchedAddress!.isEmpty ||
                                        strSearchedAddress == null) {
                                      Constants.toastMessage(
                                          Languages.of(context)!
                                              .labelPleaseSearchAddress);
                                    } else if (_textAddressLable.text.isEmpty) {
                                      Constants.toastMessage(
                                          Languages.of(context)!
                                              .labelPleaseAddLabelForAddress);
                                    } else {
                                      callUpdateUserAddress(widget.addressId);
                                    }
                                  },
                                  child: Text(
                                    Languages.of(context)!.labelSaveIt,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Constants.appFontBold,
                                        color: Color(Constants.colorBlue),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<BaseModel<UpdateAddressModel>> callUpdateUserAddress(int? addressId ) async {
    UpdateAddressModel response;
    try{

      Constants.onLoading(context);
      Map<String, String?> body = {
        'address': strSearchedAddress,
        'lat': strLatitude,
        'lang': strLongitude,
        'type': _textAddressLable.text,
      };
      response  = await RestClient(RetroApi().dioData()).updateAddress(addressId, body);

      Constants.hideDialog(context);
      print(response.success);

      if (response.success!) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          Transitions(
            transitionType: TransitionType.slideUp,
            curve: Curves.bounceInOut,
            reverseCurve: Curves.fastLinearToSlowEaseIn,
            widget: ManageYourLocation(),
          ),
        );
      } else {
        Constants.toastMessage(Languages.of(context)!.labelErrorWhileAddAddress);
      }

    }catch (error, stacktrace) {
      Constants.hideDialog(context);
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

}
