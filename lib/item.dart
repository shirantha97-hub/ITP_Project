import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'display.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.cyan,
      ),
      home: MyApp1(),
    ));

class MyApp1 extends StatefulWidget {
  @override
  _State createState() => _State();
}


class _State extends State<MyApp1> {
String itemCode,itemName,quantity,unitPrice;
  getItemCode(itemCode){
      this.itemCode=itemCode;
  }
  // ignore: non_constant_identifier_names
  getItem_name(itemName){ 
      this.itemName=itemName;
  }

  getquantity(quantity){
      this.quantity=quantity;
  }

  // ignore: non_constant_identifier_names
  getunit_price(unitPrice){
      this.unitPrice=unitPrice;
  }
  createData() async {
    print("Created");

    
    // ignore: unused_local_variable
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("Items").document(itemCode);

    //create map
    Map<String, dynamic> item = {
      "ItemCode": itemCode ,
      "ItemName": itemName,
      "quantity": quantity,
      "unitPrice": unitPrice
    };
    // ignore: deprecated_member_use
    documentReference.setData(item).whenComplete(() {
      print("$itemName Created");
    });
  }

  updateData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("Items").document(itemCode);

    //create map
    Map<String, dynamic> item = {
      "ItemCode": itemCode ,
      "ItemName": itemName,
      "quantity": quantity,
      "unitPrice": unitPrice
    };
    // ignore: deprecated_member_use
    documentReference.setData(item).whenComplete(() {
      print("$itemName updated");
    });
    
  }
  deleteData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("Items").document(itemCode);
        documentReference.delete().whenComplete(() {
         print("$itemCode Delete"); 
        });
    print("Delete");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "DELICIOUS     Item Details",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body:SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Item Code",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: .0))),
                  onChanged: (String item_code) {
                    getItemCode(item_code);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Item Name",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String item_name) {
                    getItem_name(item_name);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Quantity",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String quantity) {
                    getquantity(quantity);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Unit Price",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String unit_price) {
                    getunit_price(unit_price);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('CREATE'),
                  textColor: Colors.black,
                  onPressed: () {
                    createData();
                  },
                ),
                RaisedButton(
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('UPDATE'),
                  textColor: Colors.black,
                  onPressed: () {
                    updateData();
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('DELETE'),
                  textColor: Colors.black,
                  onPressed: () {
                    deleteData();
                  },
                ),
                
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return DisplayApp();
          }));
        },
        tooltip: 'Next',
        child: Icon(Icons.navigate_next),
      ),
      
    );
  }
}


