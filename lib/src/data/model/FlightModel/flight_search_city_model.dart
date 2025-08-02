class FLightSearchCityModel {
  String? city;
  String? country;
  String? airportCode;
  String? airportDescription;
  String? id;
  GetCountryFlag? getCountryFlag;

  FLightSearchCityModel(
      {this.city,
      this.country,
      this.airportCode,
      this.airportDescription,
      this.id,
      this.getCountryFlag});

  FLightSearchCityModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    airportCode = json['airportCode'];
    airportDescription = json['airportDescription'];
    id = json['id'];
    getCountryFlag = json['get_country_flag'] != null
        ? GetCountryFlag.fromJson(json['get_country_flag'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['country'] = country;
    data['airportCode'] = airportCode;
    data['airportDescription'] = airportDescription;
    data['id'] = id;
    if (getCountryFlag != null) {
      data['get_country_flag'] = getCountryFlag!.toJson();
    }
    return data;
  }
}

class GetCountryFlag {
  String? country;
  String? flag;
  String? updatedAt;
  String? createdAt;
  String? id;

  GetCountryFlag(
      {this.country, this.flag, this.updatedAt, this.createdAt, this.id});

  GetCountryFlag.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    flag = json['flag'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['flag'] = flag;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
