import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantationapp/screens/login_screen.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';
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
                                    "Demand",
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
                                    "Selected Tree",
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

                                SizedBox(height: 20,),

                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  // child: _isInited ? CameraPreview(controller) : Container()
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: _isInited
                                            ? AspectRatio(
                                          aspectRatio: controller.value.aspectRatio,
                                          child: CameraPreview(controller),
                                        )
                                            : Container(),
                                      ),
                                      Container(
                                        height: 152,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 120,
                                              width: 120,
                                              child: _url != null
                                                  ? Image.file(
                                                File(_url),
                                                height: 120,
                                                width: 120,
                                              )
                                                  : Container(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
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

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          final path = join(
              (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
          await controller.takePicture().then((res) => {
                setState(() {
                  _url = path;
                })
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );}}
