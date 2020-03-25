

const HERE_API_KEY='HYeyw8jHy0KxEuySBUjmaPNOfJs9ImQktb3_9XA6Eyg';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude,}) {
    
    String url='https://image.maps.ls.hereapi.com/mia/1.6/mapview?apiKey=$HERE_API_KEY&c=$latitude,$longitude';
    print(url);
    String url1='https://image.maps.ls.hereapi.com/mia/1.6/mapview?c=$latitude,$longitude&z=12&w=500&h=300&f=1&apiKey=$HERE_API_KEY';
    return url1;
  }
} 