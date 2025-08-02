abstract class Constant {
  Constant._();
  //*********--------Production/Live URLs-------*********
  static const baseUrl = 'https://iko-tech.com/';
  static const apiBaseUrl = 'https://techapi.ikotech.xyz/api/';
  static const wlID = "67d28082e5ab33c30c0fa412";
  static const xPassKey =
      'SDFDS32SDF897WETGFDS65783243ERWE32432HFGHFG5FDFD213213KJKJKJ988DFEWEW ';
  static var companyName = 'Demo WL';
  static var companyLogo = 'assets/images/applogo.png';
  static var companyHomeBanner = 'assets/images/homeScreen.png';
  static var backgroundThemeColor = '';
  static var textColour = '';
  static const splashSettingApi = '${apiBaseUrl}website-setting?wlid=$wlID';
  static const welcomContentApi = '${apiBaseUrl}app-content-setting?wlid=$wlID';
  static const headerBoxesApi = '${apiBaseUrl}white-label-details?wlid=$wlID';
  static const offerAndDealsAPi = '${apiBaseUrl}offer?wlid=$wlID';
  static const popularDestinationApi =
      '${apiBaseUrl}popular-destination?wlid=$wlID';
  static const topFlightRouteApi = '${apiBaseUrl}top-flight-route?wlid=$wlID';
  static const testimonialApi = '${apiBaseUrl}testimonial?wlid=$wlID';
  static const faqApi = '${apiBaseUrl}faqs-list?wlid=$wlID';
  static const travelBlogApi = '${apiBaseUrl}blog-list?wlid=$wlID';
  static const travelBlogDetailsApi =
      '${apiBaseUrl}blog-details?bid=67d9538df89f3c408d03e032';
  static const whyWithUsApi = '${apiBaseUrl}why-with-us?wlid=$wlID';
  static const flightCitySearchApi = '${apiBaseUrl}flight-destination?keyword=';
  static const hotelCitySearchApi =
      'https://techapi.ikotech.xyz/api/hotel-city-list?keyword=';
  static const busCitySearchApi =
      'https://techapi.ikotech.xyz/api/bus-city-list?keyword=';
  static const holidayCitySearchApi =
      'https://techapi.ikotech.xyz/api/holiday-city-list?keyword=';
  static const loginAuthSendOtpApi = "${apiBaseUrl}auth/user-login?wlid=$wlID";
  static const customItemDrawerApi = "${apiBaseUrl}static-page-list?wlid=$wlID";
  static const customItemDrawerPageContentApi =
      "${apiBaseUrl}page-details?wlid=$wlID&page_id=";
  static const loginAuthVerifyOtpApi =
      "${apiBaseUrl}auth/login-otp-match?wlid=$wlID";
  static const playStoreUrlAndroid =
      'https://play.google.com/store/apps/details?id=com.flyshop.flyshopApp&hl=en';
}
