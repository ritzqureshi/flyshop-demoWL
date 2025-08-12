import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ikotech/src/data/model/HomeModel/airline_offer_model.dart';

import '../utils/colours.dart';
import '../utils/functions.dart';

class AirlineOfferWid extends StatefulWidget {
  final List<AirlineOfferModel> destination;

  const AirlineOfferWid({super.key, required this.destination});

  @override
  State<AirlineOfferWid> createState() => _AirlineOfferWidState();
}

class _AirlineOfferWidState extends State<AirlineOfferWid> {
  int currentIndex = 0;

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
                "Airline Offers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        CarouselSlider.builder(
          itemCount: widget.destination.length,
          itemBuilder: (context, index, realIdx) {
            final offer = widget.destination[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: (widget.destination[index].image != '')
                  ? AirlineOfferCard(travelBlog: offer)
                  : SizedBox.shrink(),
            );
          },
          options: CarouselOptions(
            height: 120,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
        ),
      ],
    );
  }
}

class AirlineOfferCard extends StatelessWidget {
  final AirlineOfferModel travelBlog;
  const AirlineOfferCard({super.key, required this.travelBlog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/blogDetailsWid", extra: travelBlog);
      },
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: FunctionsUtils.buildCachedImage(
                  travelBlog.image!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  // height: 140,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
