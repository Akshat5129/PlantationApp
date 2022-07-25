import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantationapp/screens/farmer_reg.dart';
//import 'package:plantationapp/screens/farmer_reg3.dart';
import 'package:signature/signature.dart';
//import 'package:plantationapp/screens/farmer_reg2.dart';

class FarmerPlantationSConsent extends StatefulWidget {
  const FarmerPlantationSConsent({Key? key}) : super(key: key);

  @override
  State<FarmerPlantationSConsent> createState() => _FarmerPlantationSConsentState();
}

class _FarmerPlantationSConsentState extends State<FarmerPlantationSConsent> {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  DateTime _selected = DateTime.now();

  final TextEditingController yearController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 254, 236, 1),
        body: Container(
            padding: EdgeInsets.all(50),
            child: Form(
                child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                          children: [
                            SizedBox(height: 40,),
                            Text(
                              "Surveyor’s Consent",
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
                                        "Farmer Name",
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
                                        child: TextFormField(
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.black54,
                                                letterSpacing: .2,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        )
                                    ),


                                    SizedBox(height: 20,),
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
                                            color:Color.fromRGBO(215, 222, 199, 1.0),
                                            border: Border.all(
                                                color: Color.fromRGBO(215, 222, 199, 1.0)
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        margin: EdgeInsets.only(top: 1),
                                        child: TextFormField(
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.black54,
                                                letterSpacing: .2,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        )
                                    ),

                                    SizedBox(height: 20,),
                                    Container(
                                      child: Text(
                                        "Tree Name",
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
                                        child: TextFormField(
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.black54,
                                                letterSpacing: .2,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        )
                                    ),

                                    SizedBox(height: 20,),
                                    Container(
                                      child: Text(
                                        "Surveyor's Signature",
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
                                        color: Colors.red,
                                        onPressed: (){
                                          _controller.clear();
                                        }, icon: Icon(
                                        Icons.clear,
                                      ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 1),
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        color: Colors.red,
                                        onPressed: (){
                                          _controller.clear();
                                        }, icon: Icon(
                                        Icons.done_all_outlined,
                                      ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.symmetric(vertical: 25.0),
                                      width: double.infinity,
                                      child: RaisedButton(
                                        elevation: 1.0,
                                        onPressed: (){
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerRegistration3(),),);
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
                                ))])]))));}}