import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantationapp/screens/farmer_reg.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';

import 'farmer_consent.dart';

class FarmerDemand extends StatefulWidget {
  const FarmerDemand({Key? key}) : super(key: key);

  @override
  State<FarmerDemand> createState() => _FarmerDemandState();
}

class _FarmerDemandState extends State<FarmerDemand> {

  String dropdownvalue = 'Visit 1: Demand';
  var items = [
    'Visit 1: Demand',
    'Visit 2: Distribution',
    'Visit 3: Plantation',
    'Visit 4: FollowUp1',
    'Visit 5: FollowUp2',
    'Conclusion'
  ];

  String dropdownvalue1 = 'D1';
  var items1 = [
    'D1',
    'D2',
    'D3',
  ];

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
                          "Farmer's Demand",
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
                                    child: DropdownButton(
                                      isExpanded: true,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black54,
                                            letterSpacing: .2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      value: dropdownvalue1,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: items1.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue1 = newValue!;
                                        });
                                      },
                                    )
                                ),


                                SizedBox(height: 20,),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Select Tree",
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
                                    child: DropdownButton(
                                      isExpanded: true,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black54,
                                            letterSpacing: .2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      value: dropdownvalue1,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: items1.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue1 = newValue!;
                                        });
                                      },
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 1.0,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDemandFConsent(),),);
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
                            ))])])));}}
