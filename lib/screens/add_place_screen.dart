import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../provider/great_places.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName='/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController=TextEditingController();

  File _pickedImage;
  
  void _selectImage(File pickedImage){
    _pickedImage=pickedImage;
  }


  void _savePlace(){

    if(_titleController.text.isEmpty || _pickedImage==null){
      return;
    }else{
      Provider.of<GreatPlaces>(context,listen: false).addPlace(
        _titleController.text, 
        _pickedImage,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Add new place')
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(onSelectImage:_selectImage,),
                    
                  ],
                ),
              ),
            ) 
          ),

          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //to set button at the end
            color: Theme.of(context).accentColor,
            label: Text('Add Place'),
            icon: Icon(Icons.add),
            onPressed: _savePlace,
          ),
        ],
      ),
      
    );
  }
}