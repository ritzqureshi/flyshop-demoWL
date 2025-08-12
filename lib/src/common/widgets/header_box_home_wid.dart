import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikotech/src/common/utils/colours.dart';
import 'package:ikotech/src/common/widgets/webview_wid.dart';
import 'package:ikotech/src/screens/bus_search_screen.dart';
import 'package:ikotech/src/screens/hotel_search_screen.dart';

import '../../screens/flight_search_screen.dart';
import '../../screens/holiday_search_screen.dart';
import '../utils/constant.dart';
import '../utils/functions.dart';

class HeaderBoxHomeWid extends StatelessWidget {
  final dynamic enabledItems;
  const HeaderBoxHomeWid({super.key, this.enabledItems});

  @override
  Widget build(BuildContext context) {
    final List<String> totalItems = List<String>.from(enabledItems);
    final topItems = totalItems.take(4).toList();
    final remainingItems = totalItems.skip(4).toList();
    List<String> bottomItems;
    List<String> extraItems = [];
    if (remainingItems.length <= 4) {
      bottomItems = List<String>.from(remainingItems);
    } else {
      bottomItems = remainingItems.take(3).toList()..add('more');
      extraItems = remainingItems.skip(3).toList();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          // Top Grid (Always 4 max)
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.82,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            children: topItems
                .map((key) => _buildFeatureTile(context, key))
                .toList(),
          ),

          const SizedBox(height: 10),

          // Bottom Row (up to 4 or 3 + "more")
          Padding(
            padding: const EdgeInsets.only(left: 13.0, right: 13),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 1),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(bottomItems.length * 2 - 1, (index) {
                  if (index.isOdd) {
                    // Divider between items
                    return Container(
                      width: 1,
                      height: 50,
                      color: Colors.grey.shade300,
                    );
                  }
                  final key = bottomItems[index ~/ 2];

                  if (key == 'more') {
                    return PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 30),
                      onSelected: (selectedKey) {
                        onSearchHoliday(context, {
                          "urlToUse": "${Constant.baseUrl}mob/$selectedKey",
                        });
                      },
                      itemBuilder: (context) {
                        return extraItems.map((extraKey) {
                          return PopupMenuItem<String>(
                            value: extraKey,
                            child: Row(
                              children: [
                                _getIconForKey(extraKey),
                                SizedBox(width: 8),
                                Text(
                                  _capitalize(extraKey),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList();
                      },
                    );
                  }

                  // Regular bottom item
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        getLog(key, "Bottom Row");
                        if (key == "cab_enquiry") {
                          // FunctionsUtils.showTravellerSheet(
                          //   context,
                          //   title: "Car Rental Enquiry",
                          //   widget: CarSearchScreen(),
                          // );
                          onSearchHoliday(context, {
                            "urlToUse": "${Constant.baseUrl}mob/cab",
                          });
                        } else if (key == "train") {
                          onSearchHoliday(context, {
                            "urlToUse": "${Constant.baseUrl}mob/train-enquiry",
                          });
                        } else if (key == "group_enquiry") {
                          onSearchHoliday(context, {
                            "urlToUse": "${Constant.baseUrl}mob/group-enquiry",
                          });
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getIconForKey(key),
                          const SizedBox(height: 4),
                          Text(
                            _capitalize(key),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSearchHoliday(
    BuildContext context,
    Map<String, dynamic> request,
  ) async {
    final safeUrl = Uri.encodeFull(request['urlToUse']);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWebviewWidget(title: "", urlToUse: safeUrl), //
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, String key) {
    return GestureDetector(
      onTap: () {
        if (key == "flight") {
          FunctionsUtils.showTravellerSheet(
            context,
            title: "Flight Search",
            widget: FlightSearchScreen(),
          );
        } else if (key == "hotel") {
          FunctionsUtils.showTravellerSheet(
            context,
            title: "Hotel Search",
            widget: HotelSearchScreen(),
          );
        } else if (key == "holiday") {
          FunctionsUtils.showTravellerSheet(
            context,
            title: "Exclusive Travel Deals",
            widget: HolidaySearchScreen(),
          );
        } else if (key == "bus") {
          FunctionsUtils.showTravellerSheet(
            context,
            title: "Book Bus with us",
            widget: BusesSearchScreen(),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getIconForKey(key),
            const SizedBox(height: 10),
            Text(
              _capitalize(key),
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAssetOrIcon({
    required String assetPath,
    required IconData iconsFallback,
    double size = 33.0,
    Color? color,
  }) {
    return FutureBuilder<bool>(
      future: _assetExists(assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == true) {
          return Image.asset(
            assetPath,
            width: size,
            height: size,
            // color: color,
          );
        }
        // Return fallback icon if not found or while loading
        return Icon(iconsFallback, size: size, color: color);
      },
    );
  }

  Future<bool> _assetExists(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      return byteData.lengthInBytes > 0;
    } catch (_) {
      return false;
    }
  }

  Widget _getIconForKey(String key) {
    switch (key.toLowerCase()) {
      case 'flight':
        return getAssetOrIcon(
          assetPath: "assets/icons/flight.png",
          iconsFallback: Icons.flight,
          color: MyColors.blue,
        );
      case 'hotel':
        return getAssetOrIcon(
          assetPath: "assets/icons/hotel.png",
          iconsFallback: Icons.apartment,
          color: MyColors.blue,
        );
      case 'holiday':
        return getAssetOrIcon(
          assetPath: "assets/icons/holiday.png",
          iconsFallback: Icons.beach_access,
          color: MyColors.blue,
        );

      case 'bus':
        return getAssetOrIcon(
          assetPath: "assets/icons/bus.png",
          iconsFallback: Icons.directions_bus,
          color: MyColors.blue,
        );

      case 'cab_enquiry':
      case 'cab':
        return getAssetOrIcon(
          assetPath: "assets/icons/cab.png",
          iconsFallback: Icons.local_taxi,
          color: MyColors.blue,
        );
      case 'activity':
        return getAssetOrIcon(
          assetPath: "assets/icons/activity.png",
          iconsFallback: Icons.festival,
          color: MyColors.blue,
        );
      case 'train':
        return getAssetOrIcon(
          assetPath: "assets/icons/train.png",
          iconsFallback: Icons.train,
          color: MyColors.blue,
        );
      case 'group_enquiry':
        return getAssetOrIcon(
          assetPath: "assets/icons/groupenquiry.png",
          iconsFallback: Icons.group,
          color: MyColors.blue,
        );
      case 'visa':
        return getAssetOrIcon(
          assetPath: "assets/icons/visa.png",
          iconsFallback: Icons.security,
          color: MyColors.blue,
        );
      case 'umrah':
        return getAssetOrIcon(
          assetPath: "assets/icons/umrah.png",
          iconsFallback: Icons.mosque,
          color: MyColors.blue,
        );
      case 'cruise':
        return getAssetOrIcon(
          assetPath: "assets/icons/cruise.png",
          iconsFallback: Icons.directions_boat,
          color: MyColors.blue,
        );
      case 'newcarbooking':
        return getAssetOrIcon(
          assetPath: "assets/icons/cab.png",
          iconsFallback: Icons.directions_car,
          color: MyColors.blue,
        );
      case 'ssr':
        return getAssetOrIcon(
          assetPath: "assets/icons/visa.png",
          iconsFallback: Icons.event_seat,
          color: MyColors.blue,
        );
      default:
        return getAssetOrIcon(
          assetPath: "assets/icons/visa.png",
          iconsFallback: Icons.event_seat,
          color: MyColors.blue,
        ); // fallback icon
    }
  }

  String _capitalize(String text) {
    return text
        .replaceAll("_", " ")
        .split(" ")
        .map((word) {
          if (word.isEmpty) return "";
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(" ");
  }
}
