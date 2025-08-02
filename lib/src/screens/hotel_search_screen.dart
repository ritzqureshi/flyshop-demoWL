import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikotech/src/data/model/HotelModel/hotel_search_city_m.dart';
import 'package:intl/intl.dart';
import '../common/api_services.dart';
import '../common/utils/colours.dart';
import '../common/utils/constant.dart';
import '../common/utils/functions.dart';
import '../common/widgets/custom_datepicker.dart';
import '../common/widgets/my_button.dart';
import '../common/widgets/webview_wid.dart';

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({super.key});

  @override
  State<HotelSearchScreen> createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  int? selectedbookValue; // Holds the value of the selected radio button

  DateTime? checkinDate;
  DateTime? checkoutDate;
  int adultsCount = 0;
  int childrenCount = 0;
  int infantsCount = 0;
  int totalTravellers = 0;
  int totalGuests = 1;
  String? agenUserrId = '';
  String? logedUserSecurityKey = '';
  String? agencyMarketPlaceSysId = '';
  String? masterAgencySysId = '';
  String? contactNo = '';
  TextEditingController chooseCityController = TextEditingController();
  var chooseCityData;
  List<HotelSearchCityModel> filteredCities = [];
  List<HotelSearchCityModel> searchCities = [];
  dynamic roomInfo;
  List<Room> rooms = [Room()];
  Future<List<HotelSearchCityModel>>? _cities;
  bool isSearching = false;
  bool disposed = false;
  @override
  void initState() {
    chooseCityController.text;
    getAllDataFromSess();
    super.initState();
  }

  getAllDataFromSess() async {
    selectedbookValue = 1;
    checkinDate = DateTime.now();
  }

  // WebNavigation webNavigation =
  //     WebNavigation(navigatorKey.currentState!.context);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 23.0),
        child: Container(
          // height: 507,
          width: 380,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(34),
            // Adjust the radius as needed
          ),
          child: Column(
            children: [
              //----DESTINATION Text Editing controller----//
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.location_city,
                        size: 30,
                        color: MyColors.primaryColorOfApp,
                      ),
                    ),
                    commonCityController(
                      'Area, Landmark or Property',
                      chooseCityController,
                      chooseCityData,
                      MediaQuery.of(context).size.width *
                          0.7, // Set a fraction of the width
                      const EdgeInsets.only(left: 0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: SizedBox(
                  child: Row(
                    children: [
                      //-----Date Picker DEPARTURE-----//
                      Expanded(
                        child: commonDatepicker(
                          'Check In',
                          checkinDate,
                          () async {
                            await showCustomDatePicker(
                              context,
                              checkinDate!,
                              'Select Check In',
                            ).then((onValue) {
                              setState(() {
                                checkinDate = onValue;
                                if (checkinDate!.isAfter(
                                      checkoutDate ??
                                          checkinDate!.add(
                                            const Duration(days: 1),
                                          ),
                                    ) ||
                                    checkinDate!.isAtSameMomentAs(
                                      checkoutDate ??
                                          checkinDate!.add(
                                            const Duration(days: 1),
                                          ),
                                    )) {
                                  checkoutDate = checkinDate!.add(
                                    const Duration(days: 1),
                                  );
                                }
                              });
                            });
                            // departureDatePicker();
                          },
                          const EdgeInsets.only(
                            left: 0,
                            right: 0,
                          ), // Adjusted margin
                        ),
                      ),
                      //-----Date Picker RETURN-----//
                      Expanded(
                        child: commonDatepicker(
                          'Check Out',
                          checkoutDate,
                          () async {
                            setState(() {
                              // _wayTypeSelected = 2;
                            });
                            await showCustomDatePicker(
                              context,
                              checkoutDate ?? checkinDate!,
                              'Return Date',
                              minimumDate: checkinDate,
                            ).then((onValue) {
                              setState(() {
                                checkoutDate = onValue;
                              });
                            });
                          },
                          const EdgeInsets.only(
                            left: 0,
                            right: 0,
                          ), // Adjusted margin
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(endIndent: 25, indent: 55),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 12),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, top: 18),
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 37),
                              child: fieldTitle("Rooms"),
                            ),
                            SizedBox(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.location_city,
                                      size: 30,
                                      color: MyColors.primaryColorOfApp,
                                    ),
                                  ),
                                  // SizedBox(width: 10),
                                  Text(
                                    "${rooms.length.toString()} Rooms",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///------Add Rooms And Guest------//
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          _addRoomsSheet(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 36, top: 18),
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 37),
                                child: fieldTitle("Room's,Guest"),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: 44,
                                  child: Row(
                                    children: [
                                      const Image(
                                        height: 23,
                                        color: MyColors.primaryColorOfApp,
                                        image: AssetImage(
                                          'assets/icons/person.png',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      // Text(
                                      //   rooms.length.toString(),
                                      //   style: const TextStyle(
                                      //     color: Colors.black,
                                      //     fontSize: 15,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      Text(
                                        "$totalGuests Guest",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: MyButton(
                  backgroundColor: MyColors.primaryColorOfApp,
                  margin: const EdgeInsets.only(top: 27),
                  onClick: () {
                    calculateTotalGuests(rooms);

                    dynamic urlToUse1 = generateHotelSearchUrl(
                      cityName: "${chooseCityData['cityName']}",
                      countryName: "${chooseCityData['countryName']}",
                      hotelId: "725862",
                      checkInDate: checkinDate ?? DateTime.now(),
                      checkOutDate:
                          checkoutDate ?? checkinDate!.add(Duration(days: 1)),
                      rooms: rooms,
                    );
                    dynamic payload = {"urlToUse": urlToUse1};
                    onSearchHotel(payload);
                    getLog(payload, "title");
                  },
                  btnTxt: "Search Hotel",
                  btnTextStyle: TextStyle(
                    fontSize: (20),
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  width: 250,
                  height: 50,
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  String generateHotelSearchUrl({
    required String cityName,
    required String countryName,
    required String hotelId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required List<Room> rooms,
  }) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final origin = "$cityName, $countryName";
    final roomTypes = rooms.map((r) => r.adults).join(",");

    final queryParams = <String, String>{
      "origin": origin,
      "hotelid": hotelId,
      "checkindate": dateFormat.format(checkInDate),
      "checkoutdate": dateFormat.format(checkOutDate),
      "rt": roomTypes,
      "noofrooms": rooms.length.toString(),
      "noofadults": rooms.fold(0, (sum, r) => sum + r.adults).toString(),
      "noofchild": rooms.fold(0, (sum, r) => sum + r.children).toString(),
      "totalguestcount": rooms
          .fold(0, (sum, r) => sum + r.adults + r.children)
          .toString(),
      "platform": "mobile",
    };

    for (int i = 0; i < rooms.length; i++) {
      final room = rooms[i];
      final roomNum = i + 1;
      queryParams["Adults_room_$roomNum"] = room.adults.toString();
      queryParams["Children_room_$roomNum"] = room.children.toString();

      for (int j = 0; j < room.childrenAges.length; j++) {
        queryParams["Child_Age_${roomNum}_${j + 1}"] = room.childrenAges[j]
            .toString();
      }
    }

    return Uri.parse(
      "${Constant.baseUrl}hotel-search",
    ).replace(queryParameters: queryParams).toString();
  }

  //-----on search flight-----
  void onSearchHotel(Map<String, dynamic> request) async {
    final safeUrl = (request['urlToUse']);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWebviewWidget(title: "", urlToUse: safeUrl), //
      ),
    );
  }

  //----Common Datepicker-----//
  Widget commonDatepicker(
    String title,
    DateTime? dateElement,
    Function()? ontap,
    EdgeInsetsGeometry? customMargin,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: title != "Check in"
                  ? const EdgeInsets.only(left: 35)
                  : null,
              child: fieldTitle(title),
            ),
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0),
                    child: const Image(
                      height: 23,
                      color: MyColors.primaryColorOfApp,
                      image: AssetImage('assets/icons/calendar.png'),
                    ),
                  ),
                  title == "Check Out"
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            dateElement == null
                                ? DateFormat("d,MMM yyyy").format(
                                    DateTime(
                                      checkinDate!.year,
                                      checkinDate!.month,
                                      checkinDate!.day + 1,
                                    ),
                                  )
                                : DateFormat("d,MMM yyyy").format(dateElement),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            DateFormat("d,MMM yyyy").format(dateElement!),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-----FieldTitile----//
  Widget fieldTitle(String title) {
    return SizedBox(
      height: 18, // Same height as above
      child: Text(title, style: TextStyle(fontSize: (14))),
    );
  }

  //-------Stroke Line------//
  Widget strokeLine(double customWidth) {
    return Container(
      width: customWidth,
      height: .6, // Same height as above
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  //Radio button onHandle
  void handleRadioValueChange(int? value) {
    setState(() {
      selectedbookValue = value; // Update the selected radio button value
    });
  }

  //---DatePicker
  void checkInDatePicker() {
    showDatePicker(
      context: context,
      initialDate: checkinDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        checkinDate = value;
        if (checkinDate!.isAfter(
              checkoutDate ?? checkinDate!.add(const Duration(days: 1)),
            ) ||
            checkinDate!.isAtSameMomentAs(
              checkoutDate ?? checkinDate!.add(const Duration(days: 1)),
            )) {
          checkoutDate = checkinDate!.add(const Duration(days: 1));
        }
      });
      // print(departureDate);
    });
  }

  //---DatePicker
  void checkOutDatePicker() {
    showDatePicker(
      context: context,
      initialDate: checkoutDate ?? checkinDate!.add(const Duration(days: 1)),
      firstDate: checkinDate!,
      lastDate: DateTime(3000),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        checkoutDate = value;
      });
      // print(returnDate);
    });
  }

  //----Common TextField-----//
  Widget commonCityController(
    String title,
    TextEditingController textController,
    dynamic data,
    double customWidth,
    EdgeInsetsGeometry? customMargin,
  ) {
    return Container(
      margin: customMargin,
      width: customWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldTitle(title),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textController,
                  readOnly: true,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    _openFullBottomSheet(context, title, textController, data, (
                      updatedData,
                    ) {
                      setState(() {
                        data = updatedData;
                      });
                    });
                  },
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'City',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          // Text(data['label'].toString().split(',')[1]),
        ],
      ),
    );
  }

  void _openFullBottomSheet(
    BuildContext context,
    String title,
    TextEditingController textContro,
    var cityData,
    Function(dynamic) onUpdate,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  // padding: getPadding(all: 10),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: MyColors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextField(
                      controller: textContro,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: '$title city',
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            isSearching = true;
                          });

                          _searchCities(val);

                          if (!disposed) {
                            setState(() {
                              isSearching = false;
                            });
                          }
                        }
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                        //clear textfiel to cancel
                        textContro.clear();
                      },
                    ),
                  ),
                ),

                (textContro.text.isNotEmpty)
                    ? isSearching
                          ? const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                          : Expanded(
                              child: FutureBuilder<List<HotelSearchCityModel>>(
                                future: _cities,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CupertinoActivityIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: const Text("Not Available"),
                                    );
                                  } else {
                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            "${snapshot.data![index].cityName!},${snapshot.data![index].countryName!}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.black,
                                              fontSize: (16),
                                            ),
                                          ),
                                          trailing: Text(
                                            snapshot.data![index].type ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.white,
                                              fontSize: (16),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              textContro.text =
                                                  "${snapshot.data![index].cityName!},${snapshot.data![index].countryName!}";
                                              chooseCityData = snapshot
                                                  .data![index]
                                                  .toJson();
                                            });
                                            // print(snapshot.data![index].tBBCityId);
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            )
                    : Padding(
                        padding: const EdgeInsets.only(top: 39.0),
                        child: Center(child: Text("Enter City Name")),
                      ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      disposed = false;
    });
  }

  Future<List<HotelSearchCityModel>> getCityData(String query) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = "${Constant.hotelCitySearchApi}$query";
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      // getLog(response, "title");
      if (response.statusCode == 200) {
        final jsonData = (response.data);
        if (jsonData['status']) {
          if (jsonData != null) {
            filteredCities = (jsonData['data'] as List)
                .map((e) => HotelSearchCityModel.fromJson(e))
                .toList();
            return filteredCities;
          }
        } else {
          FunctionsUtils.toast(jsonData['message']);
          return [];
        }
      }
      return [];
    } on SocketException catch (e) {
      debugPrint("Error:-$e");
      throw "No Internet";
    }
  }

  void _searchCities(String cityName) {
    setState(() {
      _cities = getCityData(cityName);
    });
  }

  void _addRoomsSheet(BuildContext _) {
    showModalBottomSheet(
      backgroundColor: MyColors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (_, setState) => SizedBox(
            height: MediaQuery.of(context).size.height * .91,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(right: 150),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close),
                            ),
                            SizedBox(width: 10),
                            const Text(
                              'Rooms & Guest',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: MyColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            // print(rooms.length);
                            if (rooms.length < 10) {
                              _addRoom();
                            } else {
                              FunctionsUtils.toast("Max! room limit 10");
                            }
                            setState(() {});
                          },
                          child: const Text(
                            'Add Rooms',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MyColors.green,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12, right: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              totalGuests = calculateTotalGuests(rooms);
                            });
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 54, 82, 244),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // for (var room in rooms)
                          for (int i = 0; i < rooms.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(),
                              ),
                              margin: EdgeInsets.all(4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Room ${i + 1}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Guest ${rooms[i].adults + rooms[i].children}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  _buildTravellerItem(
                                    title: "Adults",
                                    subtitle: "Ages 12 or above",
                                    count: rooms[i].adults,
                                    onIncrement: (p0) {
                                      if (rooms[i].adults + rooms[i].children <
                                          4) {
                                        setState(() {
                                          rooms[i].adults++;
                                        });
                                      } else {
                                        FunctionsUtils.toast(
                                          'Maximum 4 guests per room allowed',
                                        );
                                      }
                                    },
                                    onDecrement: () {
                                      if (rooms[i].adults > 1) {
                                        setState(() {
                                          rooms[i].adults--;
                                        });
                                      }
                                    },
                                  ),
                                  _buildTravellerItem(
                                    title: "Childrens",
                                    subtitle: "Ages 1-12",
                                    count: rooms[i].children,
                                    onIncrement: (p0) {
                                      if (rooms[i].adults + rooms[i].children <
                                          4) {
                                        setState(() {
                                          rooms[i].children++;
                                          rooms[i].childrenAges = List.generate(
                                            rooms[i].children,
                                            (index) => 0,
                                          );
                                        });
                                      } else {
                                        FunctionsUtils.toast(
                                          'Maximum 4 guests per rooms allowed',
                                        );
                                      }
                                    },
                                    onDecrement: () {
                                      if (rooms[i].children > 0) {
                                        setState(() {
                                          rooms[i].children--;
                                          rooms[i].childrenAges = List.generate(
                                            rooms[i].children,
                                            (index) => 0,
                                          );
                                        });
                                      }
                                    },
                                  ),
                                  if (rooms[i].children > 0)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: List.generate(
                                        rooms[i].children,
                                        (index) {
                                          return DropdownButton<int>(
                                            value: rooms[i].childrenAges[index],
                                            items: List.generate(12, (index) {
                                              return DropdownMenuItem<int>(
                                                value: index,
                                                child: Text(
                                                  'child Age: ${index + 1}',
                                                ),
                                              );
                                            }),
                                            onChanged: (value) {
                                              setState(() {
                                                rooms[i].childrenAges[index] =
                                                    value ?? 1 + 1;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  if (rooms.toList().indexOf(rooms[i]) > 0 &&
                                      rooms.toList().indexOf(rooms[i]) <
                                          rooms.length)
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 4,
                                        right: 12,
                                        bottom: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          List<Room> roomList = rooms.toList();
                                          setState(() {});
                                          deleteRoom(
                                            roomList.indexOf(rooms[i]),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete_outline_rounded,
                                              color: Color.fromARGB(
                                                255,
                                                222,
                                                102,
                                                94,
                                              ),
                                              size: 18,
                                            ),
                                            SizedBox(width: 4),
                                            const Text(
                                              'Remove this room',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  222,
                                                  102,
                                                  94,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //------onIncrment and Decrement widget
  Widget _buildTravellerItem({
    required String title,
    required String subtitle,
    required int count,
    required Function(int) onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(subtitle, style: TextStyle(color: MyColors.grey)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  onDecrement();
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                count.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  onIncrement(count + 1);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //----count total number of rooms
  int calculateTotalGuests(List<Room> rooms) {
    List<Map<String, dynamic>> roomInfoList = [];
    int totalGuests = 0;
    for (var room in rooms) {
      totalGuests += room.adults + room.children;

      Map<String, dynamic> roomData = {
        'numberOfAdults': room.adults,
        'numberOfChild': room.children,
        'childAge': room.childrenAges,
      };
      roomInfoList.add(roomData);
    }
    Map<String, dynamic> data = {'roomInfo': roomInfoList};
    roomInfo = data;
    setState(() {});
    return totalGuests;
  }

  //----Add more rooms
  void _addRoom() {
    setState(() {
      rooms.add(Room());
    });
  }

  //----delete added rooms
  void deleteRoom(int index) {
    if (index > 0 && index < rooms.length) {
      Room deletedRoom = rooms.removeAt(index);
      totalGuests -= (deletedRoom.adults + deletedRoom.children);
      setState(() {});
    }
  }
}

class Room {
  int adults = 1;
  int children = 0;
  List<int> childrenAges = [];
}
