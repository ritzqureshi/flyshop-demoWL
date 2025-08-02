import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ikotech/src/common/utils/colours.dart';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/widgets/blog_wid.dart';
import 'package:ikotech/src/common/widgets/faq_wid.dart';
import 'package:ikotech/src/common/widgets/popular_destination_wid.dart';
import 'package:ikotech/src/common/widgets/testimonial_wid.dart';
import 'package:ikotech/src/data/model/LoginModel/user_model.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../common/session_services.dart';
import '../common/utils/functions.dart';
import '../common/widgets/common_shimmer_loader_wid.dart';
import '../common/widgets/custom_drawer.dart';
import '../common/widgets/exciting_deals_wid.dart';
import '../common/widgets/header_box_home_wid.dart';
import '../common/widgets/offer_deals_sections_wid.dart';
import '../common/widgets/top_flight_route_wid.dart';
import '../data/bloc/homeScreenState/home_screen_cubit.dart';
import '../data/bloc/homeScreenState/home_screen_state.dart';

class HomeScreenB2b extends StatefulWidget {
  const HomeScreenB2b({super.key});

  @override
  State<HomeScreenB2b> createState() => _HomeScreenB2bState();
}

class _HomeScreenB2bState extends State<HomeScreenB2b>
    with SingleTickerProviderStateMixin {
  String emailId = 'user@email.com';
  String firstName = 'User';
  String lastName = 'User';
  String address = 'India';
  int? userType = 0;
  bool? isUserLogin = false;
  DateTime dateTimeEle = DateTime.now();
  String appVersion = "";
  String agencySysId = '';
  var getrolePermissionB2b = '';
  String? agenUserrId = '';
  bool isShowDestination = true;
  bool isShowOfferData = true;
  bool isShowflightData = true;

  bool isShowTours = true;
  String selectedCard = 'flight';
  String selectedHeaderBox = 'Flights';
  String? logedUserSecurityKey = "";
  String? contactNo = '';
  dynamic isRPActivated;
  dynamic b2bType;
  dynamic isPaid;
  dynamic firmType;
  dynamic agencyMarketPlaceSysId;
  dynamic masterAgencySysId;
  dynamic customerSysId;
  bool isVipAccount = false;
  UserModel? userModel;
  String walletMoney = '';

  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    checkDataInCache();
    // getLattLong();
    fetchHomeData();
    getVersion();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
    )..repeat();
    animation = Tween<double>(begin: 0, end: pi).animate(controller!);
    controller!.forward(from: 0.0);
  }

  void _rotateIcon() {
    if (!controller!.isAnimating) {
      controller!.reset();
      controller!.forward();
    }
    setState(() {});
    controller!.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomSideDrawer(userModel: userModel),
      backgroundColor: const Color.fromARGB(255, 237, 235, 235),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(),
          child: Scrollbar(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is! HomeSectionState) {
                  return const Center(child: CircularProgressIndicator());
                }

                final headerBoxData = state.headerBox;
                final offerAndDeals = state.offerDeals;
                final popularDestination = state.popularDestination;
                final topFlightRoute = state.topFlightRoute;
                final testmonial = state.testimonial;
                final frequentlyAksQuestion = state.frequentlyAskQ;
                final travelBlog = state.travelBlog;
                final whywithUs = state.whyWithUs;

                final enabledItems =
                    headerBoxData
                        ?.toJson()['data']
                        .entries
                        .where((e) => e.value == "1" && e.key != 'b2c_theme')
                        .map((e) => e.key)
                        .toList() ??
                    [];

                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        Constant.companyHomeBanner,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(top: 47),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: MyColors.white.withOpacity(.4),
                                      ),
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Builder(
                                        builder: (context) => GestureDetector(
                                          onTap: () =>
                                              Scaffold.of(context).openDrawer(),
                                          child: const Icon(
                                            CupertinoIcons.bars,
                                            color: MyColors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: FunctionsUtils.buildCachedImage(
                                        Constant.companyLogo,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                // Header Box Section
                                headerBoxData == null
                                    ? const CommonSectionShimmer()
                                    : HeaderBoxHomeWid(
                                        enabledItems: enabledItems,
                                      ),
                                const SizedBox(height: 20),
                                // Offers Section
                                offerAndDeals == null
                                    ? const CommonSectionShimmer()
                                    : OffersDealsWidget(offers: offerAndDeals),
                                const SizedBox(height: 20),
                                // Why With Us Section
                                whywithUs == null
                                    ? const CommonSectionShimmer()
                                    : WhyWithUsWid(offers: whywithUs),
                                const SizedBox(height: 20),
                                // Popular Destination Section
                                popularDestination == null
                                    ? const CommonSectionShimmer()
                                    : PopularDestinationWid(
                                        destination: popularDestination,
                                      ),
                                const SizedBox(height: 20),
                                // Top Flight Routes
                                topFlightRoute == null
                                    ? const CommonSectionShimmer()
                                    : TopFlightRouteWid(
                                        destination: topFlightRoute,
                                      ),
                                const SizedBox(height: 20),
                                // Blog Section
                                travelBlog == null
                                    ? const CommonSectionShimmer()
                                    : BlogsWid(destination: travelBlog),
                                const SizedBox(height: 20),
                                // Testimonials
                                testmonial == null
                                    ? const CommonSectionShimmer()
                                    : TestimonialWid(destination: testmonial),
                                const SizedBox(height: 20),
                                // FAQs
                                frequentlyAksQuestion == null
                                    ? const CommonSectionShimmer()
                                    : FrequentlyAskQuestion(
                                        dataa: frequentlyAksQuestion,
                                      ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
    // Scaffold(
    //   drawer: CustomSideDrawer(userModel: userModel),
    //   backgroundColor: const Color.fromARGB(255, 237, 235, 235),
    //   body: SafeArea(
    //     top: false,
    //     child: RefreshIndicator(
    //       onRefresh: () => _onRefresh(),
    //       child: Scrollbar(
    //         child: BlocBuilder<HomeCubit, HomeState>(
    //           builder: (context, state) {
    //             if (state is HomeLoading) {
    //               return const Center(child: CircularProgressIndicator());
    //             }
    //             if (state is HomeError) {
    //               return Center(child: Text(state.message));
    //             }
    //             if (state is HomeLoaded) {
    //               final headerBoxData = state.headerBox;
    //               final offerAndDeals = state.offerDeals;
    //               final popularDestination = state.popularDestination;
    //               final topFlightRoute = state.topFlightRoute;
    //               final testmonial = state.testimonial;
    //               final frequentlyAksQuestion = state.frequentlyAskQ;
    //               final travelBlog = state.travelBlog;
    //               final whywithUs = state.whyWithUs;
    //               // final enabledItems = headerBoxData
    //               //     ?.toJson()['data']
    //               //     .entries
    //               //     .where((e) => e.value == "1")
    //               //     .map((e) => e.key)
    //               //     .toList();

    //               final enabledItems = headerBoxData
    //                   ?.toJson()['data']
    //                   .entries
    //                   .where((e) => e.value == "1" && e.key != 'b2c_theme')
    //                   .map((e) => e.key)
    //                   .toList();

    //               return Stack(
    //                 children: [
    //                   // Container(
    //                   //   height: MediaQuery.of(context).size.height / 2.2,
    //                   //   decoration:
    //                   //       const BoxDecoration(gradient: MyColors.mainGradientColour),
    //                   // ),
    //                   SizedBox(
    //                     height: MediaQuery.of(context).size.height / 4,
    //                     width: MediaQuery.of(context).size.width,
    //                     child: Image.asset(
    //                       'assets/images/homeScreen.png',
    //                       fit: BoxFit.fill,
    //                     ),
    //                   ),
    //                   Column(
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 20.0),
    //                         child: Row(
    //                           children: [
    //                             Container(
    //                               width: MediaQuery.of(context).size.width,
    //                               margin: EdgeInsets.only(top: 47),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 // crossAxisAlignment: CrossAxisAlignment.center,
    //                                 children: [
    //                                   Container(
    //                                     decoration: BoxDecoration(
    //                                       borderRadius: BorderRadius.circular(
    //                                         7,
    //                                       ),
    //                                       color: MyColors.white.withOpacity(.4),
    //                                     ),
    //                                     margin: const EdgeInsets.only(left: 10),
    //                                     child: Builder(
    //                                       builder: (BuildContext context) {
    //                                         return GestureDetector(
    //                                           onTap: () {
    //                                             Scaffold.of(
    //                                               context,
    //                                             ).openDrawer();
    //                                           },
    //                                           child: const Icon(
    //                                             CupertinoIcons.bars,
    //                                             color: MyColors.white,
    //                                             size: 35,
    //                                           ),
    //                                         );
    //                                       },
    //                                     ),
    //                                   ),

    //                                   Container(
    //                                     margin: EdgeInsets.only(right: 20),
    //                                     child: FunctionsUtils.buildCachedImage(
    //                                       Constant.companyLogo,
    //                                       width: 100,
    //                                       fit: BoxFit.cover,
    //                                       // width: double.infinity,
    //                                       // height: double.infinity,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),

    //                       Expanded(
    //                         child: SingleChildScrollView(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               // Padding(
    //                               //   padding: const EdgeInsets.only(top: 12.0),
    //                               //   child: Row(
    //                               //     children: [
    //                               //       Padding(
    //                               //         padding: const EdgeInsets.only(
    //                               //           left: 11.0,
    //                               //           top: 0,
    //                               //         ),
    //                               //         child: Text(
    //                               //           "Hey ${firstName.toLowerCase()},",
    //                               //           style: TextStyle(
    //                               //             color: MyColors.yellowVeryDark,
    //                               //             fontSize: 17,
    //                               //           ),
    //                               //         ),
    //                               //       ),
    //                               //       // const Spacer(),
    //                               //     ],
    //                               //   ),
    //                               // ),
    //                               SizedBox(height: 20),
    //                               //----------Header boxes item--------//
    //                               HeaderBoxHomeWid(enabledItems: enabledItems),
    //                               SizedBox(height: 20),
    //                               OffersDealsWidget(
    //                                 offers: offerAndDeals ?? [],
    //                               ),
    //                               SizedBox(height: 20),
    //                               WhyWithUsWid(offers: whywithUs ?? []),
    //                               SizedBox(height: 20),
    //                               PopularDestinationWid(
    //                                 destination: popularDestination ?? [],
    //                               ),
    //                               SizedBox(height: 20),
    //                               TopFlightRouteWid(
    //                                 destination: topFlightRoute ?? [],
    //                               ),
    //                               SizedBox(height: 20),
    //                               BlogsWid(destination: travelBlog ?? []),
    //                               SizedBox(height: 20),
    //                               TestimonialWid(destination: testmonial ?? []),
    //                               SizedBox(height: 20),
    //                               FrequentlyAskQuestion(
    //                                 dataa: frequentlyAksQuestion ?? [],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               );
    //             }
    //             return Center(child: const Text("Something went wrong!"));
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  //---------fetch data from server  b2c content-----
  void fetchHomeData() async {
    // context.read<HomeCubit>().fetchHomeData();
    context.read<HomeCubit>().fetchAllHomeData();
  }

  //----onRefresh -----
  _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      fetchHomeData();
    });

    setState(() {});
  }

  //------Get Mobile App version-----
  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  void checkDataInCache() async {
    userModel = SessionManager.getCostumereDataLocally();
    getLog(userModel, "userModel");
  }

  void handleCardClick(String cardType) {
    setState(() {
      selectedCard = cardType;
    });
  }
}
