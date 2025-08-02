import 'package:flutter/material.dart';
import 'package:ikotech/src/common/utils/colours.dart';

import '../../data/model/HomeModel/faq_model.dart';

class FrequentlyAskQuestion extends StatefulWidget {
  final List<FAQModel> dataa;

  const FrequentlyAskQuestion({super.key, required this.dataa});

  @override
  State<FrequentlyAskQuestion> createState() => _FrequentlyAskQuestionState();
}

class _FrequentlyAskQuestionState extends State<FrequentlyAskQuestion> {
  String selectingQuest = '';
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> categories = [];
    Set<String> uniqueCategories = {};
    for (var item in widget.dataa) {
      final category = item.category ?? "";
      if (category.isNotEmpty && !uniqueCategories.contains(category)) {
        uniqueCategories.add(category);
        categories.add(category);
      }
    }
    selectingQuest = categories[selectedIndex];
    final filteredQuestion = widget.dataa
        .where((offer) => offer.category == selectingQuest)
        .toList();
    return Container(
      decoration: BoxDecoration(color: MyColors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Frequently Asked Questions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black,
                    ),
                  ),
                ],
              ),
            ),

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
                const SizedBox(height: 20),

            // Offers Horizontal Scroll
            Column(
              children: List.generate(
                filteredQuestion.length,
                (index) => FAQCard(faq: filteredQuestion[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQCard extends StatelessWidget {
  final FAQModel faq;

  const FAQCard({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return faq.question != ''
        ? Container(
            // elevation: 4,
            // margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ExpansionTile(
              title: Text(
                faq.question ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.black,

                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                faq.category ?? "",
                style: const TextStyle(color: Colors.grey),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faq.answer ?? "",
                    style: const TextStyle(fontSize: 14, color: MyColors.black),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
