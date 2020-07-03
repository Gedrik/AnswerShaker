import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(

      new MaterialApp(
          title: "Answer Shaker",
          home: new AwesomeButton()
      )
  );
}




class AwesomeButton extends StatefulWidget {
  @override
  AwesomeButtonState createState() => new AwesomeButtonState();
}









class AwesomeButtonState extends State<AwesomeButton> {


  File imageFile;
  final picker = ImagePicker();

  _openGallary(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }



  Future<void> _showChoiceDialog(BuildContext context) {
  return showDialog(context: context,builder: (BuildContext context){
  return AlertDialog(
  title: Text("Select a source"),
  content: SingleChildScrollView(
  child: ListBody(
  children: <Widget>[
  GestureDetector(
  child: Text("Gallery"),
  onTap: (){
  _openGallary(context);
  },
  ),
  Padding(padding: EdgeInsets.all(6.0)),
  GestureDetector(
  child: Text("Camera"),
  onTap: (){
  _openCamera(context);
  },
  )
  ],
  ),
  ),
  );
  });
  }
//show image
  Widget _isImageView(){
  if (imageFile == null) {
  return Text("No Image Selected");
  } else {
  return Image.file(imageFile,width: 400,height: 400);
  }
  }



//word list
  int counter = 0;
  List<String> strings = ["Yes", "No", "I'm not sure", "Cheese", "Fortnite"];
  String displayedString = "";






  @override
  void initState() {
  super.initState();

  ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
  playLocalAsset();
  Vibration.vibrate(duration: 1000);
  _showChoiceDialog(context);

  });
  }


  Future<AudioPlayer> playLocalAsset() async {
  AudioCache cache = new AudioCache();
  return await cache.play("bruh.mp3");

  }




  void onPressed() {
  setState(() {
  Random random = new Random();
  int randomNumber = random.nextInt(5);
  displayedString = strings[randomNumber];
  playLocalAsset();
  Vibration.vibrate(duration: 1000);

  });
  }









  @override
  Widget build(BuildContext context) {
  return new Scaffold(
  appBar: new AppBar(title: new Text("Answer Shaker"), backgroundColor: Colors.blue),
  body: new Container(
  child: new Center(
  child: new Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  new Text(displayedString, style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
  new Padding(padding: new EdgeInsets.all(10.0)),
  new RaisedButton(
  child: new Text("Generate Answer", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
  color: Colors.red,
  onPressed: onPressed,
  )
  ]
  )
  )
  )
  );
  }



}


