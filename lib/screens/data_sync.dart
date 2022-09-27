import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:plantationapp/screens/farmer_reg.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';

class DataSyncDemand extends StatefulWidget {
  //const DataSyncDemand({Key? key}) : super(key: key);

  Map<String, dynamic> FarmerDemand1;


  DataSyncDemand(this.FarmerDemand1);

  @override
  State<DataSyncDemand> createState() => _DataSyncDemandState();
}

class _DataSyncDemandState extends State<DataSyncDemand> {

  String dropdownvalue1 = 'Select District';
  var items1 = [
    'Select District'
  ];

  String villageNameValue = 'Select Village';
  var itemsVillage = [
    'Select Village'
  ];

  String blockNameValue = 'Select Block';
  var itemsBlock = [
    'Select Block'
  ];

  String farmerNameValue = 'Select Farmer';
  var itemsFarmer = [
    'Select Farmer'
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 254, 236, 1),
        body: Container(
          padding: EdgeInsets.all(50),
      child: Column(
        children: [
          SizedBox(height: 30,),
          Text(
            "Data Sync to Cloud",
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
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(

              elevation: 1.0,
              onPressed: ()  {
                //startUpload();
                _uploadFarmerImage();
                //_uploadFarmerReg();

                showDialog(
                              context: context,
                              builder: (BuildContext context) => _buildPopupDialog(context),
                            );

                setState(() {
                  _isLoading = true;
                });


              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.black54,
              child: Text(
                'SYNC DATA',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
          // SizedBox(height: 30,),
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   padding: EdgeInsets.symmetric(vertical: 25.0),
          //   width: double.infinity,
          //   child: RaisedButton(
          //
          //     elevation: 1.0,
          //     onPressed: ()  {
          //       Navigator.of(context).pop();
          //       Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(builder: (BuildContext context) => FarmerDemandSConsent(widget.FarmerDemand1['year'],
          //             widget.FarmerDemand1['status'], widget.FarmerDemand1['date'], widget.FarmerDemand1['district'], widget.FarmerDemand1['block'], widget.FarmerDemand1['village'], widget.FarmerDemand1['farmer'], widget.FarmerDemand1['aadhar'], widget.FarmerDemand1['phone'], widget.FarmerDemand1['gender'], widget.FarmerDemand1['farmer_demand'], widget.FarmerDemand1['farmer_demand_map'], widget.FarmerDemand1['image_farmer'], widget.FarmerDemand1['userID'])),
          //       );
          //
          //     },
          //     padding: EdgeInsets.all(15.0),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     color: Colors.black54,
          //     child: Text(
          //       'EDIT DATA',
          //       style: TextStyle(
          //         color: Colors.white,
          //         letterSpacing: 1.5,
          //         fontSize: 15.0,
          //         fontWeight: FontWeight.w600,
          //         fontFamily: 'OpenSans',
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 0,),
          Container(
            margin: EdgeInsets.only(top: 0),
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(

              elevation: 1.0,
              onPressed: ()  {
                Navigator.of(context).pop();
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (BuildContext context) => FarmerRegistration(blockNameValue, villageNameValue, dropdownvalue1,
                //     itemsBlock, itemsVillage, items1, widget.FarmerDemand1['userID'])),
                // );
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                FarmerRegistration(blockNameValue, villageNameValue, dropdownvalue1,
                         itemsBlock, itemsVillage, items1, box1.get('email'))));

              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.black54,
              child: Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  late Box box3;
  late Box box1;

  @override
  void initState() {
    createBox();
    print(widget.FarmerDemand1['block']);
    print("inside iniit of sync");
    print(widget.FarmerDemand1.toString());
  }

  void createBox()async{
    box3 = await Hive.openBox('demanddata');
    box1 = await Hive.openBox('logindata');
    print(box3.length);
  }


  //final String url = "https:/stand4land.in";
  String url = 'https://stand4land.in/plantation_app/store_image.php';
  final String unencodedPath = "/plantation_app/admin_login.php";
  final Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};


  Future<http.Response> makePostRequest(String url, String unencodedPath , Map<String, String> header, Map<String,String> requestBody) async {
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);
    print(response.body);

    if(response.body=='success'){
      print("succ");
      //rint(items1.length);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
    return response;
  }



  startUpload() {
    print('Uploading Image...');
    if (null == widget.FarmerDemand1['farmer_image']) {
      print("error");
      return;
    }
    String fileName = widget.FarmerDemand1['farmer_image'].path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    String uploadEndPoint1 = 'https://stand4land.in/plantation_app/store_image.php';

    Map<String,String> body = {};

    //url = url+"?image="+File(widget.FarmerDemand1['farmer_image']!.path)+"&name="+fileName;
    // url = url+"&date="+widget.date +"&district="+widget.district
    //     +"&block="+widget.block
    //     +"&village="+widget.village
    //     +"&farmer="+widget.farmer
    //     +"&aadhar="+widget.aadhar
    //     +"&phone="+widget.phone
    //     +"&gender="+widget.gender;


    print("URL"+url);
    makePostRequest(url, unencodedPath, headers, body);

    var uploadEndPoint = 'http://localhost/flutter_test/upload_image.php';
  }

  Future<String?> uploadImage1(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  final String phpEndPoint = 'https://stand4land.in/plantation_app/store_image.php';
  final String phpEndPoint2 = 'https://stand4land.in/plantation_app/store_distribution.php';
  final String phpEndPoint3 = 'https://stand4land.in/plantation_app/store_plantation.php';
  final String phpEndPoint4 = 'https://stand4land.in/plantation_app/store_followup1.php';
  final String phpEndPoint5 = 'https://stand4land.in/plantation_app/store_followup2.php';

  void _uploadFarmerImage() {

    print(box3.length);
    print("values inside the box");
    print(box3.values);
    for (var i = 0; i < box3.length; i++) {
      print(box3.getAt(i));
      print("index: "+ i.toString());
      print(box3.getAt(i)['status']);

      if(box3.getAt(i)['status']=='Visit 1: Demand'){
        //String base64Image = base64Encode(File(widget.FarmerDemand1['farmer_image'].path).readAsBytesSync());
        String fileName = box3.getAt(i)['farmer']+"_"+box1.get('email')+".jpg";

        if (box3.getAt(i)['farmer_signature'] == null) return;
        var _image = MemoryImage(box3.getAt(i)['farmer_signature']);
        String base64ImageFarmer_Sign = base64Encode(box3.getAt(i)['farmer_signature']);
        String fileNameFarmer_Sign = box3.getAt(i)['aadhar']+"_"+box3.getAt(i)['phone'].split("/").last;

        if (box3.getAt(i)['surveyor_signature'] == null) return;
        String base64ImageSurveyor_Sign = base64Encode(box3.getAt(i)['surveyor_signature']);
        String fileNameSurveyor_Sign = box3.getAt(i)['aadhar'].split("/").last;

        print("Data to be sent surveyor");
        print(fileNameSurveyor_Sign.toString());
        print(base64ImageSurveyor_Sign.toString());

        http.post(Uri.parse(phpEndPoint), body: {
          "image_farmer": box3.getAt(i)['farmer_image_base64'],
          "name_image_farmer": box3.getAt(i)['farmer_image_file_name'],
          "image_farmer_sign": base64ImageFarmer_Sign,
          "name_farmer_sign": fileNameFarmer_Sign,
          "image_surveyor_sign": base64ImageSurveyor_Sign,
          "name_surveyor_sign": fileNameSurveyor_Sign,
          "userID": box1.get('email'),
          "aadhar": box3.getAt(i)['aadhar'],
          "fid": box3.getAt(i)['fid'],
          "farmer_demand": box3.getAt(i)['farmer_demand'],
          "farmer_demand_map": box3.getAt(i)['farmer_demand_map'].toString(),

        }).then((res) {
          print("inside data");
          print(res.statusCode);
          print(res.body);

          if(i == box3.length-1){
            setState(() {
              _isLoading = false;

            });

            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialogChecked(context),
            );

          }
          print("isloading"+_isLoading.toString());
        }).catchError((err) {
          print(err);
        });


        http.post(Uri.parse(phpEndPoint1), body: {
          "year": box3.getAt(i)['year'],
          "status": box3.getAt(i)['status'],
          "date": box3.getAt(i)['date'],
          "district": box3.getAt(i)['district'],
          "block": box3.getAt(i)['block'],
          "village": box3.getAt(i)['village'],
          "farmer": box3.getAt(i)['farmer'],
          "aadhar": box3.getAt(i)['aadhar'],
          "phone": box3.getAt(i)['phone'],
          "gender": box3.getAt(i)['gender'],
          "fid": box3.getAt(i)['fid'],
        }).then((res) {
          print(res.statusCode);
          print(res.body);
          if(res.body=="success"){
            print("consent success");

            print("isloading"+_isLoading.toString());

            if(i == box3.length-1){

              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialogChecked(context),
              );

            }

            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) => _buildPopupDialog(context),
            // );
            //return 1;
          }
          else if(res.body!="success"){
            //return 0;
          }
        }).catchError((err) {
          print(err);
        });
      }
      else if(box3.getAt(i)['status']=='Visit 2: Distribution'){
        print("Various");
        print(box3.getAt(i)['farmer_sign']);
        print(box3.getAt(i)['surveyor_signature']);

        if (box3.getAt(i)['farmer_sign'] == null) return;
        var _image = MemoryImage(box3.getAt(i)['farmer_sign']);
        String base64ImageFarmer_Sign = base64Encode(box3.getAt(i)['farmer_sign']);
        String fileNameFarmer_Sign = box3.getAt(i)['fid'].toString()+"_"+box1.get('email').split("/").last;

        if (box3.getAt(i)['surveyor_signature'] == null) return;
        String base64ImageSurveyor_Sign = base64Encode(box3.getAt(i)['surveyor_signature']);
        String fileNameSurveyor_Sign = box3.getAt(i)['fid'].toString().split("/").last;

        print("Data to be sent surveyor");
        print(fileNameSurveyor_Sign.toString());
        print(base64ImageSurveyor_Sign.toString());

        print("VALUES --- ");
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(base64ImageFarmer_Sign);
        print(fileNameFarmer_Sign);
        print(base64ImageSurveyor_Sign);
        print(fileNameSurveyor_Sign);
        print(box1.get('email'));
        print(box3.getAt(i)['fid']);
        print(box3.getAt(i)['agreement']);

        http.post(Uri.parse(phpEndPoint2), body: {
          "image_farmer": box3.getAt(i)['farmer_image_base64'],
          "name_image_farmer": box3.getAt(i)['farmer_image_file_name'],
          "image_farmer_sign": base64ImageFarmer_Sign,
          "name_farmer_sign": fileNameFarmer_Sign,
          "image_surveyor_sign": base64ImageSurveyor_Sign,
          "name_surveyor_sign": fileNameSurveyor_Sign,
          "userID": box1.get('email'),
          "fid": box3.getAt(i)['fid'].toString(),
          "agreement": box3.getAt(i)['agreement'],

        }).then((res) {
          print("inside data");
          print(res.statusCode);
          print(res.body);

          if(i == box3.length-1){
            setState(() {
              _isLoading = false;
            });

            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialogChecked(context),
            );

          }
          print("isloading"+_isLoading.toString());
        }).catchError((err) {
          print(err);
        });
      }
      else if(box3.getAt(i)['status']=='Visit 3: Plantation'){
        print("Various");
        print(box3.getAt(i)['farmer_sign']);
        print(box3.getAt(i)['surveyor_signature']);

        if (box3.getAt(i)['farmer_sign'] == null) return;
        var _image = MemoryImage(box3.getAt(i)['farmer_sign']);
        String base64ImageFarmer_Sign = base64Encode(box3.getAt(i)['farmer_sign']);
        String fileNameFarmer_Sign = box3.getAt(i)['fid'].toString()+"_"+box1.get('email').split("/").last;

        if (box3.getAt(i)['surveyor_signature'] == null) return;
        String base64ImageSurveyor_Sign = base64Encode(box3.getAt(i)['surveyor_signature']);
        String fileNameSurveyor_Sign = box3.getAt(i)['fid'].toString().split("/").last;

        print("Data to be sent surveyor");
        print(fileNameSurveyor_Sign.toString());
        print(base64ImageSurveyor_Sign.toString());

        print("VALUES --- ");
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(base64ImageFarmer_Sign);
        print(fileNameFarmer_Sign);
        print(base64ImageSurveyor_Sign);
        print(fileNameSurveyor_Sign);
        print(box1.get('email'));
        print(box3.getAt(i)['fid']);
        print(box3.getAt(i)['agreement']);


        print("Final Values to be stored");
        print(box1.get('email'));
        print(box3.getAt(i)['fid'].toString());
        print(box3.getAt(i)['tree_type']);
        print(box3.getAt(i)['selected_tree']);
        print(box3.getAt(i)['qty']);
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(box3.getAt(i)['base64ImageFarmer_Sign']);
        print(box3.getAt(i)['fileNameFarmer_Sign']);
        print(box3.getAt(i)['base64ImageSurveyor_Sign']);
        print(box3.getAt(i)['fileNameSurveyor_Sign']);

        for(var j = 0; j < box3.getAt(i)['selected_tree'].length; j++) {
          print("length"+j.toString());
          print("length: " + box3.getAt(i)['selected_tree'].length.toString());
          http.post(Uri.parse(phpEndPoint3), body: {
            "image_farmer": box3.getAt(i)['farmer_image_base64'][j],
            "name_image_farmer": box3.getAt(i)['farmer_image_file_name'][j],
            "image_farmer_sign": base64ImageFarmer_Sign,
            "name_farmer_sign": fileNameFarmer_Sign,
            "image_surveyor_sign": base64ImageSurveyor_Sign,
            "name_surveyor_sign": fileNameSurveyor_Sign,
            "userID": box1.get('email'),
            "fid": box3.getAt(i)['fid'].toString(),
            "tree_type": box3.getAt(i)['tree_type'][j],
            "selected_tree": box3.getAt(i)['selected_tree'][j],
            "qty": box3.getAt(i)['qty'][j],

          }).then((res) {
            print("inside data");
            print(res.statusCode);
            print(res.body);

            if (i == box3.length - 1) {
              if(j == box3.getAt(i)['selected_tree'].length-1){
              setState(() {
                _isLoading = false;
              });

              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialogChecked(context),
              );
            }
            print("isloading" + _isLoading.toString());
          }}).catchError((err) {
            print(err);
          });
        }
      }
      else if(box3.getAt(i)['status']=='Visit 4: FollowUp1'){
        print("Various");
        print(box3.getAt(i)['farmer_sign']);
        print(box3.getAt(i)['surveyor_signature']);

        if (box3.getAt(i)['farmer_sign'] == null) return;
        var _image = MemoryImage(box3.getAt(i)['farmer_sign']);
        String base64ImageFarmer_Sign = base64Encode(box3.getAt(i)['farmer_sign']);
        String fileNameFarmer_Sign = box3.getAt(i)['fid'].toString()+"_"+box1.get('email').split("/").last;

        if (box3.getAt(i)['surveyor_signature'] == null) return;
        String base64ImageSurveyor_Sign = base64Encode(box3.getAt(i)['surveyor_signature']);
        String fileNameSurveyor_Sign = box3.getAt(i)['fid'].toString().split("/").last;

        print("Data to be sent surveyor");
        print(fileNameSurveyor_Sign.toString());
        print(base64ImageSurveyor_Sign.toString());

        print("VALUES --- ");
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(base64ImageFarmer_Sign);
        print(fileNameFarmer_Sign);
        print(base64ImageSurveyor_Sign);
        print(fileNameSurveyor_Sign);
        print(box1.get('email'));
        print(box3.getAt(i)['fid']);
        print(box3.getAt(i)['agreement']);


        print("Final Values to be stored");
        print(box1.get('email'));
        print(box3.getAt(i)['fid'].toString());
        print(box3.getAt(i)['tree_type']);
        print(box3.getAt(i)['selected_tree']);
        print(box3.getAt(i)['qty']);
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(box3.getAt(i)['base64ImageFarmer_Sign']);
        print(box3.getAt(i)['fileNameFarmer_Sign']);
        print(box3.getAt(i)['base64ImageSurveyor_Sign']);
        print(box3.getAt(i)['fileNameSurveyor_Sign']);

        for(var j = 0; j < box3.getAt(i)['selected_tree'].length; j++) {
          print("length"+j.toString());
          print("length: " + box3.getAt(i)['selected_tree'].length.toString());
          http.post(Uri.parse(phpEndPoint4), body: {
            "image_farmer": box3.getAt(i)['farmer_image_base64'][j],
            "name_image_farmer": box3.getAt(i)['farmer_image_file_name'][j],
            "image_farmer_sign": base64ImageFarmer_Sign,
            "name_farmer_sign": fileNameFarmer_Sign,
            "image_surveyor_sign": base64ImageSurveyor_Sign,
            "name_surveyor_sign": fileNameSurveyor_Sign,
            "userID": box1.get('email'),
            "fid": box3.getAt(i)['fid'].toString(),
            "tree_type": "plant/tree",
            "selected_tree": box3.getAt(i)['selected_tree'][j].toString(),
            "qty": box3.getAt(i)['qty'][j].toString(),

          }).then((res) {
            print("inside data");
            print(res.statusCode);
            print(res.body);

            if (i == box3.length - 1) {
              if(j == box3.getAt(i)['selected_tree'].length-1){
                setState(() {
                  _isLoading = false;
                });

                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialogChecked(context),
                );
              }
              print("isloading" + _isLoading.toString());
            }}).catchError((err) {
            print(err);
          });
        }
      }
      else if(box3.getAt(i)['status']=='Visit 5: FollowUp2'){
        print("Various");
        print(box3.getAt(i)['farmer_sign']);
        print(box3.getAt(i)['surveyor_signature']);

        if (box3.getAt(i)['farmer_sign'] == null) return;
        var _image = MemoryImage(box3.getAt(i)['farmer_sign']);
        String base64ImageFarmer_Sign = base64Encode(box3.getAt(i)['farmer_sign']);
        String fileNameFarmer_Sign = box3.getAt(i)['fid'].toString()+"_"+box1.get('email').split("/").last;

        if (box3.getAt(i)['surveyor_signature'] == null) return;
        String base64ImageSurveyor_Sign = base64Encode(box3.getAt(i)['surveyor_signature']);
        String fileNameSurveyor_Sign = box3.getAt(i)['fid'].toString().split("/").last;

        print("Data to be sent surveyor");
        print(fileNameSurveyor_Sign.toString());
        print(base64ImageSurveyor_Sign.toString());

        print("VALUES --- ");
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(base64ImageFarmer_Sign);
        print(fileNameFarmer_Sign);
        print(base64ImageSurveyor_Sign);
        print(fileNameSurveyor_Sign);
        print(box1.get('email'));
        print(box3.getAt(i)['fid']);
        print(box3.getAt(i)['agreement']);


        print("Final Values to be stored");
        print(box1.get('email'));
        print(box3.getAt(i)['fid'].toString());
        print(box3.getAt(i)['tree_type']);
        print(box3.getAt(i)['selected_tree']);
        print(box3.getAt(i)['qty']);
        print(box3.getAt(i)['farmer_image_base64']);
        print(box3.getAt(i)['farmer_image_file_name']);
        print(box3.getAt(i)['base64ImageFarmer_Sign']);
        print(box3.getAt(i)['fileNameFarmer_Sign']);
        print(box3.getAt(i)['base64ImageSurveyor_Sign']);
        print(box3.getAt(i)['fileNameSurveyor_Sign']);

        for(var j = 0; j < box3.getAt(i)['selected_tree'].length; j++) {
          print("length"+j.toString());
          print("length: " + box3.getAt(i)['selected_tree'].length.toString());
          http.post(Uri.parse(phpEndPoint5), body: {
            "image_farmer": box3.getAt(i)['farmer_image_base64'][j],
            "name_image_farmer": box3.getAt(i)['farmer_image_file_name'][j],
            "image_farmer_sign": base64ImageFarmer_Sign,
            "name_farmer_sign": fileNameFarmer_Sign,
            "image_surveyor_sign": base64ImageSurveyor_Sign,
            "name_surveyor_sign": fileNameSurveyor_Sign,
            "userID": box1.get('email'),
            "fid": box3.getAt(i)['fid'].toString(),
            "tree_type": "plant/tree",
            "selected_tree": box3.getAt(i)['selected_tree'][j].toString(),
            "qty": box3.getAt(i)['qty'][j].toString(),

          }).then((res) {
            print("inside data");
            print(res.statusCode);
            print(res.body);

            if (i == box3.length - 1) {
              if(j == box3.getAt(i)['selected_tree'].length-1){
                setState(() {
                  _isLoading = false;
                });

                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialogChecked(context),
                );
              }
              print("isloading" + _isLoading.toString());
            }}).catchError((err) {
            print(err);
          });
        }
      }


    }

    setState(() {
      _isLoading = false;
    });
  }

  final String phpEndPoint1 = 'https://stand4land.in/plantation_app/store_farmer_reg.php';

   void _uploadFarmerReg() {
     print("Data coming 12345");
     print(widget.FarmerDemand1['district']);

    // http.post(Uri.parse(phpEndPoint1), body: {
    //   "year": widget.FarmerDemand1['year'],
    //   "status": widget.FarmerDemand1['status'],
    //   "date": widget.FarmerDemand1['date'],
    //   "district": widget.FarmerDemand1['district'],
    //   "block": widget.FarmerDemand1['block'],
    //   "village": widget.FarmerDemand1['village'],
    //   "farmer": widget.FarmerDemand1['farmer'],
    //   "aadhar": widget.FarmerDemand1['aadhar'],
    //   "phone": widget.FarmerDemand1['phone'],
    //   "gender": widget.FarmerDemand1['gender'],
    //   "fid": widget.FarmerDemand1['fid'],
    // }).then((res) {
    //   print(res.statusCode);
    //   print(res.body);
    //   if(res.body=="success"){
    //     print("consent success");
    //     showDialog(
    //           context: context,
    //           builder: (BuildContext context) => _buildPopupDialog(context),
    //         );
    //     //return 1;
    //   }
    //   else if(res.body!="success"){
    //     //return 0;
    //   }
    // }).catchError((err) {
    //   print(err);
    // });
   //_buildPopupDialog1(context);

  }

  Future<void> _uploadFarmerSign() async {

    if (widget.FarmerDemand1['farmer_signature'] == null) return;
    // File f1 = await File('my_image.jpg').writeAsBytes(widget.FarmerDemand1['farmer_signature']);
    // String base64Image = base64Encode(f1.readAsBytesSync());
    var _image = MemoryImage(widget.FarmerDemand1['farmer_signature']);
    String base64Image = base64Encode(widget.FarmerDemand1['farmer_signature']);
    String fileName = widget.FarmerDemand1['aadhar']+"_"+widget.FarmerDemand1['phone'].split("/").last;

    http.post(Uri.parse(phpEndPoint), body: {
      "image": base64Image,
      "name": fileName,
      "aadhar": widget.FarmerDemand1['aadhar'],
    }).then((res) {
      print(res.statusCode);
      print(res.body);
      if(res.body=="success"){
        _buildPopupDialog(context);
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _uploadSurveyorSign() {
    if (widget.FarmerDemand1['surveyor_signature'] == null) return;
    String base64Image = base64Encode(widget.FarmerDemand1['surveyor_signature']);
    String fileName = widget.FarmerDemand1['aadhar'].split("/").last;

    http.post(Uri.parse(phpEndPoint), body: {
      "image": base64Image,
      "name": fileName,
      "aadhar": widget.FarmerDemand1['aadhar'],
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
     print("_isLoading1"+_isLoading.toString());
    return new AlertDialog(

      title: const Text('Data Sending to the Server', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Center(child:
            Container(
          child: CircularProgressIndicator(),
              height: 100,
              width: 100,
      ),)

        ],
      ),
      // actions: <Widget>[
      //   new FlatButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //       //     FarmerRegistration(blockNameValue, villageNameValue, dropdownvalue1,
      //       //         itemsBlock, itemsVillage, items1, "widget.FarmerDemand1['userID']")),
      //       //         (Route<dynamic> route) => false);
      //     },
      //     textColor: Theme.of(context).primaryColor,
      //     child: const Text('Close'),
      //
      //   ),
      // ],
    );
  }


  Widget _buildPopupDialogChecked(BuildContext context) {
    print("_isLoading1"+_isLoading.toString());
    return new AlertDialog(

      title: const Text('Data Sent Sucessfully', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Center(child:
        Text("Demand of Farmers has been successfuly registered"),)

        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            box3.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                FarmerRegistration(blockNameValue, villageNameValue, dropdownvalue1,
                    itemsBlock, itemsVillage, items1, "widget.FarmerDemand1['userID']")),
                    (Route<dynamic> route) => false);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),

        ),
      ],
    );
  }

  Widget _buildPopupDialog1(BuildContext context) {
    return new CircularProgressIndicator();
  }

  String urlDis = 'https://stand4land.in/plantation_app/get_district_data.php';
  //final String unencodedPath = "/plantation_app/get_district_data.php";
  final String unencodedPath1 = "/plantation_app/get_block_data.php";
  final Map<String, String> headers1 = {'Content-Type': 'application/json; charset=UTF-8'};
  String urlBlock = 'https://stand4land.in/plantation_app/get_block_data.php';
  String urlVillage = 'https://stand4land.in/plantation_app/get_village_data.php';
  String urlFarmer = 'https://stand4land.in/plantation_app/get_farmer_data.php';


  Future<http.Response> makePostRequest0(String url, String unencodedPath , Map<String, String> header) async {
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);
    print(response.body);
    var jsonResult = jsonDecode(response.body);
    // print("items"+items1.length.toString());
    // items1.clear();
    // print("items1"+items1.length.toString());

    //items1.add(d1);
    jsonResult.forEach((s)=> items1.add(s["dname"]));
    print("this");
    print(items1);
    //dropdownvalue1=response.body;
    return response;
  }

  Future<http.Response> makePostRequest1(String url, String unencodedPath , Map<String, String> header) async {
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);
    
    print(response.body);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult.length);
    //items1.add(d1);
    jsonResult.forEach((s)=> itemsBlock.add(s["bname"]));
    print(itemsBlock);
    //dropdownvalue1=response.body;
    return response;
  }

  Future<http.Response> makePostRequest2(String url, String unencodedPath , Map<String, String> header) async {
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);
    print(response.body);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult.length);
    //items1.add(d1);
    jsonResult.forEach((s)=> itemsVillage.add(s["vname"]));
    //dropdownvalue1=response.body;
    return response;
  }

}
