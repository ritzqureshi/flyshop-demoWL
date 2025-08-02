import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ikotech/src/data/api/home_screen_api.dart';

import 'home_screen_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitial());

//   Future<void> fetchHomeData() async {
//     emit(HomeLoading());
//     try {
//       final headerBoxes = await HomeScreenApi.headerBoxMethodApi();
//       final offerSections = await HomeScreenApi.offerAndDeals();
//       final popularDestinationSections =
//           await HomeScreenApi.popularDestinationApi();
//       final topFlightRouteSections = await HomeScreenApi.topFlightRouteMethod();
//       final tesmonialSections = await HomeScreenApi.testimonialMethod();
//       final faqSections = await HomeScreenApi.faqMethod();
//       final travelBlogSections = await HomeScreenApi.travelBlogMethod();
//       final whyWithUsSections = await HomeScreenApi.whyWithUsMethodApi();
//       emit(
//         HomeLoaded(
//           headerBox: headerBoxes,
//           offerDeals: offerSections,
//           popularDestination: popularDestinationSections,
//           topFlightRoute: topFlightRouteSections,
//           testimonial: tesmonialSections,
//           frequentlyAskQ: faqSections,
//           travelBlog: travelBlogSections,
//           whyWithUs: whyWithUsSections,
//         ),
//       );
//     } catch (e) {
//       getLog(e.toString(), "HomeCubit");
//       emit(HomeError("Failed to load home data"));
//     }
//   }
// }


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeSectionState());

  void fetchAllHomeData() {
    fetchHeaderBox();
    fetchOffers();
    fetchDestinations();
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
