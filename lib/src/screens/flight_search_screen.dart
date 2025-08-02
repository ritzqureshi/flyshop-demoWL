import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikotech/src/common/utils/colours.dart';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/widgets/custom_datepicker.dart';
import 'package:ikotech/src/common/widgets/multi_city_form_wid.dart';
import 'package:intl/intl.dart';

import '../common/api_services.dart';
import '../common/utils/functions.dart';
import '../common/widgets/my_button.dart';
import '../common/widgets/webview_wid.dart';
import '../data/model/FlightModel/flight_search_city_model.dart';

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({super.key});

  @override
  State<FlightSearchScreen> createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen>
    with SingleTickerProviderStateMixin {
  int? selectedFaresValue; // Holds the value of the selected radio button
  bool _isDirectFlight = false;
  bool _isOneWaySelected = false;
  bool _isMultiCitySelected = false;
  bool _isRoundTripSelected = false;
  List<String> dropdownClass = [
    'Economy',
    'Premium Economy',
    'Business',
    'Premium Business',
    'First',
  ];
  String? dropClassValue;
  DateTime? departureDate;
  DateTime? returnDate;
  int adultsCount = 1;
  int childrenCount = 0;
  int infantsCount = 0;
  int totalTravellers = 1;
  String? agenUserrId = "";
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  TripType _selectedTrip = TripType.oneWay;

  Map<String, dynamic> fromCityData = {
    "city": "DELHI",
    "country": "India",
    "airportCode": "DEL",
    "airportDescription": "Indira Gandhi International Airport",
    "id": "67013cb8f639054e08242ad6",
    "get_country_flag": {
      "country": "India",
      "flag": "kNoAncX2JgAtbufc6d4qGuQsBsPLjNsNnSOr8yMI.svg",
      "updated_at": "2024-10-09T05:00:22.088000Z",
      "created_at": "2024-10-09T05:00:22.088000Z",
      "id": "67060de6e21d3f116005d4a2",
    },
  };
  Map<String, dynamic> toCityData = {
    "city": "MUMBAI",
    "country": "India",
    "airportCode": "BOM",
    "airportDescription": "Chhatrapati Shivaji International Airport",
    "id": "67013cb8f639054e08242acf",
    "get_country_flag": {
      "country": "India",
      "flag": "kNoAncX2JgAtbufc6d4qGuQsBsPLjNsNnSOr8yMI.svg",
      "updated_at": "2024-10-09T05:00:22.088000Z",
      "created_at": "2024-10-09T05:00:22.088000Z",
      "id": "67060de6e21d3f116005d4a2",
    },
  };
  List<FLightSearchCityModel> filteredCities = [];

  AnimationController? controller;
  Animation<double>? animation;
  bool isSearching = false;
  bool disposed = false;

  @override
  void initState() {
    // getCityData();
    selectedFaresValue = 1;
    _isOneWaySelected = true;
    dropClassValue = dropdownClass[0];
    departureDate = DateTime.now().add(const Duration(days: 1));
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
    )..repeat();
    animation = Tween<double>(begin: 0, end: pi).animate(controller!);
    controller!.forward(from: 0.0);
    fromCityController.text = 'DELHI-DEL';
    toCityController.text = 'MUMBAI-BOM';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<TripType>(
                    value: TripType.oneWay,
                    groupValue: _selectedTrip,
                    activeColor: MyColors.primaryColorOfApp,
                    onChanged: (TripType? value) {
                      setState(() {
                        _selectedTrip = value!;
                        _isRoundTripSelected = false;
                        returnDate = departureDate;
                        _isOneWaySelected = true;
                        _isMultiCitySelected = false;
                      });
                    },
                  ),
                  const Text('One Way', style: TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  Radio<TripType>(
                    value: TripType.roundTrip,
                    groupValue: _selectedTrip,
                    activeColor: MyColors.primaryColorOfApp,
                    onChanged: (TripType? value) {
                      setState(() {
                        _selectedTrip = value!;
                        _isRoundTripSelected = true;
                        returnDate = departureDate;
                        _isMultiCitySelected = false;
                        _isOneWaySelected = false;
                      });
                    },
                  ),
                  const Text('Round Trip', style: TextStyle(fontSize: 12)),
                ],
              ),
              // Row(
              //   children: [
              //     Radio<TripType>(
              //       value: TripType.multiCity,
              //       groupValue: _selectedTrip,
              //       activeColor: MyColors.primaryColorOfApp,
              //       onChanged: (TripType? value) {
              //         setState(() {
              //           _selectedTrip = value!;
              //           _isMultiCitySelected = true;
              //           _isRoundTripSelected = false;
              //           _isOneWaySelected = false;
              //         });
              //       },
              //     ),
              //     const Text('Multi City', style: TextStyle(fontSize: 12)),
              //   ],
              // ),
            ],
          ),
        ),
        (!_isMultiCitySelected)
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          child: const Image(
                            height: 30,
                            color: MyColors.primaryColorOfApp,
                            image: AssetImage('assets/icons/takeoff.png'),
                          ),
                        ),
                        commonCityController(
                          'FROM',
                          fromCityController,
                          fromCityData,
                          MediaQuery.of(context).size.width *
                              0.7, // Set a fraction of the width
                          const EdgeInsets.only(left: 0),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          child: const Image(
                            height: 30,
                            color: MyColors.primaryColorOfApp,
                            image: AssetImage('assets/icons/land.png'),
                          ),
                        ),
                        commonCityController(
                          'TO',
                          toCityController,
                          toCityData,
                          MediaQuery.of(context).size.width * 0.7,
                          const EdgeInsets.only(left: 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Row(
                      children: [
                        //-----Date Picker DEPARTURE-----//
                        Expanded(
                          child: commonDatepicker(
                            'From',
                            departureDate,
                            () async {
                              await showCustomDatePicker(
                                context,
                                departureDate!,
                                'Select From Date',
                              ).then((onValue) {
                                setState(() {
                                  departureDate = onValue;
                                  // if (departureDate!.isAfter(returnDate!) ||
                                  //     departureDate!.isAtSameMomentAs(returnDate!)) {
                                  //   // returnDate = departureDate;
                                  //   returnDate = departureDate!.add(
                                  //     const Duration(days: 1),
                                  //   );
                                  // }
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
                            'To',
                            returnDate,
                            () async {
                              setState(() {
                                // _wayTypeSelected = 2;
                                _isRoundTripSelected = true;
                              });
                              await showCustomDatePicker(
                                context,
                                returnDate ?? departureDate!,
                                'Return Date',
                                minimumDate: departureDate,
                              ).then((onValue) {
                                setState(() {
                                  returnDate = onValue;
                                });
                              });
                              // returnDatePicker();
                              // setState(() {
                              //   _isRoundTripSelected = true;
                              //   _isOneWaySelected = false;
                              // });
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
                  Divider(endIndent: 70, indent: 50),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          child: Icon(
                            Icons.chair_outlined,
                            color: MyColors.primaryColorOfApp,
                          ),
                        ),

                        //-------Class Typeeeee-----//
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 23),
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              fieldTitle('Class'),
                              SizedBox(
                                height: 44,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropClassValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // iconSize: 34,
                                    elevation: 16,
                                    isExpanded: true,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropClassValue = newValue!;
                                      });
                                    },
                                    items: dropdownClass
                                        .map<DropdownMenuItem<String>>((
                                          String value,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        })
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //---------Add Travellers -----//
                        Expanded(
                          child: GestureDetector(
                            onTap: showAddTravellersDialog,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, top: 23),
                              width: MediaQuery.of(context).size.width * 0.40,
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

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      fieldTitle('TRAVELLERS'),
                                      SizedBox(
                                        height: 44,
                                        child: Row(
                                          children: [
                                            Text(
                                              totalTravellers.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const Text(
                                              " PAX",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(endIndent: 70, indent: 50),

                  //-------direct flight and fares-----//
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 25,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: _isDirectFlight,
                        //       onChanged: _toggleDirectFli,
                        //       activeColor: MyColors.blue,
                        //     ),
                        //     const Text('Direct Flight', style: TextStyle(fontSize: 13)),
                        //   ],
                        // ),
                        Row(
                          children: [
                            const Text(
                              'Select a special fare',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFaresValue = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedFaresValue == 1
                                          ? MyColors.primaryColorOfApp
                                          : null,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 0,
                                      ),
                                      child: Text(
                                        'Regular',
                                        style: TextStyle(
                                          color: (selectedFaresValue == 1)
                                              ? MyColors.white
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFaresValue = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedFaresValue == 2
                                          ? MyColors.primaryColorOfApp
                                          : null,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 7,
                                      ),
                                      child: Text(
                                        'Student',
                                        style: TextStyle(
                                          color: (selectedFaresValue == 2)
                                              ? MyColors.white
                                              : MyColors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFaresValue = 3;
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedFaresValue == 3
                                          ? MyColors.primaryColorOfApp
                                          : null,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 0,
                                      ),
                                      child: Text(
                                        'Sr. Citizen',
                                        style: TextStyle(
                                          color: (selectedFaresValue == 3)
                                              ? MyColors.white
                                              : MyColors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.035,
                                        ),
                                      ),
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
                  Container(
                    alignment: Alignment.center,
                    child: MyButton(
                      backgroundColor: MyColors.primaryColorOfApp,
                      margin: const EdgeInsets.only(top: 27),
                      onClick: () {
                        String fromCity = fromCityController.text;
                        String toCity = toCityController.text;
                        if (fromCity.isEmpty) {
                          FunctionsUtils.toast("Please enter from city");
                          return;
                        } else if (toCity.isEmpty) {
                          FunctionsUtils.toast("Please enter to city");
                          return;
                        } else if (fromCity == toCity) {
                          FunctionsUtils.toast(
                            "From city and To City cant be same",
                          );
                          return;
                        } else if (_isRoundTripSelected && returnDate == null) {
                          if (returnDate == null) {
                            FunctionsUtils.toast("Please select return date");
                            return;
                          }
                        } else if (totalTravellers == 0) {
                          FunctionsUtils.toast("Please select Traveller");
                          return;
                        } else {
                          String tripType = '';
                          String fareValue = "";
                          if (_isOneWaySelected) {
                            tripType = "one-way";
                          } else if (_isRoundTripSelected) {
                            tripType = "two-way";
                          }

                          if (selectedFaresValue == 1) {
                            fareValue = "REGULAR";
                          } else if (selectedFaresValue == 1) {
                            fareValue = "STUDENT";
                          } else if (selectedFaresValue == 1) {
                            fareValue = "SENIOR_CITIZEN";
                          }
                          String classType = dropClassValue
                              .toString()
                              .replaceAll(' ', '_')
                              .toUpperCase();

                          setState(() {});
                          String urlToUse =
                              "${Constant.baseUrl}flight-search-page?platform=mobile&tripType=$tripType&fromcitydesti=${fromCityData['airportCode']}+-+${fromCityData['city']}&fromContry=${fromCityData['country']}&tocitydesti=${toCityData['airportCode']}+-+${toCityData['city']}&toContry=${toCityData['country']}&journeyDateOne=${DateFormat("dd-MM-yyyy").format(departureDate!)}&journeyDateRound=${DateFormat("dd-MM-yyyy").format(_isOneWaySelected ? departureDate! : returnDate!)}&ADT=$adultsCount&CHD=$childrenCount&INF=$infantsCount&travel_class=$classType&pft=$fareValue";
                          Map<String, dynamic> payload = {
                            "fromCity": fromCityData,
                            "toCity": toCityData,
                            "departureDate": DateTime(
                              departureDate!.year,
                              departureDate!.month,
                              departureDate!.day,
                            ).toIso8601String(),
                            "returnDate": (_isOneWaySelected)
                                ? DateTime(
                                    departureDate!.year,
                                    departureDate!.month,
                                    departureDate!.day,
                                  ).toIso8601String()
                                : DateTime(
                                    returnDate!.year,
                                    returnDate!.month,
                                    returnDate!.day,
                                  ).toIso8601String(),
                            "class": classType,
                            "adults": adultsCount,
                            "children": childrenCount,
                            "infant": infantsCount,
                            "directFlight": _isDirectFlight,
                            "fares": selectedFaresValue,
                            "tripType": tripType,
                            "device": "app",
                            "urlToUse": urlToUse,
                          };

                          // print(payload);
                          getLog(payload['urlToUse'], "urlToUse");

                          onSearchFlight(payload);
                        }
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
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: MultiCityFlightForm(),
              ),
      ],
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
                    if (fromCityController.text.isEmpty &&
                        title == "GOING TO") {
                      FunctionsUtils.toast(
                        "Please select Departure city first!!",
                      );
                    } else {
                      _openFullBottomSheet(
                        context,
                        title,
                        textController,
                        data,
                        (updatedData) {
                          setState(() {
                            data = updatedData;
                          });
                        },
                      );
                    }
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
              child: fieldTitle(title),
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
                      title == "To" &&
                              (!_isRoundTripSelected || dateElement == null)
                          ? "+ SELECT"
                          : DateFormat("d, MMM yyyy").format(dateElement!),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            title == "To" &&
                                (!_isRoundTripSelected || dateElement == null)
                            ? MyColors.grey
                            : null,
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
      height: (14), // Same height as above
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, color: MyColors.grey),
      ),
    );
  }

  //Radio button onHandle
  void handleRadioValueChange(int? value) {
    setState(() {
      selectedFaresValue = value; // Update the selected radio button value
    });
  }

  //toggle _isDirectFlight
  void _toggleDirectFli(bool? value) {
    setState(() {
      _isDirectFlight = value ?? false;
    });
  }

  //---DatePicker
  void departureDatePicker() {
    showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: departureDate!,
      lastDate: DateTime(3000),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        departureDate = value;
        if (_isRoundTripSelected) {
          returnDate = departureDate;
        }
      });
      // print(departureDate);
    });
  }

  //---DatePicker
  void returnDatePicker() {
    showDatePicker(
      context: context,
      initialDate: returnDate ?? departureDate!,
      firstDate: departureDate!,
      lastDate: DateTime(3000),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        returnDate = value;
      });
      // print(returnDate);
    });
  }

  //--------Dialog box for add travellers--------//
  void showAddTravellersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: MyColors.white,
            title: const Text(
              'Select Travelers',
              style: TextStyle(fontSize: 16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTravellerItem(
                  title: 'Adults(12+ yrs)',
                  count: adultsCount,
                  onIncrement: (int count) {
                    if ((childrenCount + count) <= 9) {
                      setState(() {
                        adultsCount = count;
                      });
                    } else {
                      FunctionsUtils.toast("Max. 9 pax only!");
                    }
                  },
                  onDecrement: () {
                    if (adultsCount > 1) {
                      setState(() {
                        if (infantsCount == adultsCount) {
                          infantsCount--;
                        }
                        adultsCount--;
                      });
                    }
                  },
                ),
                _buildTravellerItem(
                  title: 'Children(2-12 yrs)',
                  count: childrenCount,
                  onIncrement: (int count) {
                    if ((adultsCount + count) <= 9) {
                      setState(() {
                        childrenCount = count;
                      });
                    } else {
                      FunctionsUtils.toast("Max. 9 pax only");
                    }
                  },
                  onDecrement: () {
                    if (childrenCount > 0) {
                      setState(() {
                        childrenCount--;
                      });
                    }
                  },
                ),
                _buildTravellerItem(
                  title: 'Infants(0-2)',
                  count: infantsCount,
                  onIncrement: (int count) {
                    if (count <= adultsCount) {
                      setState(() {
                        infantsCount = count;
                      });
                    } else {
                      FunctionsUtils.toast("Not more than Adult");
                    }
                  },
                  onDecrement: () {
                    if (infantsCount > 0) {
                      setState(() {
                        infantsCount--;
                      });
                    }
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    adultsCount = 1;
                    childrenCount = 0;
                    infantsCount = 0;
                    totalTravellers = 0;
                  });
                  _updateCounts();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(fontFamily: 'Inter'),
                ),
              ),
              TextButton(
                onPressed: () {
                  _updateCounts();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontFamily: 'Inter'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //------update total travellers
  void _updateCounts() {
    setState(() {
      totalTravellers = adultsCount + childrenCount + infantsCount;
    });
  }

  //------onIncrment and Decrement widget
  Widget _buildTravellerItem({
    required String title,
    required int count,
    required Function(int) onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.grey),
            borderRadius: BorderRadius.circular(13),
            color: MyColors.white,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  onDecrement();
                  // setState(() {});
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (count < 9) {
                    onIncrement(count + 1);
                  }
                  // setState(() {});
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
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
                      // BoxShadow(
                      //   color: MyColors.grey,
                      //   offset: Offset(1.0, 5.0),
                      //   blurRadius: 10,
                      //   spreadRadius: 3,
                      // ),
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
                    ?  Expanded(
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
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade200,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.02,
                                              ),
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
                                                color:
                                                    MyColors.primaryColorOfApp,
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    city.airportDescription ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade600,
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
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        Icons
                                                            .image_not_supported,
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
    ).whenComplete(() {
      disposed = true; // mark disposed when bottom sheet is closed
    });
  }

  //-----on search flight-----
  void onSearchFlight(Map<String, dynamic> request) async {
    final safeUrl = Uri.encodeFull(request['urlToUse']);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWebviewWidget(title: "", urlToUse: safeUrl), //
      ),
    );
  }

  //----get All City from api

  Future<void> getCityData(String query) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = "${Constant.flightCitySearchApi}$query";
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      getLog(response, "response");
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

enum TripType { oneWay, roundTrip, multiCity }
