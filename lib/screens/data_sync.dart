import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class DataSyncDemand extends StatefulWidget {
  //const DataSyncDemand({Key? key}) : super(key: key);

  Map<String, dynamic> FarmerDemand1;


  DataSyncDemand(this.FarmerDemand1);

  @override
  State<DataSyncDemand> createState() => _DataSyncDemandState();
}

class _DataSyncDemandState extends State<DataSyncDemand> {



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
              onPressed: (){
                startUpload();
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
        ],
      ),
    ));
  }

  @override
  void initState() {
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

    var uploadEndPoint =
        'http://localhost/flutter_test/upload_image.php';

    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
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

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),

        ),
      ],
    );
  }
}
