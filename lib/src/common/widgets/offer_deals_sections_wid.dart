import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/colours.dart';

import '../../data/model/HomeModel/offer_deal_model.dart';
import '../../screens/see_all_screen.dart';
import '../utils/functions.dart';

class OffersDealsWidget extends StatefulWidget {
  final List<OfferModel> offers;

  const OffersDealsWidget({super.key, required this.offers});

  @override
  State<OffersDealsWidget> createState() => _OffersDealsWidgetState();
}

class _OffersDealsWidgetState extends State<OffersDealsWidget> {
  String selectingOffer = '';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> categories = [];
    Set<String> uniqueCategories = {};
    for (var item in widget.offers) {
      final category = item.category ?? "";
      if (category.isNotEmpty && !uniqueCategories.contains(category)) {
        uniqueCategories.add(category);
        categories.add(category);
      }
    }
    selectingOffer = categories[selectedIndex];
    final filteredOffers = widget.offers
        .where((offer) => offer.category == selectingOffer)
        .toList();
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
                "Offers & Deals",
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
                        title: "All Offers & Deals",
                        items: filteredOffers,
                        itemBuilder: (offer) => OfferCard(offer: offer),
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
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final selected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  getLog(selectingOffer, "title");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: selected ? Colors.amber : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 380,
          child: filteredOffers.isEmpty
              ? const Center(
                  child: Text(
                    "No offers available",
                    style: TextStyle(color: MyColors.black),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredOffers.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final offer = filteredOffers[index];
                    return OfferCard(offer: offer);
                  },
                ),
        ),
      ],
    );
  }
}

class OfferCard extends StatelessWidget {
  final OfferModel offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
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
              Container(
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                    bottom: Radius.circular(18),
                  ),
                  child: FunctionsUtils.buildCachedImage(
                    offer.image ?? "",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 140,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    offer.category == "Flight" ? Icons.flight : Icons.hotel,
                    size: 18,
                    color: Colors.amber,
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
                Text(
                  offer.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: MyColors.black
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  offer.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12,color: MyColors.black),
                ),
                const SizedBox(height: 8),
                // const Row(
                //   children: [
                //     Text("View More Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //     Icon(Icons.arrow_right, size: 18)
                //   ],
                // ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Use Code",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: MyColors.black
                      ),
                    ),
                    Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          "NEWDAYGO",
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
