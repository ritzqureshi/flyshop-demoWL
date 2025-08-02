
class TopFlightRouteModel {
  bool? b0;
  String? departsector;
  String? arrivalsector;
  String? departairport;
  String? arriveairport;
  String? airlineCode;
  String? airlineName;
  String? price;
  String? routeType;
  String? arrivecountry;
  String? departcountry;
  String? agentId;

  TopFlightRouteModel(
      {this.b0,
      this.departsector,
      this.arrivalsector,
      this.departairport,
      this.arriveairport,
      this.airlineCode,
      this.airlineName,
      this.price,
      this.routeType,
      this.arrivecountry,
      this.departcountry,
      this.agentId});

  TopFlightRouteModel.fromJson(Map<String, dynamic> json) {
    b0 = json['0'];
    departsector = json['departsector'];
    arrivalsector = json['arrivalsector'];
    departairport = json['departairport'];
    arriveairport = json['arriveairport'];
    airlineCode = json['airline_code'];
    airlineName = json['airline_name'];
    price = json['price'];
    routeType = json['route_type'];
    arrivecountry = json['arrivecountry'];
    departcountry = json['departcountry'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['0'] = b0;
    data['departsector'] = departsector;
    data['arrivalsector'] = arrivalsector;
    data['departairport'] = departairport;
    data['arriveairport'] = arriveairport;
    data['airline_code'] = airlineCode;
    data['airline_name'] = airlineName;
    data['price'] = price;
    data['route_type'] = routeType;
    data['arrivecountry'] = arrivecountry;
    data['departcountry'] = departcountry;
    data['agent_id'] = agentId;
    return data;
  }
}
