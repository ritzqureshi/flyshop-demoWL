import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/widgets/webview_wid.dart';
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
    return GestureDetector(
      onTap: () {
        final safeUrl = Uri.encodeFull("${Constant.baseUrl}mob/package-view/${destination.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyWebviewWidget(title: "", urlToUse: safeUrl), //
          ),
        );
        // handle tap
      },
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: FunctionsUtils.buildCachedImage(
                destination.image ?? "",
                fit: BoxFit.cover,
              ),
            ),

            // Dark gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // Text content at bottom
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.location ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destination.packageType ?? "",
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Starting at ${destination.perAdultPrice}",
                    style: TextStyle(
                      color: MyColors.primaryColorOfApp,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
}
