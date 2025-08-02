import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/model/HomeModel/travel_blog_model.dart';
import '../../screens/see_all_screen.dart';
import '../utils/colours.dart';
import '../utils/functions.dart';

class BlogsWid extends StatefulWidget {
  final List<TravelBlogModel> destination;

  const BlogsWid({super.key, required this.destination});

  @override
  State<BlogsWid> createState() => _BlogsWidState();
}

class _BlogsWidState extends State<BlogsWid> {
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
                "Enjoy Fresh Travel Blogs",
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
                        title: "Enjoy Fresh Travel Blogs",
                        items: widget.destination,
                        itemBuilder: (offer) => BlogsCard(travelBlog: offer),
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
                    // Icon(
                    //   Icons.arrow_forward_ios,
                    //   size: 14,
                    //   color: Colors.amber,
                    // ),
                  ],
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
              child:
                  (widget.destination[index].contents != '' &&
                      widget.destination[index].featureImage != '')
                  ? BlogsCard(travelBlog: offer)
                  : SizedBox.shrink(),
            );
          },
          options: CarouselOptions(
            height: 240,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.destination.length, (index) {
            return (widget.destination[index].contents != '' &&
                    widget.destination[index].featureImage != '')
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.amber
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )
                : SizedBox.shrink();
          }),
        ),
      ],
    );
  }
}

class BlogsCard extends StatelessWidget {
  final TravelBlogModel travelBlog;
  const BlogsCard({super.key, required this.travelBlog});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FunctionsUtils.buildCachedImage(
                    travelBlog.featureImage!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    // height: 140,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        travelBlog.blogHeading ?? "",
                        style: const TextStyle(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
