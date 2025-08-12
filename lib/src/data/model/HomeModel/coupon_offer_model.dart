class CouponOfferModel {
  String? id;
  String? heading;
  String? couponCode;
  String? validDate;
  String? aboutOffer;
  String? termsCondition;

  CouponOfferModel(
      {this.id,
      this.heading,
      this.couponCode,
      this.validDate,
      this.aboutOffer,
      this.termsCondition});

  CouponOfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    couponCode = json['coupon_code'];
    validDate = json['valid_date'];
    aboutOffer = json['about_offer'];
    termsCondition = json['terms_condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['heading'] = heading;
    data['coupon_code'] = couponCode;
    data['valid_date'] = validDate;
    data['about_offer'] = aboutOffer;
    data['terms_condition'] = termsCondition;
    return data;
  }
}
