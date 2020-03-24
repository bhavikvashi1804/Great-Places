import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName='/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Add new place')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('User Input....'),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //to set button at the end
            color: Theme.of(context).accentColor,
            label: Text('Add Place'),
            icon: Icon(Icons.add),
            onPressed: (){

            }
          ),
        ],
      ),
      
    );
  }
}