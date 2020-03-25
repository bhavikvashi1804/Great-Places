import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/maps_screen.dart';


class LocationInput extends StatefulWidget {

  final Function selectedLocation;

  LocationInput(this.selectedLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;
  double _userLati;
  double _userLong;



 
 


  Future<void> _getUserCurrentLocation()async{

    try{
    final locData=await Location().getLocation();
    final staticMapImageUrl= LocationHelper.generateLocationPreviewImage(latitude: locData.latitude,longitude: locData.longitude);

    //display user location 
    setLocationInfo(locData.latitude,locData.longitude,staticMapImageUrl);
    }
    catch(error){
      print(error);
    }
  }



  void setLocationInfo(double lat,double long,String x){
    _userLati=lat;
    _userLong=long;
    setState(() {
      _previewImageUrl=x;
    });

    //print( _userLati);
    //print(_userLong);
    //print(_previewImageUrl);
    // get data here is ok

    widget.selectedLocation(_userLati,_userLong,_previewImageUrl);
  }

  


  final searchTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 170,
            alignment: Alignment.center,

            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color:Colors.grey,
              )
            ),

            child: _previewImageUrl==null?
            Text('No location chosen!',textAlign: TextAlign.center,):
            Image.network(
              _previewImageUrl,
              fit: BoxFit.fitWidth,      
              width: double.infinity,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: _getUserCurrentLocation,
                icon: Icon(Icons.location_on), 
                label: Text('Current Location'),
                textColor: Theme.of(context).primaryColor,
              ),
              FlatButton.icon(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen(
                      setLocationInfo,
                    )),
                  );
                }, 
                icon: Icon(Icons.map), 
                label: Text('Select on Map'),
                textColor: Theme.of(context).primaryColor,
              ),
            
            ],
          ),
        ],
      ),
    );
  }
}