import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/session_services.dart';
import '../common/utils/colours.dart';
import '../common/widgets/login_sheet_wid.dart';
import '../data/api/welcome_content_api.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;
  String buttonVal = 'SKIP';
  bool isLoading = true;
  bool isLoginUser = true;

  final List<String> _backgroundImages = [
    'assets/images/welcome3.svg',
    'assets/images/welcome2.svg',
    'assets/images/welcome1.svg',
  ];

  List<String> _titles = [
    'Explore The World With Flyshop',
    'Travel far, explore wide,',
    'Discover the unknown,',
  ];

  final List<String> _highlightedWords = [
    'vast.',
    'beautiful.',
    'adventures await.',
  ];

  final List<String> _descriptions = [
    'At Tourista Adventures, we curate unique and immersive travel experiences to destinations around the globe.',
    'Join us to explore the wonders of the world, one journey at a time.',
    'Unlock the secrets of the universe with our expertly curated adventures.',
  ];
  dynamic userData;
  @override
  void initState() {
    super.initState();
    fetchContentData();
    userData = SessionManager.getCostumereDataLocally();
  }

  Future<void> fetchContentData() async {
    try {
      // Ensure slight delay for UX smoothness
      await Future.delayed(Duration(seconds: 1));

      final response = await WelcomeContentApi.welcomeMethodApi();
      final jsonData = jsonDecode(response);

      final data = jsonData['data'] ?? {};

      // Safe fallbacks
      final sliderOne = data['slider_one_content'] as String? ?? '';
      final sliderTwo = data['slider_two_content'] as String? ?? '';
      final sliderThree = data['slider_three_content'] as String? ?? sliderTwo;

      if (mounted) {
        setState(() {
          _titles[0] = sliderOne;
          _titles[1] = sliderTwo;
          _titles[2] = sliderThree;
          isLoading = false;
        });
      }
    } catch (e) {
      // Log or handle API failure gracefully
      print('Error fetching welcome content: $e');
      if (mounted) {
        setState(() {
          _titles = ['', '', ''];
          isLoading = false;
        });
      }
    }

    // Session check after loading
    if (await SessionManager.isLoginExpired()) {
      SessionManager.logout();
      isLoginUser = false;
    }
  }

  // Future<void> fetchContentData() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   await WelcomeContentApi.welcomeMethodApi().then((val) {
  //     final jsonDat = jsonDecode(val);
  //     // getLog(val, "responseData");
  //     if(mounted) {
  //       setState(() {
  //       _titles[0] = jsonDat['data']['slider_one_content'];
  //       _titles[1] = jsonDat['data']['slider_two_content'];
  //       _titles[2] = jsonDat['data']['slider_two_content'];
  //       isLoading = false;
  //     });
  //     }
  //   });
  //   if (await SessionManager.isLoginExpired()) {
  //     SessionManager.logout();
  //     isLoginUser = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: Stack(
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: size.height,
              enlargeCenterPage: false,
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: _backgroundImages.asMap().entries.map((entry) {
              final index = entry.key;
              final backgroundImage = entry.value;
              return Stack(
                children: [
                  // Background image
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 110,
                    child: Container(
                      height: size.height,
                      width: size.width,
                      child: SvgPicture.asset(
                        backgroundImage,
                        width: size.width,
                        height: size.height,
                        fit: BoxFit.fitWidth,
                      ),
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image:
                      //     AssetImage(backgroundImage),
                      //     fit: BoxFit.fitWidth,
                      //   ),
                      // ),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                  // Content
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            _titles[index],
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _highlightedWords[index],
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColorOfApp,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _descriptions[index],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: size.height * .2),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          // Custom indicators
          Positioned(
            bottom: 60,
            right: size.height * .3,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _backgroundImages.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: currentIndex == entry.key ? 46.0 : 18.0,
                    height: 8,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(14),
                      color:
                          (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : MyColors.primaryColorOfApp)
                              .withOpacity(
                                currentIndex == entry.key ? 0.9 : 0.4,
                              ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 70,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(21),
          ),
          onPressed: () {
            setState(() {
              if (isLoginUser && userData != null) {
                context.go('/homescreen');
              } else {
                _showLoginSheet(context);
              }
            });

            // context.go('/homescreen');
          },
          backgroundColor: MyColors.primaryColorOfApp,
          label: Text(
            currentIndex == _backgroundImages.length - 1 ? "SKIP" : "NEXT",
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showLoginSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      backgroundColor: MyColors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: LoginBottomSheet(),
        );
      },
    );
    return result;
  }
}
