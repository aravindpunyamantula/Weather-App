import 'package:weather_app/domain/entities/search_locations_entity.dart';

class SearchPlaceModel {
 
  String? name;
  String? region;
  String? country;
  String? url;

  SearchPlaceModel({ this.name, this.region, this.country, this.url});

  SearchPlaceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    url = json['url'];
  }

  SearchLocationsEntity toEntity() {
    return SearchLocationsEntity(
      name: name ?? "", 
      region: region ?? "", 
      country: country ?? "", 
      url: url ?? "");
  }

}
