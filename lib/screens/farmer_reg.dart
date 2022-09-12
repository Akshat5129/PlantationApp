import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantationapp/screens/farmer_demand.dart';
import 'package:plantationapp/screens/farmer_distribution.dart';
import 'package:plantationapp/screens/farmer_plantation.dart';
import 'package:plantationapp/screens/surveyor_consent.dart';
import 'package:http/http.dart' as http;

class FarmerRegistration extends StatefulWidget {
  //const FarmerRegistration({Key? key}) : super(key: key);

  String valueBlock1, valueVillage1, valueDistrict1, userID;
  var  itemsBlock1, itmesVillage1, itemsDIstrict1;



  FarmerRegistration(
      this.valueBlock1,
      this.valueVillage1,
      this.valueDistrict1,
      this.itemsBlock1,
      this.itmesVillage1,
      this.itemsDIstrict1,
      this.userID); // FarmerRegistration(
  //     this.valueFarmer,
  //     this.valueBlock,
  //     this.valueVillage,
  //     this.valueDistrict,
  //     this.itemsFarmer,
  //     this.itemsBlock,
  //     this.itmesVillage,
  //     this.itemsDIstrict);

  @override
  State<FarmerRegistration> createState() => _FarmerRegistrationState();
}

class _FarmerRegistrationState extends State<FarmerRegistration> {

  List data = [];
  String _mySelection="Dang";

  DateTime _selected = DateTime.now();

  final TextEditingController yearController = new TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController aadharController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  TextEditingController controllerEmpBankName = TextEditingController();

  bool _validateYear= false;

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
  var items8 = [
    'Select District'
  ];
  var districtID=[];
  var items3 = [];

  String villageNameValue = 'Select Village';
  var itemsVillage = [
    'Select Village'
  ];

