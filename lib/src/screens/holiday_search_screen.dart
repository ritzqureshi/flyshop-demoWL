import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/functions.dart';
import 'package:ikotech/src/data/model/HolidayModel/holiday_search_city_m.dart';

import '../common/api_services.dart';
import '../common/utils/colours.dart';
import '../common/utils/constant.dart';
import '../common/widgets/my_button.dart';
import '../common/widgets/webview_wid.dart';

class HolidaySearchScreen extends StatefulWidget {
  const HolidaySearchScreen({super.key});

  @override
  State<HolidaySearchScreen> createState() => _HolidaySearchScreenState();
}

class _HolidaySearchScreenState extends State<HolidaySearchScreen> {
  TextEditingController holidayCityController = TextEditingController();
  var cityDataaa = {};
  List<HolidaySearchCityModel> filteredCities = [];
  List<HolidaySearchCityModel> searchCities = [];
  bool isSearching = false;
  bool disposed = false;
  bool isLoading = true;

  // WebNavigation webNavigation =
  //     WebNavigation(navigatorKey.currentState!.context);
  @override
  void initState() {
    super.initState();
    getCityData("d");
  }

  void filterCities(String query) async {
    setState(() {
      searchCities = filteredCities
          .where(
            (city) =>
                city.location!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
    setState(() {});
  }

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
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 14, // Same height as above
                            child: Text(
                              'HOLIDAY',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: holidayCityController,
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () {
                                    _openFullBottomSheet(
                                      context,
                                      "Enter",
                                      holidayCityController,
                                      cityDataaa,
                                    );
                                  },
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    hintText: 'Where you want to go?',
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
                    dynamic urlTouse =
                        "${Constant.baseUrl}mob/holiday-search?location=${cityDataaa['location']}";
                    onSearchHoliday({"urlToUse": urlTouse});
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  //-----on search flight-----
  void onSearchHoliday(Map<String, dynamic> request) async {
    final safeUrl = Uri.encodeFull(request['urlToUse']);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWebviewWidget(title: "", urlToUse: safeUrl), //
      ),
    );
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
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Search Field
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                            setState(() => isSearching = true);
                            filterCities(val);
                            if (!disposed) {
                              setState(() => isSearching = false);
                            }
                          }
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                          textContro.clear();
                        },
                      ),
                    ),
                  ),

                  // Loading or List
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : (searchCities.isNotEmpty &&
                              textContro.text.trim().isNotEmpty)
                        ? ListView.separated(
                            itemCount: searchCities.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 3,
                              color: MyColors.grey,
                              thickness: .4,
                            ),
                            itemBuilder: (context, index) {
                              final city = searchCities[index];
                              return ListTile(
                                title: Text(
                                  city.location ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {
                                  textContro.text = city.location ?? '';
                                  setState(() {
                                    cityDataaa = city.toJson();
                                  });
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          )
                        : ListView.separated(
                            itemCount: filteredCities.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 3,
                              color: MyColors.grey,
                              thickness: .4,
                            ),
                            itemBuilder: (context, index) {
                              final city = filteredCities[index];
                              return ListTile(
                                title: Text(
                                  city.location ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {
                                  textContro.text = city.location ?? '';
                                  setState(() {
                                    cityDataaa = city.toJson();
                                  });
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> getCityData(String query) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl =
          "${Constant.holidayCitySearchApi}$query&wlid=${Constant.wlID}";
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        filteredCities = (response.data['data'] as List)
            .map((e) => HolidaySearchCityModel.fromJson(e))
            .toList();
      } else {
        FunctionsUtils.toast("Please try after again!");
      }
    } on SocketException catch (e) {
      debugPrint("Error:-$e");
      throw "No Internet";
    } finally {
      if (!disposed) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
