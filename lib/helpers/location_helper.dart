import 'package:here_maps_webservice/here_maps_webservice.dart';

const HERE_API_KEY='HYeyw8jHy0KxEuySBUjmaPNOfJs9ImQktb3_9XA6Eyg';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude,}) {
    String url1='https://image.maps.ls.hereapi.com/mia/1.6/mapview?c=$latitude,$longitude&z=12&w=500&h=300&f=1&apiKey=$HERE_API_KEY';
    return url1;
  }


   static String generateLocationImage({double latitude, double longitude,}) {
    String url1='https://image.maps.ls.hereapi.com/mia/1.6/mapview?c=$latitude,$longitude&z=12&w=500&h=300&f=1&apiKey=$HERE_API_KEY';
    return url1;
  }

  static Future<String> getLocationName(double lati,double long)async{
    var  response= await HereMaps(apiKey: HERE_API_KEY).
    reverseGeoCode(lat: lati, lon: long);

    var address=response['Response']['View'][0]['Result'][0]['Location']['Address'];
    print(address);
    var _country=address['Country'];
    var _state=address['State'];
    var _district=address['District'];
    

    String result = '$_country/$_state/$_district';
    return result;

  }
  
} 