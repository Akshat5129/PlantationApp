//import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantationapp/screens/farmer_reg.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _passwordVisible = true;
  TextEditingController controllerUserID = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  @override
  void initState() {
    _passwordVisible = true;
  }

  //final String url = "https:/stand4land.in";
  String url = 'https://stand4land.in/plantation_app/surveyor_login.php';
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerRegistration(),),);
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 231, 169, 1),
      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(
            shrinkWrap: true,
            children: [
              Column(
          children: [
            Image.asset("assets/images/logo1.png", width: 200),
            SizedBox(height: 40,),
            Text(
              "LOGIN",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: .2,
                    fontSize: 29,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

                Container(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                          "User ID",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(134, 56, 48, 1),
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
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                top: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                right: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                left: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            controller: controllerUserID,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              //contentPadding: EdgeInsets.all(1),
                              hintText: 'Enter your User ID',
                              prefixIcon: Icon(Icons.person_rounded),
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

                        Container(
                          child: Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(134, 56, 48, 1),
                                  letterSpacing: .2,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          padding: EdgeInsets.only(left: 5, top: 40),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 6, top: 2, right: 6, bottom: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                top: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                right: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                left: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            controller: controllerPass,
                            obscureText: _passwordVisible,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              //contentPadding: EdgeInsets.all(1),
                              hintText: 'Your Password',
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    print("instate");
                                    print(_passwordVisible);
                                    _passwordVisible = !_passwordVisible;

                                  });
                                },
                              ),
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

                        GestureDetector(child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 1.0,
                            onPressed: (){
                              print("in pressed");
                              url = 'https://stand4land.in/plantation_app/surveyor_login.php';

                              Map<String,String> body = {'user_id': controllerUserID.text, 'password': controllerPass.text};

                              url = url+"?user_id="+controllerUserID.text+"&password="+controllerPass.text;
                              print("URL"+url);
                              makePostRequest(url, unencodedPath, headers, body);
                             // Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerRegistration(),),);
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Color.fromRGBO(243, 214, 139, 1.0),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Color.fromRGBO(93, 43, 14, 1),
                                letterSpacing: 1.5,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),),

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ])
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Incorrect User ID or Password', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Center(child:
        Text("Please enter correct User ID or Password"),)

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
