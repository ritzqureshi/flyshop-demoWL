import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikotech/src/data/model/BusModel/bus_city_search_model.dart';

import 'package:intl/intl.dart';
import '../common/api_services.dart';
import '../common/utils/colours.dart';
import '../common/utils/constant.dart';
import '../common/utils/functions.dart';
import '../common/widgets/my_button.dart';
import '../common/widgets/webview_wid.dart';

class BusesSearchScreen extends StatefulWidget {
  const BusesSearchScreen({super.key});

  @override
  State<BusesSearchScreen> createState() => _BusesSearchScreenState();
}

class _BusesSearchScreenState extends State<BusesSearchScreen>
    with SingleTickerProviderStateMixin {
  DateTime? checkinDate;
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  var fromCityData = {};
  var toCityData = {};
  var cityDataaa = {};
  List<BusSearchCityModel> filteredCities = [];
  List<BusSearchCityModel> searchCities = [];
  bool isSearching = false;
  bool disposed = false;
  // WebNavigation webNavigation = WebNavigation(
  //   navigatorKey.currentState!.context,
  // );
  AnimationController? controller;
  Animation<double>? animation;
  @override
  void initState() {
    checkinDate = DateTime.now();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
    )..repeat();
    animation = Tween<double>(begin: 0, end: pi).animate(controller!);
    controller!.forward(from: 0.0);
    super.initState();
  }

  //-----Rotate icon with reverse From to TO------//
  void swapCities() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        String temp = fromCityController.text;
        var tempValueData = fromCityData;
        fromCityController.text = toCityController.text;
        toCityController.text = temp;
        fromCityData = toCityData;
        toCityData = tempValueData;
      });
    });
  }

  void _rotateIcon() {
    if (!controller!.isAnimating) {
      controller!.reset();
      controller!.forward();
    }
    setState(() {});
    controller!.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void filterCities(String query) async {
    // setState(() {
    //   searchCities = filteredCities
    //       .where(
    //         (city) => city.name!.toLowerCase().contains(query.toLowerCase()),
    //       )
    //       .toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              commonCityController(
                'FROM',
                fromCityController,
                fromCityData,
                MediaQuery.of(context).size.width * 0.4,
                const EdgeInsets.only(left: 15, bottom: 30),
              ),

              Container(
                // color: Colors.red,
                margin: EdgeInsets.only(
                  left:
                      MediaQuery.of(context).size.width *
                      0.0, // Adjust left position
                  bottom: 30, // Adjust top position
                ),
                height: (36),
                width: (36),
                child: GestureDetector(
                  onTap: () {
                    _rotateIcon();
                    swapCities();
                  },
                  child: AnimatedBuilder(
                    animation: controller!,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: animation!.value,
                        child: Container(
                          height: (36),
                          width: (36),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: MyColors.primaryColorOfApp,
                          ),
                          child: const Icon(
                            Icons.repeat_rounded,
                            color: MyColors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              //----- TO controller------//
              commonCityController(
                'TO',
                toCityController,
                toCityData,
                MediaQuery.of(context).size.width * 0.4,
                const EdgeInsets.only(left: 15, bottom: 30),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: commonDatepicker(
            'DEPARTURE DATE',
            checkinDate,
            () {
              departureDatePicker();
            },
            MediaQuery.of(context).size.width * 0.93,
            const EdgeInsets.only(left: 15),
          ),
        ),
        // -------Search button-------//
        Container(
          alignment: Alignment.center,
          child: MyButton(
            backgroundColor: MyColors.primaryColorOfApp,
            margin: const EdgeInsets.only(top: 27),
            onClick: () {
              getLog(fromCityData, "fromCityData");
              getLog(toCityData, "toCityData");
              dynamic urlToUse =
                  "${Constant.baseUrl}mob/search-buses?fromCityBus=${fromCityData['city_name']}&city_Code=${fromCityData['city_id']}&toCityBus=${toCityData['city_name']}&city_CodeDes=${toCityData['city_id']}&traveldate=${DateFormat('dd-MM-yyyy').format(checkinDate ?? DateTime.now())}";
              onSearchHotel({"urlToUse": urlToUse});
            },
            btnTxt: "Search",
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
    );
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

  //----Common TextField-----//
  Widget commonCityController(
    String title,
    TextEditingController textController,
    dynamic data,
    double customWidth,
    EdgeInsetsGeometry? customMargin,
  ) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        margin: customMargin,
        width: customWidth,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fieldTitle(title),
            SizedBox(
              width: customWidth,
              height: 44,
              child: TextFormField(
                controller: textController,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  if (fromCityController.text.isEmpty && title == "TO") {
                    FunctionsUtils.toast("Please select From city!!");
                  } else {
                    _openFullBottomSheet(context, title, textController, data);
                  }
                },
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'City',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            strokeLine(customWidth),
          ],
        ),
      ),
    );
  }

  //----Common Datepicker-----//
  Widget commonDatepicker(
    String title,
    DateTime? dateElement,
    Function()? ontap,
    double customWidth,
    EdgeInsetsGeometry? customMargin,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: customMargin,
        width: customWidth,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fieldTitle(title),
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      DateFormat("d-MMM-yyyy").format(dateElement!),
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
            strokeLine(customWidth),
          ],
        ),
      ),
    );
  }

  //-----FieldTitile----//
  Widget fieldTitle(String title) {
    return SizedBox(
      height: 14, // Same height as above
      child: Text(title, style: const TextStyle(fontSize: 11)),
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

  //---DatePicker
  void departureDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        checkinDate = value;
      });
      // print(departureDate);
    });
  }

  //----get All City from api
  Future<void> getCityData(String query) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = "${Constant.busCitySearchApi}$query";
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final jsonData = (response.data);
        filteredCities = (jsonData['data'] as List)
            .map((e) => BusSearchCityModel.fromJson(e))
            .toList();
      } else {
        FunctionsUtils.toast("Please try again!");
      }
    } on SocketException catch (e) {
      debugPrint("Error:-$e");
      throw "No Internet";
    }
  }

  void _openFullBottomSheet(
    BuildContext context,
    String title,
    TextEditingController textContro,
    var cityData,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Set to true for full-screen mode
      isDismissible: true, // Set to false to prevent dismissing by swiping
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
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
                      onChanged: (val) async {
                        if (val.isNotEmpty) {
                          setState(() {
                            isSearching = true;
                          });
                          await getCityData(val);

                          if (!disposed) {
                            setState(() {
                              isSearching = false;
                            });
                          }
                        }
                        // filterCities(val);
                        // print(val);
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
                              child: ListView.separated(
                                itemCount: filteredCities.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 3,
                                      color: MyColors.grey,
                                      thickness: .4,
                                    ),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      filteredCities[index].cityName.toString(),
                                      style: const TextStyle(
                                        color: MyColors.black,
                                        fontSize: 14,
                                      ),
                                    ),

                                    onTap: () {
                                      textContro.text =
                                          filteredCities[index].cityName!;
                                      setState(() {
                                        cityData = filteredCities[index]
                                            .toJson();
                                        if (title == "FROM") {
                                          fromCityData = cityData;
                                          getLog(fromCityData, "fromCityData");
                                        } else {
                                          toCityData = cityData;
                                          getLog(toCityData, "toCityData");
                                        }
                                      });

                                      // print('Selected city: $cityData');
                                      Navigator.of(context).pop();
                                    },
                                  );
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
    );
  }
}
