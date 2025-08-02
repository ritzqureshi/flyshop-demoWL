import 'package:flutter/material.dart';
import 'package:ikotech/src/data/model/HomeModel/why_with_us_model.dart';

import '../utils/colours.dart';
import '../utils/functions.dart';

class WhyWithUsWid extends StatelessWidget {
  final List<WhyWithUsModel> offers;

  const WhyWithUsWid({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      shrinkWrap: true, // ✅ Tells ListView to size itself based on content
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final offer = offers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: FunctionsUtils.buildCachedImage(
                  offer.icon ?? "",
                  width: 80,
                  fit: BoxFit.cover, // height: double.infinity,
                ),
              ),
              const SizedBox(width: 12),
              // Text Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.heading ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        offer.contents ?? "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              // Star Icon
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
