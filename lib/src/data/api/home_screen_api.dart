import 'package:ikotech/src/data/model/HomeModel/faq_model.dart';
import 'package:ikotech/src/data/model/HomeModel/header_box_m.dart';
import 'package:ikotech/src/data/model/HomeModel/offer_deal_model.dart';
import 'package:ikotech/src/data/model/HomeModel/popular_destination_model.dart';
import 'package:ikotech/src/data/model/HomeModel/testimonial_model.dart';
import 'package:ikotech/src/data/model/HomeModel/travel_blog_model.dart';
import 'package:ikotech/src/data/model/HomeModel/why_with_us_model.dart';

import '../../common/api_services.dart';
import '../../common/utils/constant.dart';
import '../../common/utils/functions.dart';
import '../model/HomeModel/top_flight_route_model.dart';

class HomeScreenApi {
  static Future<HeaderBoxModel?> headerBoxMethodApi() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.headerBoxesApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final headerBoxes = HeaderBoxModel.fromJson(response.data);
        return headerBoxes;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error headerBoxMethodApi");
      return null;
    }
  }

  static Future<List<OfferModel>?> offerAndDeals() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.offerAndDealsAPi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => OfferModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }

  static Future<List<PopularDestinationModel>?> popularDestinationApi() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.popularDestinationApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => PopularDestinationModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }

  static Future<List<TopFlightRouteModel>?> topFlightRouteMethod() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.topFlightRouteApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => TopFlightRouteModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }

  static Future<List<TestimonialModel>?> testimonialMethod() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.testimonialApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => TestimonialModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }

  static Future<List<FAQModel>?> faqMethod() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.faqApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => FAQModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }

  static Future<List<TravelBlogModel>?> travelBlogMethod() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.travelBlogApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => TravelBlogModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }
  static Future<List<TravelBlogModel>?> travelBlogDetailsMethod() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.travelBlogDetailsApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => TravelBlogModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }
  static Future<List<WhyWithUsModel>?> whyWithUsMethodApi() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.whyWithUsApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => WhyWithUsModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error offerAndDeals");
      return null;
    }
  }
}
