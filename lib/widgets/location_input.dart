import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;


  Future<void> _getUserCurrentLocation()async{

    final locData=await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            fit: BoxFit.cover,
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

              }, 
              icon: Icon(Icons.map), 
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ],
    );
  }
}