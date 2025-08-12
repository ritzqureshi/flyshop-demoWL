import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ikotech/src/data/model/HomeModel/popular_destination_model.dart';

import '../../screens/see_all_screen.dart';
import '../utils/colours.dart';
import '../utils/functions.dart';

class PopularDestinationWid extends StatelessWidget {
  final List<PopularDestinationModel> destination;

  const PopularDestinationWid({super.key, required this.destination});

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
                "Popular Destination",
                style: TextStyle(
                  fontSize: 20,
                  color: MyColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeAllScreen(
                        title: "Popular Destination",
                        items: destination,
                        itemBuilder: (offer) =>
                            DestinationCard(destination: offer),
                      ),
                    ),
                  );
                },
                child: Row(
                  children:  [
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

        // Category Tabs

        // Offers Horizontal Scroll
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: destination.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final offer = destination[index];
              return DestinationCard(destination: offer);
            },
          ),
        ),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  final PopularDestinationModel destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    // getLog(jsonEncode(destination.toJson()), "destinations");
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Icon
          Stack(
            children: [
              SizedBox(
                height: 130,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                    bottom: Radius.circular(18),
                  ),
                  child: FunctionsUtils.buildCachedImage(
                    destination.image ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 140,
                  ),
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      destination.city ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColors.black,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          "BOOK NOW",
                          style: TextStyle(
                            color: MyColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
