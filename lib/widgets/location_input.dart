import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;

  var _isSearch=false;


  Future<void> _getUserCurrentLocation()async{

    final locData=await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);

    final staticMapImageUrl= LocationHelper.generateLocationPreviewImage(latitude: locData.latitude,longitude: locData.longitude);

   setImageURL(staticMapImageUrl);

  }

  void setImageURL(String x){
    setState(() {
      _previewImageUrl=x;
    });
  }


  final searchTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[

           Column(
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
                          setImageURL,
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


          

        ],
         
      ),
    );
  }
}