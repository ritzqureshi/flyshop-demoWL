import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ikotech/src/data/api/home_screen_api.dart';

import 'home_screen_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeSectionState());

  void fetchAllHomeData() {
    fetchHeaderBox();
    fetchOffers();
    fetchDestinations();
    fetchAirlineOffer();
    fetchCouponOfferList();
    fetchFlightRoutes();
    fetchTestimonials();
    fetchFAQ();
    fetchBlogs();
    fetchWhyWithUs();
  }

  void fetchHeaderBox() async {
    try {
      final result = await HomeScreenApi.headerBoxMethodApi();
      emit((state as HomeSectionState).copyWith(headerBox: result));
    } catch (_) {}
  }

  void fetchOffers() async {
    try {
      final result = await HomeScreenApi.offerAndDeals();
      emit((state as HomeSectionState).copyWith(offerDeals: result));
    } catch (_) {}
  }

  void fetchDestinations() async {
    try {
      final result = await HomeScreenApi.popularDestinationApi();
      emit((state as HomeSectionState).copyWith(popularDestination: result));
    } catch (_) {}
  }

  void fetchAirlineOffer() async {
    try {
      final result = await HomeScreenApi.airlineOfferApiMethod();
      emit((state as HomeSectionState).copyWith(airlineOffer: result));
    } catch (_) {}
  }

  void fetchCouponOfferList() async {
    try {
      final result = await HomeScreenApi.couponOfferListMethod();
      emit((state as HomeSectionState).copyWith(couponOffer: result));
    } catch (_) {}
  }

  void fetchFlightRoutes() async {
    try {
      final result = await HomeScreenApi.topFlightRouteMethod();
      emit((state as HomeSectionState).copyWith(topFlightRoute: result));
    } catch (_) {}
  }

  void fetchTestimonials() async {
    try {
      final result = await HomeScreenApi.testimonialMethod();
      emit((state as HomeSectionState).copyWith(testimonial: result));
    } catch (_) {}
  }

  void fetchFAQ() async {
    try {
      final result = await HomeScreenApi.faqMethod();
      emit((state as HomeSectionState).copyWith(frequentlyAskQ: result));
    } catch (_) {}
  }

  void fetchBlogs() async {
    try {
      final result = await HomeScreenApi.travelBlogMethod();
      emit((state as HomeSectionState).copyWith(travelBlog: result));
    } catch (_) {}
  }

  void fetchWhyWithUs() async {
    try {
      final result = await HomeScreenApi.whyWithUsMethodApi();
      emit((state as HomeSectionState).copyWith(whyWithUs: result));
    } catch (_) {}
  }
}
