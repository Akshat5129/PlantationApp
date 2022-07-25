import 'dart:io';

import 'package:camera/camera.dart';
import 'package:plantationapp/screens/take_picture_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:plantationapp/screens/login_screen.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';
import 'package:plantationapp/screens/take_picture_page.dart';
import 'package:signature/signature.dart';

class FarmerPlantation extends StatefulWidget {
  const FarmerPlantation({Key? key}) : super(key: key);

  @override
  State<FarmerPlantation> createState() => _FarmerPlantationState();
}

class _FarmerPlantationState extends State<FarmerPlantation> {

  late CameraDescription camera;
  late CameraController controller;
  bool _isInited = false;
  late String _url;
  String _path = "";


  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      print(cameras);
      // setState(() {});
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((value) => {
        setState(() {
          _isInited = true;
        })
      });
    });
  }


  void _showCamera() async {

    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));

    setState(() {
      _path = result;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 254, 236, 1),
        body: Container(
            padding: EdgeInsets.all(50),
            child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          "Farmer's Plantation",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(120, 153, 50, 1),
                                letterSpacing: .2,
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                  child: Text(
                                    "Farmer's Demand",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color.fromRGBO(58, 58, 58, 1),
                                          letterSpacing: .2,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 6, top: 2, right: 6, bottom: 2),
                                  decoration: BoxDecoration(
                                      color:Color.fromRGBO(181, 231, 77, 0.56),
                                      border: Border.all(
                                          color: Color.fromRGBO(181, 231, 77, 0.56)
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  margin: EdgeInsets.only(top: 1),
                                  child: TextField(
                                    readOnly: true,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tree/Plant',
                                    ),
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.black54,
                                        letterSpacing: .2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20,),
                                Container(
                                  child: Text(
                                    "Selected Plant",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color.fromRGBO(58, 58, 58, 1),
                                          letterSpacing: .2,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 6, top: 2, right: 6, bottom: 2),
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      border: Border.all(
                                          color: Colors.black54
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  margin: EdgeInsets.only(top: 1),
                                  child: TextField(
                                    readOnly: true,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Tree/Plant',
                                        prefixIcon: Icon(Icons.check_circle),
                                        prefixIconColor: Colors.green
                                    ),
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.black54,
                                        letterSpacing: .2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Container(
                                  child: Text(
                                    "Plant Images",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color.fromRGBO(58, 58, 58, 1),
                                          letterSpacing: .2,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 1.0,
                                    onPressed: (){
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200,
                                            color: Colors.white70,
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(top: 10),
                                                    padding: EdgeInsets.symmetric(vertical: 25.0),
                                                    width: double.infinity,
                                                    child: RaisedButton(
                                                      elevation: 1.0,
                                                      onPressed: (){
                                                        _showCamera();
                                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDemandSConsent(),),);
                                                      },
                                                      padding: EdgeInsets.all(15.0),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      color: Colors.white24,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.camera_alt),
                                                          SizedBox(width: 10,),
                                                          Text(
                                                            "Take a Picture",
                                                            textAlign: TextAlign.center,
                                                            style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: Colors.black,
                                                                  letterSpacing: .2,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Color.fromRGBO(255, 252, 177, 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt),
                                     SizedBox(width: 10,),
                                     Text(
                                      "Capture Image",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: .2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                      ],
                                    )
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 1.0,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDemandSConsent(),),);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Color.fromRGBO(243, 214, 139, 1.0),
                                    child: Text(
                                      'NEXT',
                                      style: TextStyle(
                                        color: Color.fromRGBO(93, 43, 14, 1),
                                        letterSpacing: 1.5,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))])])),


    );}}
