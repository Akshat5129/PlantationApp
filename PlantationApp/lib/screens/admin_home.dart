import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 254, 236, 1),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          Text(
            "ADMIN PANEL",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Color.fromRGBO(204, 104, 23, 1),
                  letterSpacing: .2,
                  fontSize: 24,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(height: 80,),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 25.0),
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
                                      Icon(Icons.upload_file_rounded),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Upload CSV File",
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
              color: Color.fromRGBO(243, 214, 139, 1.0),
              child: Text(
                'Add the Data',
                style: TextStyle(
                  color: Color.fromRGBO(93, 43, 14, 1),
                  letterSpacing: 1.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
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
              color: Color.fromRGBO(243, 214, 139, 1),
              child: Text(
                'See the Data',
                style: TextStyle(
                  color: Color.fromRGBO(93, 43, 14, 1),
                  letterSpacing: 1.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
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
              color: Color.fromRGBO(243, 214, 139, 1.0),
              child: Text(
                'Add the Surveyor',
                style: TextStyle(
                  color: Color.fromRGBO(93, 43, 14, 1),
                  letterSpacing: 1.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      )
      )
    );
  }
}
