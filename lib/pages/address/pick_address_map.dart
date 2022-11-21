import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foddies_app/base/custom_button.dart';
import 'package:foddies_app/controllers/location_controller.dart';
import 'package:foddies_app/pages/address/widgets/search_location_dialoge.dart';
import 'package:foddies_app/routes/route_helper.dart';
import 'package:foddies_app/utils/colors.dart';
import 'package:foddies_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initalPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                  },
                ),
                Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/image/pick_marker.png",
                          height: 50,
                          width: 50,
                        )
                      : CircularProgressIndicator(),
                ),
                //Show and select address
                Positioned(
                  child: InkWell(
                    onTap: () => Get.dialog(
                        LocationDialog(mapController: _mapController)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppColors.yellowColor,
                          ),
                          Expanded(
                            child: Text(
                              '${locationController.pickPlaceMark.name ?? ''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Icon(
                            Icons.search,
                            color: AppColors.yellowColor,
                          ),
                        ],
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                    ),
                  ),
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                Positioned(
                  bottom: 40,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: locationController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          buttonText: locationController.inZone
                              ? widget.fromAddress
                                  ? "Pick Address"
                                  : "Pick Location"
                              : "Service is not available in your area",
                          onPressed: (locationController.loading ||
                                  locationController.buttonDisabled)
                              ? null
                              : () {
                                  if (locationController
                                              .pickPosition.latitude !=
                                          0 &&
                                      locationController.pickPlaceMark.name !=
                                          null) {
                                    if (widget.fromAddress) {
                                      if (widget.googleMapController != null) {
                                        print("Now you can clicked on this");
                                        widget.googleMapController!.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: LatLng(
                                                        locationController
                                                            .pickPosition
                                                            .latitude,
                                                        locationController
                                                            .pickPosition
                                                            .longitude))));
                                        locationController.setAddAddressData();
                                      }
//Get.back() creates update problem
//list, a value
                                      Get.offNamed(
                                          RouteHelper.getAddressPage());
                                    }
                                  }
                                }),
                )
              ]),
            ),
          ),
        ),
      );
    });
  }
}
