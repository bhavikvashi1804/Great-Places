import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/great_places.dart';
import '../helpers/location_helper.dart';


class PlaceDetailScreen extends StatefulWidget {

  static const routeName='/place-detail';

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  String _previewImageUrl;


  void fetchUrl(double lat,double lon){
     final staticMapImageUrl= LocationHelper.generateLocationPreviewImage(latitude: lat,longitude: lon);

    setState(() {
      _previewImageUrl=staticMapImageUrl;
     
    });

  }
  
  var _isShowOnMap=false;
  @override
  Widget build(BuildContext context) {

    
    final id=ModalRoute.of(context).settings.arguments;
    final selectedPlace=Provider.of<GreatPlaces>(context,listen:false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Stack(
        children: <Widget>[

          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.file(
                    selectedPlace.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                SizedBox(
                  height:20
                ),

                Text(
                  selectedPlace.place.address,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),


                SizedBox(
                  height:20
                ),

                FlatButton(
                  onPressed: (){
                    fetchUrl(selectedPlace.place.latitude,selectedPlace.place.longitude);
                    setState(() {
                      _isShowOnMap=true;

                    });

                  }, 
                  child: Text('View on Map'),
                  textColor: Theme.of(context).primaryColor,
                )

              ],
            ),
          ),

          if(_isShowOnMap)Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 280,
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
                  FadeInImage(
                    placeholder: AssetImage('images/loading.gif'), 
                    image: NetworkImage(
                      _previewImageUrl,
                    ), 
                    fit: BoxFit.cover,	           
                  )
                  
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: (){
                    setState(() {
                      _isShowOnMap=false; 
                    });
                  },
                ),
                

                

              ],
                
            ),
          ),

        ],
       
      ),
      
    );
  }
}