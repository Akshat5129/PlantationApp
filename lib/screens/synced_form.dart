import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'homescreen.dart';

class SyncedForm extends StatefulWidget {

  String valueBlock1, valueVillage1, valueDistrict1, userID;
  var  itemsBlock1, itmesVillage1, itemsDIstrict1;

  SyncedForm(
      this.valueBlock1,
      this.valueVillage1,
      this.valueDistrict1,
      this.itemsBlock1,
      this.itmesVillage1,
      this.itemsDIstrict1,
      this.userID);

  @override
  State<SyncedForm> createState() => _SyncedFormState();
}

class _SyncedFormState extends State<SyncedForm> {



  Box? boxSynced;
  Box? box3;


  @override
  void initState() {
    createBox();
  }

  createBox() async {
    boxSynced = await Hive.openBox("boxsynced");
    box3 = await Hive.openBox("farmer_demand");
    if(boxSynced!=null){
      print("1234567NotEmpty");
      print(boxSynced?.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 254, 236, 1),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Recently \nSynced Form",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(120, 153, 50, 1),
                                letterSpacing: .2,
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 40,
                          icon: Icon(Icons.home),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserType(
                                widget.valueBlock1, widget.valueVillage1, widget.valueDistrict1, widget.itemsBlock1, widget.itmesVillage1, widget.valueDistrict1, widget.userID
                            ),),);
                          },
                        ),
                      ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),

                    Container(
                      child: boxSynced==null ?
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text(
                          "No Data have been Synced",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(120, 153, 50, 1),
                                letterSpacing: .2,
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ) : Container(
                        margin: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [ListView.builder(
                              shrinkWrap: true,
                            itemCount: boxSynced?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  leading: const Icon(Icons.list),
                                  trailing: Text(
                                    index.toString(),
                                    style: TextStyle(color: Colors.green, fontSize: 15),
                                  ),
                                  title: Text("List item $index"));
                            })],
                          )
                      )

                      ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
