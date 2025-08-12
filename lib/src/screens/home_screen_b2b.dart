import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
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
import '../common/widgets/airline_offer_wid.dart';
import '../common/widgets/common_shimmer_loader_wid.dart';
import '../common/widgets/coupon_offer_wid.dart';
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

  bool _isPopupShown = false; // prevent repeat dialogs

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final state = context.read<HomeCubit>().state;
    if (state is HomeSectionState && !_isPopupShown) {
      final popupOffers =
          state.offerDeals
              ?.where((e) => e.category == "Popup" && e.image!.isNotEmpty)
              .toList() ??
          [];

      if (popupOffers.isNotEmpty) {
        _isPopupShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showPopupDialog(popupOffers.first); // show only one popup
        });
      }
    }
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
            child: BlocListener<HomeCubit, HomeState>(
              listenWhen: (previous, current) =>
                  current is HomeSectionState && !_isPopupShown,
              listener: (context, state) {
                if (state is HomeSectionState) {
                  final popupOffers =
                      state.offerDeals
                          ?.where(
                            (e) =>
                                e.category == "Popup" &&
                                (e.image?.isNotEmpty ?? false),
                          )
                          .toList() ??
                      [];

                  if (popupOffers.isNotEmpty) {
                    _isPopupShown = true;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showPopupDialog(popupOffers.first);
                    });
                  }
                }
              },
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is! HomeSectionState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final headerBoxData = state.headerBox;
                  final allOffers = state.offerDeals ?? [];
                  final nonPopupOffers = allOffers
                      .where((e) => e.category != "Popup")
                      .toList();

                  final popularDestination = state.popularDestination;
                  final airlineOffer = state.airlineOffer;
                  final couponOfferList = state.couponOffer;
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
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 2.7,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false,
                        ),
                        items: Constant.bannerImages.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: imagePath.startsWith('http')
                                    ? FunctionsUtils.buildCachedImage(
                                        imagePath,
                                        fit: BoxFit.fitHeight,
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height /
                                            3.5,
                                      )
                                    : Image.asset(imagePath, fit: BoxFit.fill),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          margin: const EdgeInsets.only(
                                            top: 47,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: MyColors.white
                                                      .withOpacity(.4),
                                                ),
                                                margin: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Builder(
                                                  builder: (context) =>
                                                      GestureDetector(
                                                        onTap: () =>
                                                            Scaffold.of(
                                                              context,
                                                            ).openDrawer(),
                                                        child: const Icon(
                                                          CupertinoIcons.bars,
                                                          color: MyColors.black,
                                                          size: 35,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 20,
                                                ),
                                                child:
                                                    FunctionsUtils.buildCachedImage(
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
                                  headerBoxData == null
                                      ? const CommonSectionShimmer()
                                      : HeaderBoxHomeWid(
                                          enabledItems: enabledItems,
                                        ),
                                  const SizedBox(height: 20),
                                  airlineOffer == null
                                      ? const CommonSectionShimmer()
                                      : AirlineOfferWid(
                                          destination: airlineOffer,
                                        ),
                                  const SizedBox(height: 20),
                                  couponOfferList == null
                                      ? const CommonSectionShimmer()
                                      : CouponOfferWid(
                                          destination: couponOfferList,
                                        ),
                                  const SizedBox(height: 20),
                                  nonPopupOffers.isEmpty
                                      ? const CommonSectionShimmer()
                                      : OffersDealsWidget(
                                          offers: nonPopupOffers,
                                        ),
                                  const SizedBox(height: 20),
                                  whywithUs == null
                                      ? const CommonSectionShimmer()
                                      : WhyWithUsWid(offers: whywithUs),
                                  const SizedBox(height: 20),
                                  popularDestination == null
                                      ? const CommonSectionShimmer()
                                      : PopularDestinationWid(
                                          destination: popularDestination,
                                        ),
                                  const SizedBox(height: 20),
                                  topFlightRoute == null
                                      ? const CommonSectionShimmer()
                                      : TopFlightRouteWid(
                                          destination: topFlightRoute,
                                        ),
                                  const SizedBox(height: 20),
                                  travelBlog == null
                                      ? const CommonSectionShimmer()
                                      : BlogsWid(destination: travelBlog),
                                  const SizedBox(height: 20),
                                  testmonial == null
                                      ? const CommonSectionShimmer()
                                      : TestimonialWid(testimonial: testmonial),
                                  const SizedBox(height: 20),
                                  frequentlyAksQuestion == null
                                      ? const CommonSectionShimmer()
                                      : Container(
                                          padding: EdgeInsets.all(20),
                                          child: FrequentlyAskQuestion(
                                            dataa: frequentlyAksQuestion,
                                          ),
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
      ),
    );
  }

  void _showPopupDialog(dynamic popupOffer) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FunctionsUtils.buildCachedImage(
                popupOffer.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              if ((popupOffer.name ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    popupOffer.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              if ((popupOffer.description ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    popupOffer.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
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
