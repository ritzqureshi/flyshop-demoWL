// import 'package:flutter/material.dart';
// import 'package:ikotech/src/common/utils/colours.dart';
// import 'package:ikotech/src/common/widgets/my_button.dart';
// import 'package:intl/intl.dart';

// class MultiCityFlightForm extends StatefulWidget {
//   const MultiCityFlightForm({super.key});

//   @override
//   _MultiCityFlightFormState createState() => _MultiCityFlightFormState();
// }

// class _MultiCityFlightFormState extends State<MultiCityFlightForm> {
//   List<Map<String, String>> tripSegments = [
//     {'from': '', 'to': '', 'date': DateTime.now().toIso8601String()},
//   ];

//   final int maxSegments = 5;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Expanded(
//         //   child: ListView.builder(
//         //     itemCount: tripSegments.length,
//         //     itemBuilder: (context, index) {
//         //       return buildTripSegment(index);
//         //     },
//         //   ),
//         // ),
//         // ...tripSegments.asMap().entries.map((entry) {
//         //   int index = entry.key;
//         //   return buildTripSegment(index);
//         // }),
//         SingleChildScrollView(
//   child: Column(
//     children: [
//       ...tripSegments.asMap().entries.map((entry) {
//         int index = entry.key;
//         return buildTripSegment(index);
//       }).toList(),
//     ],
//   ),
// ),
//         buildAddButton(),
//         SizedBox(height: 16),
//         Container(
//           alignment: Alignment.center,
//           child: MyButton(
//             backgroundColor: MyColors.primaryColorOfApp,
//             margin: const EdgeInsets.only(top: 27),
//             onClick: () {
//               // String fromCity = fromCityController.text;
//               // String toCity = toCityController.text;
//               // if (fromCity.isEmpty) {
//               //   FunctionsUtils.toast("Please enter from city");
//               //   return;
//               // } else if (toCity.isEmpty) {
//               //   FunctionsUtils.toast("Please enter to city");
//               //   return;
//               // } else if (fromCity == toCity) {
//               //   FunctionsUtils.toast("From city and To City cant be same");
//               //   return;
//               // } else if (_isRoundTripSelected && returnDate == null) {
//               //   if (returnDate == null) {
//               //     FunctionsUtils.toast("Please select return date");
//               //     return;
//               //   }
//               // } else if (totalTravellers == 0) {
//               //   FunctionsUtils.toast("Please select Traveller");
//               //   return;
//               // } else {
//               //   String tripType = '';
//               //   String classType = '';
//               //   if (_isOneWaySelected) {
//               //     tripType = "1";
//               //   } else if (_isRoundTripSelected) {
//               //     tripType = "2";
//               //   }
//               //   if (dropClassValue == 'Economy') {
//               //     classType = "2";
//               //   } else if (dropClassValue == 'Premium Economy') {
//               //     classType = "3";
//               //   } else if (dropClassValue == 'Business') {
//               //     classType = '4';
//               //   } else if (dropClassValue == 'Premium Business') {
//               //     classType = '5';
//               //   } else {
//               //     classType = '6';
//               //   }
//               //   setState(() {});
//               // Map<String, dynamic> payload = {
//               //   "fromCity": fromCityData,
//               //   "toCity": toCityData,
//               //   "departureDate": DateTime(
//               //     departureDate!.year,
//               //     departureDate!.month,
//               //     departureDate!.day,
//               //   ).toIso8601String(),
//               //   "returnDate": (_isOneWaySelected)
//               //       ? DateTime(
//               //           departureDate!.year,
//               //           departureDate!.month,
//               //           departureDate!.day,
//               //         ).toIso8601String()
//               //       : DateTime(
//               //           returnDate!.year,
//               //           returnDate!.month,
//               //           returnDate!.day,
//               //         ).toIso8601String(),
//               //   "class": classType,
//               //   "adults": adultsCount,
//               //   "children": childrenCount,
//               //   "infant": infantsCount,
//               //   "directFlight": _isDirectFlight,
//               //   "fares": selectedFaresValue,
//               //   "tripType": tripType,
//               //   "device": "app",
//               // };
//               // print(payload);
//               // onSearchFlight(payload);
//             },
//             btnTxt: "Search",
//             btnTextStyle: TextStyle(
//               fontSize: (20),
//               color: MyColors.white,
//               fontWeight: FontWeight.w600,
//             ),
//             width: 250,
//             height: 50,
//             elevation: 0,
//           ),
//         ),
//       ],
//     );
//   }

//   void onSearchFlight(Map<String, dynamic> payload) {}

