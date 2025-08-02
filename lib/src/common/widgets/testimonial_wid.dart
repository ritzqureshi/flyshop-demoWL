import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../data/model/HomeModel/testimonial_model.dart';
import '../../screens/see_all_screen.dart';
import '../utils/colours.dart';

class TestimonialWid extends StatefulWidget {
  final List<TestimonialModel> destination;

  const TestimonialWid({super.key, required this.destination});

  @override
  State<TestimonialWid> createState() => _TestimonialWidState();
}

class _TestimonialWidState extends State<TestimonialWid> {
  int _currentIndex = 0;

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
                "Our Reviews",
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
                        title: "Our Reviews",
                        items: widget.destination,
                        itemBuilder: (offer) =>
                            (offer.contents != '' && offer.name != '')
                            ? TestimonialCard(model: offer)
                            : Container(),
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
        CarouselSlider.builder(
          itemCount: widget.destination.length,
          itemBuilder: (context, index, realIdx) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  (widget.destination[index].contents != '' &&
                      widget.destination[index].name != '')
                  ? TestimonialCard(model: widget.destination[index])
                  : SizedBox.shrink(),
            );
          },
          options: CarouselOptions(
            height: 210,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.destination.length, (index) {
            return (widget.destination[index].contents != '' &&
                    widget.destination[index].name != '')
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
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

class TestimonialCard extends StatelessWidget {
  final TestimonialModel model;

  const TestimonialCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double parsedRating = double.tryParse(model.rating ?? '') ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Image + Title + Location + Icons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 28,
                backgroundImage: model.image != null
                    ? NetworkImage(model.image!)
                    : null,
                backgroundColor: Colors.blue[100],
                child: model.image == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              // Name and Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.black,

                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          model.testType ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          parsedRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: MyColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Icons
              Row(
                children: const [
                  _RoundedIcon(icon: Icons.flight),
                  SizedBox(width: 4),
                  _RoundedIcon(icon: Icons.directions_bus),
                  SizedBox(width: 4),
                  _RoundedIcon(icon: Icons.location_city),
                  SizedBox(width: 4),
                  _RoundedIcon(icon: Icons.place),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          // Description
          Text(
            model.contents ??
                'Lorem ipsum dolor sit amet this for the consectetur. Suspendisse quam...',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _RoundedIcon extends StatelessWidget {
  final IconData icon;

  const _RoundedIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}
