import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'dart:io';

import '../models/place.dart';
import '../helpers/db_helper.dart';



class GreatPlaces with ChangeNotifier{

  List<Place> _items=[];

  List<Place> get  items{
    return [..._items];
  }


  void addPlace(String pickedTitle,File pickedImage,PlaceLocation p1){

    final newPlace=Place(
      id: DateTime.now().toString(), 
      title: pickedTitle, 
      place: p1, 
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();


    DBHelper.insert('user_places', {
      'id':newPlace.id,
      'title':newPlace.title,
      'image':newPlace.image.path,
      'loc_lati':newPlace.place.latitude,
      'loc_long':newPlace.place.longitude,
      'address':newPlace.place.address,
    });
    
  }


  Future<void> fetchAndSetPlaces()async{
    final dataList=await DBHelper.getData('user_places');

    _items=dataList.map(
      (item)=>Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        place: PlaceLocation(
          latitude: item['loc_lati'], 
          longitude: item['loc_long'],
          address: item['address'],
        ),
      )
    ).toList();

    notifyListeners();
  }

}