import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/colours.dart';
import 'package:intl/intl.dart';

import '../common/utils/functions.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({super.key});

  @override
  _CarSearchScreenState createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen>
    with SingleTickerProviderStateMixin {
  bool isRoundTrip = false;
  String from = "Delhi";
  String to = "Delhi";
  DateTime pickupDate = DateTime.now();
  DateTime dropDate = DateTime.now();

  DateTime selectedDate = DateTime.now();
  TimeOfDay pickupTime = TimeOfDay.now();
  TimeOfDay dropTime = TimeOfDay.now();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();

  Map<String, dynamic> fromCityData = {};
  Map<String, dynamic> toCityData = {};
  String? selectedVehicle;
  int passengerCount = 1;

  Future<void> _selectDate(
    BuildContext context,
    Function(DateTime) onSelected,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) onSelected(picked);
  }

  Future<void> _selectTime(
    BuildContext context,
    TimeOfDay initialTime,
    Function(TimeOfDay) onSelected,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) onSelected(picked);
  }

  AnimationController? controller;
  Animation<double>? animation;
  void _rotateIcon() {
    if (!controller!.isAnimating) {
      controller!.reset();
      controller!.forward();
    }
    setState(() {});
    controller!.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
    )..repeat();
    animation = Tween<double>(begin: 0, end: pi).animate(controller!);
    controller!.forward(from: 0.0);
    nameController.text = "asdfasdf";
    emailController.text = "asdfas@gmail.com";
    mobileController.text = "1234321123";
  }

  @override
  Widget build(BuildContext context) {
    // final dateFormat = DateFormat("dd-MM-yyyy");
    timeFormat(TimeOfDay time) => time.format(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Trip type
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: Text(
                    "One Way",
                    style: TextStyle(
                      color: !isRoundTrip
                          ? Colors.white
                          : Colors.black, // white when selected
                    ),
                  ),
                  selected: !isRoundTrip,
                  selectedColor: MyColors
                      .primaryColorOfApp, // yellow background when selected
                  backgroundColor: Colors.grey[200], // default background
                  onSelected: (selected) =>
                      setState(() => isRoundTrip = !selected),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: Text(
                    "Round Trip",
                    style: TextStyle(
                      color: isRoundTrip
                          ? Colors.white
                          : Colors.black, // white when selected
                    ),
                  ),
                  selected: isRoundTrip,
                  onSelected: (selected) =>
                      setState(() => isRoundTrip = selected),
                  selectedColor: MyColors.primaryColorOfApp,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // From / To
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                commonCityController(
                  'FROM',
                  fromCityController,
                  fromCityData,
                  MediaQuery.of(context).size.width * 0.4,
                  const EdgeInsets.only(left: 0, bottom: 30),
                ),

                Container(
                  // color: Colors.red,
                  margin: EdgeInsets.only(
                    left:
                        MediaQuery.of(context).size.width *
                        0, // Adjust left position
                    bottom: 23, // Adjust top position
                  ),
                  height: (36),
                  width: (36),
                  child: GestureDetector(
                    onTap: () {
                      _rotateIcon();
                      // swapCities();
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
                  const EdgeInsets.only(left: 4, bottom: 30),
                ),
              ],
            ),
          ),

          // Dates
          Row(
            children: [
              Expanded(
                child: _buildLabelValue(
                  "Pickup Date",
                  DateFormat("dd-MM-yyyy").format(pickupDate),
                  onTap: () {
                    _selectDate(
                      context,
                      (picked) => setState(() => pickupDate = picked),
                    );
                  },
                ),
              ),
              if (isRoundTrip) ...[
                SizedBox(width: 12),
                Expanded(
                  child: _buildLabelValue(
                    "Drop Date",
                    DateFormat("dd-MM-yyyy").format(dropDate),
                    onTap: () {
                      _selectDate(
                        context,
                        (picked) => setState(() => dropDate = picked),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 20),
          // Pickup / Drop Times
          Row(
            children: [
              Expanded(
                child: _buildLabelValue(
                  "Pick Up Time",
                  timeFormat(pickupTime),
                  onTap: () {
                    _selectTime(context, pickupTime, (picked) {
                      setState(() => pickupTime = picked);
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildLabelValue(
                  "Drop Time",
                  timeFormat(dropTime),
                  onTap: () {
                    _selectTime(context, dropTime, (picked) {
                      setState(() => dropTime = picked);
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Vehicle dropdown
          // Passenger count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Passengers",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (passengerCount > 1) passengerCount--;
                      });
                    },
                  ),
                  Text(
                    '$passengerCount',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (passengerCount < 9) passengerCount++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),

          // Full Name
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Full Name"),
          ),

          SizedBox(height: 12),

          // Email
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: "Email ID"),
          ),

          SizedBox(height: 12),

          // Mobile
          TextField(
            controller: mobileController,
            decoration: InputDecoration(labelText: "Mobile Number"),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildLabelValue(String label, String value, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Text(value, style: TextStyle(fontSize: 16)),
                ),
              ),
              if (onTap != null)
                Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
            ],
          ),
        ],
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
                  // if (fromCityController.text.isEmpty && title == "TO") {
                  //   FunctionsUtils.toast(
                  //     "Please select Departure city first!!",
                  //   );
                  // } else {
                  //   _openFullBottomSheet(context, title, textController, data);
                  // }
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
      height: .6,
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
}
