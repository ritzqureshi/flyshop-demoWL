import 'package:ikotech/src/data/model/HomeModel/coupon_offer_model.dart';
import 'package:ikotech/src/data/model/HomeModel/faq_model.dart';
import 'package:ikotech/src/data/model/HomeModel/offer_deal_model.dart';
import 'package:ikotech/src/data/model/HomeModel/popular_destination_model.dart';
import 'package:ikotech/src/data/model/HomeModel/testimonial_model.dart';
import 'package:ikotech/src/data/model/HomeModel/travel_blog_model.dart';

import '../../model/HomeModel/airline_offer_model.dart';
import '../../model/HomeModel/header_box_m.dart';
import 'package:equatable/equatable.dart';

import '../../model/HomeModel/top_flight_route_model.dart';
import '../../model/HomeModel/why_with_us_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeSectionState extends HomeState {
  final HeaderBoxModel? headerBox;
  final List<OfferModel>? offerDeals;
  final List<PopularDestinationModel>? popularDestination;
  final List<AirlineOfferModel>? airlineOffer;
  final List<CouponOfferModel>? couponOffer;
  final List<TopFlightRouteModel>? topFlightRoute;
  final List<TestimonialModel>? testimonial;
  final List<FAQModel>? frequentlyAskQ;
  final List<TravelBlogModel>? travelBlog;
  final List<WhyWithUsModel>? whyWithUs;
  final String? error;

  const HomeSectionState({
    this.headerBox,
    this.offerDeals,
    this.popularDestination,
    this.airlineOffer,
    this.couponOffer,
    this.topFlightRoute,
    this.testimonial,
    this.frequentlyAskQ,
    this.travelBlog,
    this.whyWithUs,
    this.error,
  });

  HomeSectionState copyWith({
    HeaderBoxModel? headerBox,
    List<OfferModel>? offerDeals,
    List<PopularDestinationModel>? popularDestination,
    List<AirlineOfferModel>? airlineOffer,
    List<CouponOfferModel>? couponOffer,
    List<TopFlightRouteModel>? topFlightRoute,
    List<TestimonialModel>? testimonial,
    List<FAQModel>? frequentlyAskQ,
    List<TravelBlogModel>? travelBlog,
    List<WhyWithUsModel>? whyWithUs,
    String? error,
  }) {
    return HomeSectionState(
      headerBox: headerBox ?? this.headerBox,
      offerDeals: offerDeals ?? this.offerDeals,
      popularDestination: popularDestination ?? this.popularDestination,
      airlineOffer: airlineOffer ?? this.airlineOffer,
      couponOffer: couponOffer ?? this.couponOffer,
      topFlightRoute: topFlightRoute ?? this.topFlightRoute,
      testimonial: testimonial ?? this.testimonial,
      frequentlyAskQ: frequentlyAskQ ?? this.frequentlyAskQ,
      travelBlog: travelBlog ?? this.travelBlog,
      whyWithUs: whyWithUs ?? this.whyWithUs,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    headerBox,
    offerDeals,
    popularDestination,
    airlineOffer,
    couponOffer,
    topFlightRoute,
    testimonial,
    frequentlyAskQ,
    travelBlog,
    whyWithUs,
    error,
  ];
}
