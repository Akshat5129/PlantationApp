
import 'package:flutter/material.dart';


class UserType extends StatefulWidget {


  String valueBlock1, valueVillage1, valueDistrict1, userID;
  var  itemsBlock1, itmesVillage1, itemsDIstrict1;

  UserType(
      this.valueBlock1,
      this.valueVillage1,
      this.valueDistrict1,
      this.itemsBlock1,
      this.itmesVillage1,
      this.itemsDIstrict1,
      this.userID);


  @override
  State<UserType> createState() => _UserTypeState();

}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(250, 255, 241, 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset("assets/images/logo_img.png", width: 150),
                    Text('Login as', style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0
                    ),),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.all(20),
                child: Column(

                    children: [
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 2.0,
                          onPressed: ()
                          {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ,),);
                          },
                          padding: EdgeInsets.all(18.0),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Color.fromRGBO(93, 43, 14, 0.5), width: 2)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Individual Order',
                            style: TextStyle(
                              color: Color.fromRGBO(93, 43, 14, 1),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 2.0,
                          onPressed: ()
                          {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ,),);
                          },
                          padding: EdgeInsets.all(18.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Color.fromRGBO(93, 43, 14, 0.5), width: 2)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Society',
                            style: TextStyle(
                              color: Color.fromRGBO(93, 43, 14, 1),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 2.0,
                          onPressed: ()
                          {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ),);
                          },
                          padding: EdgeInsets.all(18.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Color.fromRGBO(93, 43, 14, 0.5), width: 2)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Business Associative',
                            style: TextStyle(
                              color: Color.fromRGBO(93, 43, 14, 1),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 2.0,
                          onPressed: ()
                          {},
                          padding: EdgeInsets.all(18.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Color.fromRGBO(93, 43, 14, 0.5), width: 2)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Brand',
                            style: TextStyle(
                              color: Color.fromRGBO(93, 43, 14, 1),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 2.0,
                          onPressed: ()
                          {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ,),);
                            },
                          padding: EdgeInsets.all(18.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.black26, width: 2)
                          ),
                          color: Colors.white70,
                          child: Text(
                            'Admin',
                            style: TextStyle(
                              color: Color.fromRGBO(93, 43, 14, 1),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      )
                    ]))
          ],
        ),
      ),
    );
  }
}
