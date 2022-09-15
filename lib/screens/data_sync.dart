import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
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
                _uploadFarmerReg();


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
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                FarmerRegistration(blockNameValue, villageNameValue, dropdownvalue1,
                         itemsBlock, itemsVillage, items1, widget.FarmerDemand1['userID'])), (Route<dynamic> route) => false);

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

  @override
  void initState() {
    print(widget.FarmerDemand1['block']);
    print("inside iniit of sync");
    print(widget.FarmerDemand1.toString());

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

  void _uploadFarmerImage() {
    if (widget.FarmerDemand1['farmer_image'] == null) return;
    String base64Image = base64Encode(File(widget.FarmerDemand1['farmer_image'].path).readAsBytesSync());
    String fileName = widget.FarmerDemand1['farmer_image'].path.split("/").last;

    if (widget.FarmerDemand1['farmer_signature'] == null) return;
    var _image = MemoryImage(widget.FarmerDemand1['farmer_signature']);
    String base64ImageFarmer_Sign = base64Encode(widget.FarmerDemand1['farmer_signature']);
    String fileNameFarmer_Sign = widget.FarmerDemand1['aadhar']+"_"+widget.FarmerDemand1['phone'].split("/").last;

    if (widget.FarmerDemand1['surveyor_signature'] == null) return;
    String base64ImageSurveyor_Sign = base64Encode(widget.FarmerDemand1['surveyor_signature']);
    String fileNameSurveyor_Sign = widget.FarmerDemand1['aadhar'].split("/").last;

    http.post(Uri.parse(phpEndPoint), body: {
      "image_farmer": base64Image,
      "name_image_farmer": fileName,
      "image_farmer_sign": base64ImageFarmer_Sign,
      "name_farmer_sign": fileNameFarmer_Sign,
      "image_surveyor_sign": base64ImageSurveyor_Sign,
      "name_surveyor_sign": fileNameSurveyor_Sign,
      "userID": widget.FarmerDemand1['userID'],
      "aadhar": widget.FarmerDemand1['aadhar'],
      "farmer_demand": widget.FarmerDemand1['farmer_demand'],
      "farmer_demand_map": widget.FarmerDemand1['farmer_demand_map'].toString(),

    }).then((res) {
      print(res.statusCode);
      print(res.body);
    }).catchError((err) {
      print(err);
    });
  }

  final String phpEndPoint1 = 'https://stand4land.in/plantation_app/store_farmer_reg.php';

   void _uploadFarmerReg() {

    http.post(Uri.parse(phpEndPoint1), body: {
      "year": widget.FarmerDemand1['year'],
      "status": widget.FarmerDemand1['status'],
      "date": widget.FarmerDemand1['date'],
      "district": widget.FarmerDemand1['district'],
      "block": widget.FarmerDemand1['block'],
      "village": widget.FarmerDemand1['village'],
      "farmer": widget.FarmerDemand1['farmer'],
      "aadhar": widget.FarmerDemand1['aadhar'],
      "phone": widget.FarmerDemand1['phone'],
      "gender": widget.FarmerDemand1['gender'],
    }).then((res) {
      print(res.statusCode);
      print(res.body);
      if(res.body=="success"){
        print("consent success");
        showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
        //return 1;
      }
      else if(res.body!="success"){
        //return 0;
      }
    }).catchError((err) {
      print(err);
    });
    _buildPopupDialog1(context);
    //return 2;
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
    return new AlertDialog(
      title: const Text('Data Sent Sucessfully', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
      content: new Column(
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
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                FarmerRegistration(blockNameValue, villageNameValue, dropdownvalue1,
                    itemsBlock, itemsVillage, items1, widget.FarmerDemand1['userID'])),
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
