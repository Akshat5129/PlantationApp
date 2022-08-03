import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';
import 'package:path/path.dart' as Path;

import 'package:http_parser/http_parser.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  String dropdownvalue2 = 'district';
  var items2 = [
    'district',
    'block',
    'village'
  ];

  List<PlatformFile>? _paths;
  String? _extension="csv";
  FileType _pickingType = FileType.custom;
  late List<List<dynamic>> employeeData;

  List<List<dynamic>> _data = [];


  pickFile() async {
    print("fields-");
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);



    } else {
      // User canceled the picker
    }
  }


  void _openFileExplorer() async {

    try {

      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      //openFile(_paths![0].path);
      print(_paths);
      print("File path ${_paths![0]}");
      print(_paths!.first.extension);

    });
  }


  // openFile(filepath) async
  // {
  //   File f = new File(filepath);
  //   print("CSV to List");
  //   final input = f.openRead();
  //   final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
  //   print(fields);
  //   setState(() {
  //     employeeData=fields;
  //   });
  // }



  List<PlatformFile>? _files;

  void _uploadFile() async {
    //TODO replace the url bellow with you ipv4 address in ipconfig
    var uri = Uri.parse('https://stand4land.in/plantation_app/files');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', _files!.first.path.toString()));
    var response = await request.send();
    if(response.statusCode == 200) {
      print('Uploaded ...');
    } else {
      print('Something went wrong!');
    }

  }

  void _openFileExplorer1() async {
    _files = (await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        allowedExtensions: null
    ))!.files;

    print('Loaded file path is : ${_files!.first.path}');
    _uploadFile();
  }



  List<int>? _selectedFile;
  Uint8List? _bytesData;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    print("inside upload input");
    print(uploadInput);

    uploadInput.onChange.listen((event) {
      print("inside change");
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        print("inside load");
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = _bytesData;
          print(_bytesData);
        });
      });
      reader.readAsDataUrl(file);
    });
    print(_selectedFile);
    uploadImage();
  }

  Future uploadImage() async {
    var url = Uri.parse("https://stand4land.in/plantation_app/files");
    var request = http.MultipartRequest("POST", url);
    print("ioi");
    print(_selectedFile);
    request.files.add(await http.MultipartFile.fromBytes('file', _selectedFile!,
        contentType: MediaType('application', 'json'), filename: "district"));

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("File uploaded successfully");
      } else {
        print('file upload failed');
      }
    });
  }

  late Uint8List uploadedCsv;
  late String option1Text;


  _startFilePicker(String s) async {
    html.FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files?.length == 1) {
        final file = files![0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          List<String> csvrows = [];
          setState(() {
            uploadedCsv = Base64Decoder()
                .convert(reader.result.toString().split(",").last);
            print("file");
            print(utf8.decode(uploadedCsv));
            csvrows.add(utf8.decode(uploadedCsv));
            //print(csvrows);
            //createAlbum1(utf8.decode(uploadedCsv).toString());
            senddata(s,utf8.decode(uploadedCsv).toString());

          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsDataUrl(file);
      }
    });
  }

  Future<http.Response> createAlbum(List<String> csvrows1) {
    print(csvrows1);
    return http.post(
      Uri.parse('https://stand4land.in/plantation_app/add_csv_data.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'csvtype': dropdownvalue2,
        'list': csvrows1.toString()
      }),
    );
  }

  Future<http.Response> senddata(String s, String val) async {
    print(s);
    var mapData = new Map<String, dynamic>();
    mapData['csvtype'] = s;
    mapData['list'] = val;

    if(s=="district"){
    final http.Response response = await http.post(
        Uri.parse('https://stand4land.in/plantation_app/add_csv_data.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: mapData
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response
      // then parse the JSON.
      print(Album.fromJson(jsonDecode(response.body)));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //print(Album.fromJson(jsonDecode(response.body)));

      throw Exception('Failed to create album.');
    }

    return response;
    } else{
      final http.Response response = await http.post(
          Uri.parse('https://stand4land.in/plantation_app/add_csv_data_3col.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: mapData
      );

      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response
        // then parse the JSON.
        print(Album.fromJson(jsonDecode(response.body)));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        //print(Album.fromJson(jsonDecode(response.body)));

        throw Exception('Failed to create album.');
      }

      return response;
    }

  }

  Future<Album> createAlbum1(String title) async {
    final response = await http.post(
      Uri.parse('https://stand4land.in/plantation_app/add_csv_data.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'csvtype': 'district',
        'list': 'cl',
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(Album.fromJson(jsonDecode(response.body)));
      throw Exception('Failed to create album.');
    }
  }


  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Data Added Sucessfully', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Center(child:
        Text("Incorrect OTP. PLease enter OTP number sent to your entered mobile number"),)

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
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "",
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
                                child: DropdownButtonFormField(
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
                                    if(dropdownvalue2=='district') {
                                      _startFilePicker("district");
                                    }
                                       else if(dropdownvalue2=='village')
                                      _startFilePicker("village");
                                    else if(dropdownvalue2=='block')
                                      _startFilePicker("block");

                                    //startWebFilePicker();
                                    //getFile();
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

class Album {
  final int csvtype;
  final String list;


  const Album({required this.csvtype, required this.list});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      csvtype: json['id'],
      list: json['title'],
    );
  }
}
