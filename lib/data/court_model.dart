class Court {
  String? key;
  CourtData? courtData;

  Court(this.key, this.courtData);
}

class CourtData {
  String? imagePath;
  String? name;
  String? place;
  double? ticketPrice;
  double? latitude;
  double? longitude;
  double? starRating;


  CourtData(this.imagePath, this.name, this.place, this.ticketPrice, this.latitude, this.longitude, this.starRating);

  Map<String, dynamic> toJson() {
    return {
      "image": imagePath,
      "name": name,
      "place": place,
      "ticket_price": ticketPrice,
      'latitude': latitude,
      'longitude': longitude,
      'starRating': starRating,

    };
  }

  CourtData.fromJson(Map<dynamic, dynamic> json) {
    imagePath = json["image"];
    name = json["name"];
    place = json["place"];
    ticketPrice = checkDouble(json["ticket_price"]);
    latitude = checkDouble(json['latitude']);
    longitude = checkDouble(json['longitude']);
    starRating = checkDouble(json['starRating']);
  }

  double? checkDouble(value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return double.parse(value.toString());
    } else {
      return 0.0;
    }
  }

  int? checkInteger(established) {
    if (established is String) {
      return int.parse(established);
    } else if (established is double) {
      return int.parse(established.toString());
    } else if (established is int) {
      return established;
    } else {
      return 0;
    }
  }
}