  String blockNameValue = 'Select Block';
  var itemsBlock = [
    'Select Block'
  ];
  var blockDID = [];
  var blockID = [];

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
    print("in");
    print("${widget.itemsDIstrict1}");
    items1.clear();
    dateController.text=dateTod;
    makePostRequest(url, unencodedPath, headers);
    makePostRequest1(urlBlock, unencodedPath1, headers);
    makePostRequest2(urlVillage, unencodedPath, headers);
    items1=widget.itemsDIstrict1;
    //itemsBlock=widget.itemsBlock1;
    //itemsVillage=widget.itmesVillage1;
    items3= widget.itemsDIstrict1;
    print(items1.toString());
  }

  //final String url = "https:/stand4land.in";
  String url = 'https://stand4land.in/plantation_app/get_district_data.php';
  final String unencodedPath = "/plantation_app/get_district_data.php";
  final String unencodedPath1 = "/plantation_app/get_block_data.php";
  final Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
  String urlBlock = 'https://stand4land.in/plantation_app/get_block_data.php';
  String urlVillage = 'https://stand4land.in/plantation_app/get_village_data.php';
  String urlFarmer = 'https://stand4land.in/plantation_app/get_farmer_data.php';

  String urlBlock1 = 'https://stand4land.in/plantation_app/get_block_data_from_did.php';
  String urlVillage1 = 'https://stand4land.in/plantation_app/get_block_data_from_did.php';
  String urlFarmer1 = 'https://stand4land.in/plantation_app/get_farmer_data_from_vid.php';

  Future<List<String>> makePostRequest(String url, String unencodedPath , Map<String, String> header) async {
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
    print("values1"+items8.length.toString());
    items8.clear();
    districtID.clear();
    print("values2"+items8.length.toString());
    items8.add("Select District");
    jsonResult.forEach((s)=> items8.add(s["dname"]));
    jsonResult.forEach((s)=> districtID.add(s["did"]));
    print("values3"+items8.length.toString());
    //dropdownvalue1=response.body;
    return items8;
  }

  Future<List<String>> makePostRequest1(String url, String unencodedPath , Map<String, String> header) async {
    print("34 url: "+url);
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
    itemsBlock.clear();
    itemsBlock.add("Select Block");
    jsonResult.forEach((s)=> districts.add(s["bname"]));
    print(d1);
    print(districts);
    list1.add(d1);
    //items1.add(d1);
    blockID.clear();
    blockDID.clear();
    jsonResult.forEach((s)=> itemsBlock.add(s["bname"]));
    jsonResult.forEach((s)=> blockDID.add(s["did"]));
    jsonResult.forEach((s)=> blockID.add(s["bid"]));
    //dropdownvalue1=response.body;
    return itemsBlock;
  }

  Future<List<String>> makePostRequest2(String url, String unencodedPath , Map<String, String> header) async {
    print("34 url1: "+url);
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);   //colors: status code and body
    print(response.body);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult.length);
    d1 = jsonResult[0]['vname'];
    itemsVillage.clear();
    itemsVillage.add("Select Village");
    jsonResult.forEach((s)=> districts.add(s["vname"]));
    print(d1);
    print(districts);
    list1.add(d1);
    //items1.add(d1);
    jsonResult.forEach((s)=> itemsVillage.add(s["vname"]));
    //dropdownvalue1=response.body;
    return itemsVillage;
  }

  Future<List<String>> makePostRequest3(String url, String unencodedPath , Map<String, String> header) async {
    final response = await http.get(
      //Uri.http(url,unencodedPath),
      Uri.parse(url),
      headers: header,
    );
    print(response.statusCode);
    print(response.body);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult.length);
    d1 = jsonResult[0]['fname'];
    itemsFarmer.clear();
    itemsFarmer.add("Select Farmer");
    jsonResult.forEach((s)=> districts.add(s["fname"]));
    print(d1);
    print(districts);
    list1.add(d1);
    //items1.add(d1);
    jsonResult.forEach((s)=> itemsFarmer.add(s["fname"]));
    //dropdownvalue1=response.body;
    return itemsFarmer;
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
                        onChanged: (value){
                          setState(() {
                            yearController.text.isEmpty ? _validateYear = true : _validateYear = false;
                          });
                        },
                        readOnly: true,
                        controller: yearController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          //contentPadding: EdgeInsets.all(1),
                          hintText: 'Select year',
                          prefixIcon: Icon(Icons.calendar_month_sharp),
                          errorText: _validateYear ? 'Select Year' : null,
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
                      child: FutureBuilder<List>(
                        future: makePostRequest(url, unencodedPath, headers),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButtonFormField(
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
                              validator: (value) => dropdownvalue1 == "Select District"
                                  ? 'Please Select a District' : null,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data?.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                  enabled: items != 'Select District',
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                print(newValue);
                                print("object");
                                setState(() {
                                  dropdownvalue1 = newValue.toString();
                                  //getDistrictID(newValue.toString());
                                  getBlockDatafromDistrict(newValue.toString());
                                  itemsBlock = getBlockDatafromDistrict(newValue.toString());
                                  //_buildDropDownBlock(context);
                                });
                              },

                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      // child: DropdownButton(
                      //   isExpanded: true,
                      //   style: GoogleFonts.lato(
                      //     textStyle: TextStyle(
                      //         color: Colors.black54,
                      //         letterSpacing: .2,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600
                      //     ),
                      //   ),
                      //   value: dropdownvalue1,
                      //   icon: const Icon(Icons.keyboard_arrow_down),
                      //   items: items1.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //       enabled: items != 'Select District',
                      //     );
                      //   }).toList(),
                      //   // After selecting the desired option,it will
                      //   // change button value to selected value
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue1 = newValue!;
                      //     });
                      //   },
                      // )
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
                      child: _buildDropDownBlock(context)
                      // child: FutureBuilder<List>(
                      //   future: makePostRequest1(urlBlock, unencodedPath, headers),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return DropdownButton(
                      //         isExpanded: true,
                      //         style: GoogleFonts.lato(
                      //           textStyle: TextStyle(
                      //               color: Colors.black54,
                      //               letterSpacing: .2,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w600
                      //           ),
                      //         ),
                      //         value: blockNameValue,
                      //         icon: const Icon(Icons.keyboard_arrow_down),
                      //         items: snapshot.data?.map((items) {
                      //           return DropdownMenuItem(
                      //             value: items,
                      //             child: Text(items),
                      //             enabled: items != 'Select Block',
                      //           );
                      //         }).toList(),
                      //         // After selecting the desired option,it will
                      //         // change button value to selected value
                      //         onChanged: (newValue) {
                      //           print(newValue);
                      //           print("object");
                      //           setState(() {
                      //             blockNameValue = newValue.toString();
                      //             getBlockID(newValue.toString());
                      //           });
                      //         },
                      //       );
                      //     }
                      //     return Center(child: CircularProgressIndicator());
                      //   },
                      // )
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
                            enabled: items != 'Select Block',
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            villageNameValue = newValue!;
                          });
                        },
                      ),
                      // child: FutureBuilder<List>(
                      //   future: makePostRequest2(urlVillage, unencodedPath, headers),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return DropdownButton(
                      //         isExpanded: true,
                      //         style: GoogleFonts.lato(
                      //           textStyle: TextStyle(
                      //               color: Colors.black54,
                      //               letterSpacing: .2,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w600
                      //           ),
                      //         ),
                      //         value: villageNameValue,
                      //         icon: const Icon(Icons.keyboard_arrow_down),
                      //         items: snapshot.data?.map((items) {
                      //           return DropdownMenuItem(
                      //             value: items,
                      //             child: Text(items),
                      //             enabled: items != 'Select Village',
                      //           );
                      //         }).toList(),
                      //         // After selecting the desired option,it will
                      //         // change button value to selected value
                      //         onChanged: (newValue) {
                      //           print(newValue);
                      //           print("object");
                      //           setState(() {
                      //             villageNameValue = newValue.toString();
                      //           });
                      //         },
                      //       );
                      //     }
                      //     return Center(child: CircularProgressIndicator());
                      //   },
                      // ),
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
                      child: FutureBuilder<List>(
                        future: makePostRequest3(urlFarmer, unencodedPath, headers),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButton(
                              isExpanded: true,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    letterSpacing: .2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              value: farmerNameValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data?.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                  enabled: items != 'Select Farmer',
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                print(newValue);
                                print("object");
                                setState(() {
                                  farmerNameValue = newValue.toString();
                                });
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
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
                      controller: aadharController,
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
                        controller: phoneController,
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
                        setState(() {
                          yearController.text.isEmpty ? _validateYear = true : _validateYear = false;
                          yearController.text.isEmpty ? _validateYear = true : _validateYear = false;
                        });

                        if(yearController.text!=""&&dropdownvalue1!="Select District"&&blockNameValue!="Select Block"&&villageNameValue!="&&"&&farmerNameValue!=""){
                          print("inside this");
                          // _buildPopupDialog(context);
                          if(dropdownvalue=="Visit 1: Demand"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDemand(
                                yearController.text,
                                dropdownvalue,
                                dateController.text,
                                dropdownvalue1,
                                blockNameValue,
                                villageNameValue,
                                farmerNameValue,
                                aadharController.text,
                                phoneController.text,
                                dropdownvalue2,
                                widget.userID
                            ),),);
                          }else if(dropdownvalue=="Visit 2: Distribution"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerDistribution(),),);
                          }else if(dropdownvalue=="Visit 3: Plantation"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerPlantation(),),);
                          }
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

  List<dynamic> getDistrictID(String name) {
    int index = items8.indexOf(name)-1;
    print("1234index of item: "+index.toString());
    print("1234district id"+districtID[index]);
    int i = 0;
    print("District id: "+districtID.toString());
    print("block id: "+blockID.toString());
    var itemsBlock1 = [];
    blockDID.forEach((item) async {
      print("1234 i: "+item);
      if(item==districtID[index]){
        int index1 = blockDID.indexOf(item);
        print("1234 a"+blockID[i]);
        await makePostRequest1(urlBlock, unencodedPath, headers);
        itemsBlock1.add("Select Block");
        itemsBlock1.add(itemsBlock[i]);
        //itemsBlock.clear();
        //itemsBlock1.add("Select Block");

      }
      i+=1;
    });
    return itemsBlock1;

  }

  void getBlockID(String name) {
    int index = itemsBlock.indexOf(name);
    print("block id"+blockID[index]);
    final index1 = items8.indexWhere((element) =>
    element == name);
    print("block id 222: "+index1.toString());
    print("block id1"+districtID[index]);
  }

  getBlockData() {
    if(itemsBlock.length==1){
      return makePostRequest1(urlBlock, unencodedPath, headers);
    }else if(itemsBlock.length>1){
      print("1234 inside length");
      return getDistrictID(dropdownvalue1);
      // itemsBlock.remove("Select District1");
      // makePostRequest1(urlBlock, unencodedPath, headers);
    }
  }


  getBlockDatafromDistrict(String name){
    int index = items8.indexOf(name)-1;
    print("34index of item: "+index.toString());
    print("34district id"+districtID[index]);
    int i = 0;
    // print("34District id: "+districtID[index].toString());
    // print("34block id: "+blockID[index].toString());
    urlBlock1 = 'https://stand4land.in/plantation_app/get_block_data_from_did.php';
    urlBlock1 = urlBlock1+"?did="+districtID[index];
    makePostRequest1(urlBlock1, unencodedPath, headers);
    itemsBlock.forEach((item) async {
      print("34 i: "+item);
    });
    return itemsBlock;
  }

  getVillageDatafromBlock(String name){
    int index = itemsBlock.indexOf(name)-1;
    print("341index of item: "+index.toString());
    print("341district id"+blockID[index]);
    int i = 0;
    // print("34District id: "+districtID[index].toString());
    // print("34block id: "+blockID[index].toString());
    urlVillage1 = 'https://stand4land.in/plantation_app/get_village_data_from_bid.php';
    urlVillage1 = urlVillage1+"?did="+blockID[index];
    makePostRequest2(urlVillage1, unencodedPath, headers);
    itemsVillage.forEach((item) async {
      print("34 i: "+item);
    });
    return itemsVillage;
  }


  Widget _buildDropDownBlock(BuildContext context) {
    return new DropdownButton(
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
          enabled: items != 'Select Block',
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          blockNameValue = newValue!;
          getVillageDatafromBlock(newValue);
        });
      },
    );
  }




}
