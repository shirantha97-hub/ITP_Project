import 'package:flutter/material.dart';
import 'package:new_itp/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';

//void main() async{
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(MyApp());
//}
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
          
          
          // ignore: unused_label
          theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.red,
          
          );
        
   runApp(MaterialApp(
     debugShowCheckedModeBanner: false,
     home:MyApp()
   ));
    
}


class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {

  var _form_key=GlobalObjectKey<FormState>(Form);
  var current_form;
  // ignore: non_constant_identifier_names
  String supCode, supName, suptelNo, supAddress;
  getSupplierCode(supCode) {
    this.supCode = supCode;
  }

  getSupplierName(supName) {
    this.supName = supName;
  }

  getSupplierTelNo(supTelNo) {
    this.suptelNo = suptelNo;
  }

  getSupplierAddress(supAddress) {
    this.supAddress = supAddress;
  }

  createData() async {
    print("Created");

    
    // ignore: unused_local_variable
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("suppliers").document(supCode);

    //create map
    Map<String, dynamic> sup = {
      "supplierCode": supCode,
      "supplierName": supName,
      "supplierTelNo": suptelNo,
      "supplierAddress": supAddress
    };
    // ignore: deprecated_member_use
    documentReference.setData(sup).whenComplete(() {
      print("$supName Created");
    });
  }

  updateData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("suppliers").document(supCode);

    //create map
    Map<String, dynamic> sup = {
      "supplierCode": supCode,
      "supplierName": supName,
      "supplierTelNo": suptelNo,
      "supplierAddress": supAddress
    };
    // ignore: deprecated_member_use
    documentReference.setData(sup).whenComplete(() {
      print("$supName updated");
    });
    
  }

  deleteData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("suppliers").document(supCode);
        documentReference.delete().whenComplete(() {
         print("$supName Delete"); 
        });
    print("Delete");
  }
  readData(){
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("suppliers").document(supCode);

        documentReference.get().then((datasnapshot) {
            print(datasnapshot.data()["supplierCode"]);
            print(datasnapshot.data()["supplierName"]);
            print(datasnapshot.data()["supplierTelNo"]);
            print(datasnapshot.data()["supplierAddress"]);

        });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "DELICIOUS     Supplier Details",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body:Form(
        key: _form_key,
              child: SingleChildScrollView(
                child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Supplier Code",
                        icon: const Icon(Icons.account_box,color: Colors.red),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: .0))),
                          // ignore: missing_return
                          validator: (String value){
                              if(value.isEmpty){
                                return "Please enter Supplier Code";
                              }
                              else{
                                return null;
                              }
                              
                          },
                    onChanged: (String supplierCode) {
                      getSupplierCode(supplierCode);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Supplier Name",
                        icon: const Icon(Icons.edit,color: Colors.red),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                                validator: (String value){
                              if(value.isEmpty){
                                return "Please enter Supplier Name";
                              }
                              else{
                                return null;
                              }},

                    onChanged: (String supplierName) {
                      getSupplierName(supplierName);
                      
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Supplier Telephone Number",
                        icon: const Icon(Icons.edit,color: Colors.red),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                                 validator: (String value){
                              if(value.isEmpty){
                                return "Please enter valid telephone number";
                              }
                              else{
                                return null;
                              }},

                    onChanged: (String supplierTelNo) {
                      getSupplierTelNo(supplierTelNo);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Supplier Address",
                        icon: const Icon(Icons.edit,color: Colors.red),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                                 validator: (String value){
                              if(value.isEmpty){
                                return "Please enter your address";
                              }
                              else{
                                return null;
                              }},

                    onChanged: (String supplierAddress) {
                      getSupplierAddress(supplierAddress);
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
                      setState(() {
                        if(_form_key.currentState.validate()){
                          this._form_key=current_form();
                        }
                      });
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
              ),
                Column(
                  children: [
                    RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text('READ'),
                    textColor: Colors.black,
                    onPressed: () {
                      readData();
                    },
                  ),
                  ],
                )  
                  
            ],
          
          ),
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return MyApp1();
          }));
        },
        tooltip: 'Next',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}