//   // Widget buildTripSegment(int index) {
//   //   return Card(
//   //     margin: EdgeInsets.all(10),
//   //     child: Padding(
//   //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//   //       child: Column(
//   //         children: [
//   //           Row(
//   //             children: [
//   //               Expanded(child: buildTextField("From", index, 'from')),
//   //               SizedBox(width: 10),
//   //               Expanded(child: buildTextField("To", index, 'to')),
//   //               if (tripSegments.length > 1)
//   //                 IconButton(
//   //                   icon: Icon(Icons.close),
//   //                   onPressed: () {
//   //                     setState(() {
//   //                       tripSegments.removeAt(index);
//   //                     });
//   //                   },
//   //                 ),
//   //             ],
//   //           ),
//   //           Row(
//   //             children: [
//   //               Expanded(child: buildTextField("Departure", index, 'date')),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget buildTripSegment(int index) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildLocationRow(
//               "FROM",
//               tripSegments[index]['from'] ?? "",
//               Icons.flight_takeoff,
//             ),
//             Divider(),
//             buildLocationRow(
//               "TO",
//               tripSegments[index]['to'] ?? "",
//               Icons.flight_land,
//             ),
//             Divider(),
//             buildDateRow(index),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDateRow(int index) {
//     return InkWell(
//       onTap: () async {
//         final DateTime? picked = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime.now().add(Duration(days: 365)),
//         );
//         if (picked != null) {
//           setState(() {
//             tripSegments[index]['date'] = picked.toString();
//           });
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Row(
//           children: [
//             Icon(Icons.calendar_today, color: Colors.amber),
//             SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "From",
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   tripSegments[index]['date'] != null
//                       ? DateFormat(
//                           'd, MMM yyyy',
//                         ).format(DateTime.parse(tripSegments[index]['date']!))
//                       : "Select Date",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildLocationRow(String label, String value, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.amber),
//         SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
//             SizedBox(height: 4),
//             Text(
//               value.isNotEmpty ? value : "Select City",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildTextField(String label, int index, String key) {
//     return TextFormField(
//       decoration: InputDecoration(labelText: label),
//       initialValue: tripSegments[index][key],
//       onChanged: (value) {
//         setState(() {
//           tripSegments[index][key] = value;
//         });
//       },
//     );
//   }

//   Widget buildAddButton() {
//     return tripSegments.length < maxSegments
//         ? ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 tripSegments.add({
//                   'from': '',
//                   'to': '',
//                   'date': DateTime.now().toIso8601String(),
//                 });
//               });
//             },
//             child: Text("+"),
//           )
//         : SizedBox.shrink();
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../data/model/FlightModel/flight_search_city_model.dart';
import '../api_services.dart';
import '../utils/colours.dart';
import '../utils/constant.dart';
import '../utils/functions.dart';

class MultiCityFlightForm extends StatefulWidget {
  @override
  _MultiCityFlightFormState createState() => _MultiCityFlightFormState();
}

class _MultiCityFlightFormState extends State<MultiCityFlightForm> {
  // List<Map<String, dynamic>> tripSegments = [];
List<Map<String, dynamic>> tripSegments = [
  {
    'from': TextEditingController(),
    'to': TextEditingController(),
    'date': DateTime.now(),
  },
  
];
  String selectedClass = 'ECONOMY';
  int totalPassengers = 1;
  List<FLightSearchCityModel> filteredCities = [];

  Map<String, dynamic> fromCityData = {
    'AirportCode': 'DEL',
    'CityID': 7701,
    'ContSysId': 101,
    'label': 'Delhi, IN - Delhi Indira Gandhi Intl (DEL), India',
  };
  Map<String, dynamic> toCityData = {
    'AirportCode': 'BOM',
    'CityID': 18676,
    'ContSysId': 101,
    'label': 'Mumbai, IN - Chhatrapati Shivaji (BOM), India',
  };

  @override
  void initState() {
    super.initState();
    addNewSegment(); // Initial segment
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...tripSegments.asMap().entries.map((entry) {
            return buildSegmentRow(entry.key);
          }).toList(),
        ],
      ),
    );
  }

  void addNewSegment() {
    if (tripSegments.length >= 5) return;
    setState(() {
      tripSegments.add({
        'from': TextEditingController(),
        'to': TextEditingController(),
        'date': DateTime.now(),
      });
    });
  }

  void removeSegment(int index) {
    setState(() {
      tripSegments.removeAt(index);
    });
  }

  Widget buildSegmentRow(int index) {
    final segment = tripSegments[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: buildCityInput("From", segment['from'])),
                  SizedBox(width: 10),
                  Expanded(child: buildCityInput("To", segment['to'])),
                  if (index == 0) SizedBox(width: 10),
                  if (index == 0)
                    Expanded(child: buildPassengerAndClassDropdown()),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: buildDatePicker(index)),
                  SizedBox(width: 8),
                  if (index == tripSegments.length - 1)
                    Row(
                      children: [
                        if (tripSegments.length < 5)
                          IconButton(
                            icon: Icon(Icons.add_circle, color: Colors.green),
                            onPressed: addNewSegment,
                          ),
                        if (tripSegments.length > 2)
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () => removeSegment(index),
                          ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCityInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Select Destination City",
            suffixIcon: Icon(Icons.location_on_outlined, size: 20),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget buildDatePicker(int index) {
    final date = tripSegments[index]['date'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Departure",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                tripSegments[index]['date'] = picked;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16),
                SizedBox(width: 10),
                Text(
                  DateFormat('dd/MM/yyyy').format(date),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassengerAndClassDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Passenger & Class",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: "$totalPassengers, $selectedClass",
              items: [
                DropdownMenuItem(
                  value: "1, ECONOMY",
                  child: Text("1, ECONOMY"),
                ),
                DropdownMenuItem(
                  value: "2, BUSINESS",
                  child: Text("2, BUSINESS"),
                ),
                DropdownMenuItem(value: "3, FIRST", child: Text("3, FIRST")),
              ],
              onChanged: (val) {
                setState(() {
                  final parts = val!.split(',');
                  totalPassengers = int.parse(parts[0]);
                  selectedClass = parts[1].trim();
                });
              },
            ),
          ),
        ),
      ],
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
              margin: title != "To" ? const EdgeInsets.only(left: 35) : null,
              child: Text(title),
            ),
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: const Image(
                      height: 23,
                      color: MyColors.primaryColorOfApp,
                      image: AssetImage('assets/icons/calendar.png'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      DateFormat("d, MMM yyyy").format(dateElement!),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.grey,
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
          Text(title),
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

  //-----Bottom sheet for select city-------//
  void _openFullBottomSheet(
    BuildContext context,
    String title,
    TextEditingController textContro,
    Map<String, dynamic> cityData,
    Function(dynamic) onUpdate,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Set to true for full-screen mode
      isDismissible: true, // Set to false to prevent dismissing by swiping
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => SizedBox(
            height: MediaQuery.of(context).size.height * .9,
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
                        hintText: title,
                        border: InputBorder.none,
                      ),
                      onChanged: (val) async {
                        // if (val.isNotEmpty) {
                        await getCityData(val);
                        setState(() {});
                        // } else {
                        //   getLog(textContro.text, "textContro.text");
                        //   await getCityData(textContro.text);
                        //   setState(() {});
                        // }

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

                (filteredCities.isNotEmpty && textContro.text.isNotEmpty)
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: ListView.separated(
                            itemCount: filteredCities.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final city = filteredCities[index];
                              return GestureDetector(
                                onTap: () {
                                  textContro.text =
                                      '${FunctionsUtils.truncateTextToDot(city.city ?? '', 1)}-${city.airportCode}';
                                  setState(() {
                                    cityData = city.toJson();
                                  });
                                  if (title == "From") {
                                    fromCityData = cityData;
                                  } else {
                                    toCityData = cityData;
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.02),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Colored Airport Code Badge
                                      Container(
                                        width: 52,
                                        height: 52,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: MyColors.primaryColorOfApp,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          city.airportCode ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // City and Airport Name
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              city.city ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              city.airportDescription ?? '',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Country Flag (if available)
                                      if (city.getCountryFlag != null &&
                                          (city
                                                  .getCountryFlag
                                                  ?.flag
                                                  ?.isNotEmpty ??
                                              false))
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          child: SvgPicture.network(
                                            "https://flybtc.blr1.digitaloceanspaces.com/ncl/flags/${city.getCountryFlag?.flag}",
                                            height: 28,
                                            width: 42,
                                            fit: BoxFit.cover,
                                            placeholderBuilder: (context) =>
                                                const CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ),
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                                      Icons.image_not_supported,
                                                      size: 24,
                                                      color: Colors.grey,
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

  Future<void> getCityData(String query) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = "${Constant.flightCitySearchApi}$query";
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final jsonData = (response.data);
        if (jsonData['status']) {
          if (jsonData != null) {
            filteredCities = (jsonData['data'] as List)
                .map((e) => FLightSearchCityModel.fromJson(e))
                .toList();
          }
        } else {
          FunctionsUtils.toast(jsonData['message']);
          filteredCities = [];
        }
      }
    } on SocketException catch (e) {
      debugPrint("Error:-$e");
      throw "No Internet";
    }
  }
}
