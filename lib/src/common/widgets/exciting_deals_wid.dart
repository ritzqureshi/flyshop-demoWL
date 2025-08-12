import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/data/model/HomeModel/why_with_us_model.dart';

import '../../screens/see_all_screen.dart';
import '../utils/colours.dart';
import '../utils/functions.dart';

class WhyWithUsWid extends StatelessWidget {
  final List<WhyWithUsModel> offers;

  const WhyWithUsWid({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Why Book With Travel Website ${Constant.companyName}?",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyColors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeAllScreen(
                        title: "Why With Us",
                        items: offers,
                        itemBuilder: (offer) => ExcitingDealsCard(offer: offer),
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
        CarouselSlider.builder(
          itemCount: offers.length,
          itemBuilder: (context, index, realIdx) {
            final offer = offers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExcitingDealsCard(offer: offer),
            );
          },
          options: CarouselOptions(
            height: 140,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
            },
          ),
        ),      
      ],
    );
  }
}

class ExcitingDealsCard extends StatelessWidget {
  final WhyWithUsModel? offer;

  const ExcitingDealsCard({super.key, this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          // Left Image
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: FunctionsUtils.buildCachedImage(
                offer?.icon ?? "",
                width: 80,
                fit: BoxFit.cover, // height: double.infinity,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Text Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer?.heading ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      color: MyColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      offer?.contents ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Star Icon
        ],
      ),
    );
  }
}
