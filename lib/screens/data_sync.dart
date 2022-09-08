import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
}
