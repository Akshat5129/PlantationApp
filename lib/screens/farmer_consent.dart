
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantationapp/screens/login_screen.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';
import 'package:plantationapp/screens/take_picture_from_camera2.dart';
import 'package:plantationapp/screens/take_picture_page.dart';
import 'package:signature/signature.dart';

class FarmerDemandFConsent extends StatefulWidget {
  //const FarmerDemandFConsent({Key? key}) : super(key: key)

  String year, status, date, district, block, village, farmer, aadhar, phone, gender, farmerdemand;
  Map<String, int> FarmerDemandMap;



  FarmerDemandFConsent(this.year, this.status, this.date, this.district, this.block,
      this.village, this.farmer, this.aadhar, this.phone, this.gender, this.farmerdemand, this.FarmerDemandMap);

  @override
  State<FarmerDemandFConsent> createState() => _FarmerDemandFConsentState();
}

class _FarmerDemandFConsentState extends State<FarmerDemandFConsent> {

  late final todo;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  @override
  void initState() {
    super.initState();
    //todo = ModalRoute.of(context)!.settings.arguments as Todo;
    //print("todo"+todo);
    _controller.addListener(() => print('Value changed'));
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
    //chooseImage('')
  }


  late CameraDescription camera;
  late CameraController controller;
  bool _isInited = false;
  late String _url;
  String _path = "";

  late PickedFile uploadImage;
  late File? selected = null;

  Future<void> chooseImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? file = await imagePicker.getImage(source: imageSource);
    //set source: ImageSource.camera to get image from camera
    setState((){
      uploadImage = file!;
      selected = File(uploadImage.path);
    });
  }


  void _showCamera() async {

    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakeImageFromCamera2(widget.year, widget.status, widget.date, widget.district, widget.block, widget.village, widget.farmer, widget.aadhar
                , widget.phone, widget.gender, widget.farmerdemand, widget.FarmerDemandMap)));

    setState(() {
      _path = result;
    });

  }

  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No content')));
      return;
    }

    final Uint8List? data = await _controller.toPngBytes();
    if (data == null) {
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(data),
              ),
            ),
          );
        },
      ),
    );
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
                      SizedBox(height: 40,),
                      Text(
                        "Farmer's Consent",
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
                      SizedBox(height: 30,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40,),
                              Container(
                                child: Text(
                                  "Select/Click Photo",
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
                              Container(  //show image here after choosing image
                                  // child:selected == null?
                                  // Container(child: Text(selected.toString())): //if uploadimage is null then show empty container
                                  // Container(   //elese show image here
                                  //     child: SizedBox(
                                  //         height:150,
                                  //         child:Image.file(selected!) //load image from file
                                  //     )
                                  // )
                                  child: Image.file(File(getTemporaryDirectory().toString()+'/image_${widget.aadhar}_${widget.date}.jpg'))
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.symmetric(vertical: 25.0),
                                width: double.infinity,
                                child: RaisedButton(
                                  elevation: 1.0,
                                  onPressed: (){
                                    _showCamera();

                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerRegistration3(),),);
                                  },
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Color.fromRGBO(255, 252, 177, 1.0),
                                  child: Text(
                                    'Capture',
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

                              SizedBox(height: 20,),
                              Container(
                                child: Text(
                                  "Farmers's Signature",
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
                                    color:Color.fromRGBO(215, 222, 199, 1.0),
                                    border: Border.all(
                                        color: Color.fromRGBO(215, 222, 199, 1.0)
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                margin: EdgeInsets.only(top: 1),
                                child: Signature(
                                  controller: _controller,
                                  height: 130,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 6, top: 4, right: 6, bottom: 2),
                                margin: EdgeInsets.only(top: 1),
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: const Icon(Icons.redo),
                                  color: Colors.blue,
                                  onPressed: () {
                                    setState(() => _controller.clear());
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: const Icon(Icons.image),
                                  color: Colors.blue,
                                  onPressed: () => exportImage(context),
                                ),
                              ),
                            ]
                        ),
                      ),
                    ]
                ),
                // Container(
                //   child: Image.file(File(todo!.path), height: 300,),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 1.0,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDemandSConsent(
                          widget.year,
                          widget.status, widget.date, widget.district, widget.block, widget.village, widget.farmer, widget.aadhar
                          , widget.phone, widget.gender, widget.farmerdemand, widget.FarmerDemandMap
                      ),),);
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
              ]),
        )
    );}}


class Todo {
  final XFile image;
  const Todo(this.image);
}