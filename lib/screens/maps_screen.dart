
import 'package:flutter/material.dart';

import 'package:here_maps_webservice/here_maps_webservice.dart';

import '../helpers/location_helper.dart';

class MapScreen extends StatefulWidget {

  static const routeName='/map-screen';

  final Function setImageUrl;

  MapScreen(this.setImageUrl);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  

  String _previewImageUrl;

  final searchTextController=TextEditingController();
  

  Future<void> getSearchResults()async{

    Map<String, dynamic> latLon = Map();
    
    await HereMaps(apiKey: "HYeyw8jHy0KxEuySBUjmaPNOfJs9ImQktb3_9XA6Eyg")
        .geoCode(searchText: searchTextController.text)
        .then((response) {
      setState(() {
        latLon = response['Response']['View'][0]['Result'][0]['Location']
            ['DisplayPosition'];
      });
    });

    
    var lat=latLon['Latitude'];
    var lon=latLon['Longitude'];
    print(lat);
    print(lon);

    final staticMapImageUrl= LocationHelper.generateLocationPreviewImage(latitude: lat,longitude: lon);

    setState(() {
      _previewImageUrl=staticMapImageUrl;
    });



  }
    
  
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Search Location'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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

              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter the location name',
                ),
                controller: searchTextController,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton.icon(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //to set button at the end
                color: Theme.of(context).accentColor,
                label: Text('Search Place'),
                icon: Icon(Icons.search),
                onPressed: searchTextController.text==null?(){}:getSearchResults,
              ),
              

              SizedBox(
                height: 15,
              ),
              RaisedButton.icon(
                
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //to set button at the end
                color: Theme.of(context).accentColor,
                label: Text('Select this'),
                icon: Icon(Icons.done),
                onPressed: (){
                  widget.setImageUrl(_previewImageUrl);
                  Navigator.of(context).pop();
                },
              ),
            
            ],
          ),
        ),
      ),
      
    );
  }
}