import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantationapp/screens/farmer_demand.dart';
import 'package:plantationapp/screens/farmer_distribution.dart';
import 'package:plantationapp/screens/farmer_plantation.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';
import 'package:http/http.dart' as http;

class FarmerRegistration extends StatefulWidget {
  const FarmerRegistration({Key? key}) : super(key: key);

  @override
  State<FarmerRegistration> createState() => _FarmerRegistrationState();
}

class _FarmerRegistrationState extends State<FarmerRegistration> {

  List data = [];
  String _mySelection="Dang";

  DateTime _selected = DateTime.now();

  final TextEditingController yearController = new TextEditingController();
  final TextEditingController dateController = new TextEditingController();

  DateTime dateToday =new DateTime.now();
  String dateTod = DateTime.now().toString().substring(0,10);


  String dropdownvalue = 'Visit 1: Demand';
  var items = [
    'Visit 1: Demand',
    'Visit 2: Distribution',
    'Visit 3: Plantation',
    'Visit 4: FollowUp1',
    'Visit 5: FollowUp2',
    'Conclusion'
  ];

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

  dynamic d1 = "District";
  dynamic districts = ['District'];

  String dd1 = "Dang";
  List list1=[];
  Map<String, int> map1 = {};

  String dropdownvalue2 = 'Male';
  var items2 = [
    'Male',
    'Female',
    'Others'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    dateController.text=dateTod;
    makePostRequest(url, unencodedPath, headers);
    makePostRequest1(urlBlock, unencodedPath1, headers);
    makePostRequest2(urlVillage, unencodedPath, headers);
  }

  //final String url = "https:/stand4land.in";
  String url = 'https://stand4land.in/plantation_app/get_district_data.php';
  final String unencodedPath = "/plantation_app/get_district_data.php";
  final String unencodedPath1 = "/plantation_app/get_block_data.php";
  final Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
  String urlBlock = 'https://stand4land.in/plantation_app/get_block_data.php';
  String urlVillage = 'https://stand4land.in/plantation_app/get_village_data.php';
  String urlFarmer = 'https://stand4land.in/plantation_app/get_farmer_data.php';


  Future<http.Response> makePostRequest(String url, String unencodedPath , Map<String, String> header) async {
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);
    print(response.body);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult.length);
    d1 = jsonResult[0]['dname'];
    jsonResult.forEach((s)=> districts.add(s["dname"]));
    print(d1);
    print(districts);
    list1.add(d1);
    //items1.add(d1);
    jsonResult.forEach((s)=> items1.add(s["dname"]));
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
    d1 = jsonResult[0]['bname'];
    jsonResult.forEach((s)=> districts.add(s["bname"]));
    print(d1);
    print(districts);
    list1.add(d1);
    //items1.add(d1);
    jsonResult.forEach((s)=> itemsBlock.add(s["bname"]));
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
    d1 = jsonResult[0]['vname'];
    jsonResult.forEach((s)=> districts.add(s["vname"]));
    print(d1);
    print(districts);
    list1.add(d1);
    //items1.add(d1);
    jsonResult.forEach((s)=> itemsVillage.add(s["vname"]));
    //dropdownvalue1=response.body;
    return response;
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
              "Farmer's Registration",
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
                  Container(
                    child: Text(
                      "Year",
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
                          color:Color.fromRGBO(255, 235, 220, 1),
                          border: Border.all(
                              color: Color.fromRGBO(255, 235, 220, 1)
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      margin: EdgeInsets.only(top: 1),
                      child: TextField(
                        readOnly: true,
                        controller: yearController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          //contentPadding: EdgeInsets.all(1),
                          hintText: 'Select year',
                          prefixIcon: Icon(Icons.calendar_month_sharp),
                        ),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black54,
                            letterSpacing: .2,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: (){
                          print("object");
                          showDialog(context: context, builder:(BuildContext context) => _buildPopupDialog(context));
                        },
                      ),


                      // child: YearPicker(
                      //   firstDate: DateTime(2018),
                      //   lastDate: DateTime.now(),
                      //   selectedDate: _selected,
                      //   onChanged: (DateTime){
                      //       _selected = DateTime;
                      //   },
                      // )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text(
                      "Status of Visit",
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
                        color:Color.fromRGBO(255, 235, 220, 1),
                        border: Border.all(
                          color: Color.fromRGBO(255, 235, 220, 1)
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
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),

                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;

                        });
                      },
                    )
                  ),

                  SizedBox(height: 40,),
                  Container(
                    child: Text(
                      "Date",
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
                      controller: dateController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //contentPadding: EdgeInsets.all(1),

                        prefixIcon: Icon(Icons.date_range_outlined),
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
                      "District",
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
                            enabled: items != 'Select District',
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
                    child: Text(
                      "Block Name",
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
                        value: blockNameValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsBlock.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            blockNameValue = newValue!;
                          });
                        },
                      )
                  ),


                  SizedBox(height: 20,),
                  Container(
                    child: Text(
                      "Village Name",
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
                        value: villageNameValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsVillage.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            villageNameValue = newValue!;
                          });
                        },
                      )
                  ),

                  SizedBox(height: 20,),
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
                    child: Text(
                      "Aadhar Number",
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
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //contentPadding: EdgeInsets.all(1),
                        hintText: "Enter your Aadhar Number",
                        prefixIcon: Icon(Icons.credit_card_rounded),
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
                      "Phone No",
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
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          //contentPadding: EdgeInsets.all(1),
                          hintText: 'Enter your Phone No',
                          prefixIcon: Icon(Icons.phone),
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
                      "Gender",
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
                        value: dropdownvalue2,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items2.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue2 = newValue!;
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
                       // _buildPopupDialog(context);
                        if(dropdownvalue=="Visit 1: Demand"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDemand(),),);
                        }else if(dropdownvalue=="Visit 2: Distribution"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDistribution(),),);
                        }else if(dropdownvalue=="Visit 3: Plantation"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerPlantation(),),);
                        }
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
              ),
            )
          ],
        ),
          ],
        )
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    print("object22");
        return new AlertDialog(
          title: Text("Select Year"),
          content: Container( // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: _selected,
              onChanged: (DateTime dateTime) {
                // close the dialog when year is selected.
                yearController.text=dateTime.year.toString();
                Navigator.pop(context);

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
  }

}
