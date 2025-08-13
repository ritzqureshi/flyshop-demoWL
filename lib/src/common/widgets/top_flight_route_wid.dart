
import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/functions.dart';
import 'package:ikotech/src/common/widgets/webview_wid.dart';
import 'package:ikotech/src/data/model/HomeModel/top_flight_route_model.dart';
import 'package:intl/intl.dart';

import '../../screens/see_all_screen.dart';
import '../utils/colours.dart';
import '../utils/constant.dart';

class TopFlightRouteWid extends StatelessWidget {
  final List<TopFlightRouteModel> destination;

  const TopFlightRouteWid({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Top Flight Route",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeAllScreen(
                        title: "Top Flight Route",
                        items: destination,
                        itemBuilder: (offer) => FlightDealCard(deal: offer),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(6),
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image(
                      image: AssetImage("assets/icons/seeAllIcon.png"),
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FlightDealCard(deal: destination[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class FlightDealCard extends StatelessWidget {
  final TopFlightRouteModel deal;

  const FlightDealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          // Airline logo substitute
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.flight_takeoff, color: Colors.white),
          ),
          const SizedBox(width: 16),

          // From -> To
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deal.departairport ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: MyColors.black,
                      ),
                    ),
                    Text(
                      deal.departsector ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.flight, color: Colors.amber, size: 24),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deal.arriveairport ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.black,

                        fontSize: 16,
                      ),
                    ),
                    Text(
                      deal.arrivalsector ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Price + button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Starting from",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                "₹${deal.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.black,

                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  String urlToUse =
                      "${Constant.baseUrl}flight-search-page?platform=mobile&tripType=one-way&fromcitydesti=${deal.departairport}-${deal.departsector}&fromContry=${deal.departcountry}&tocitydesti=${deal.arriveairport}-${deal.arrivalsector}&toContry=${deal.arrivecountry}&journeyDateOne=${DateFormat("dd-MM-yyyy").format(DateTime.now().add(Duration(days: 15)))}&ADT=1&CHD=0&INF=0&travel_class=ECONOMY&pft=AC";
                  getLog(urlToUse, "dealtopflight");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyWebviewWidget(title: "", urlToUse: urlToUse), //
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 12, color: MyColors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
