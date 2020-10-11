import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: duplicate_import
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: duplicate_import
// ignore: unused_import
// ignore: duplicate_import

import 'package:firestore_ref/firestore_ref.dart';

import 'display_item.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.cyan,
      ),
      home: DisplayApp(),
    ));

class DisplayApp extends StatefulWidget {
  @override
  _State createState() => _State();
}


class _State extends State<DisplayApp> {

  @override
  Widget build(BuildContext context) {
    var text = Text(
          "Supplier Report ",
          style: TextStyle(fontSize: 20.0),
        );
        // ignore: unused_local_variable
        
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: text,
        actions:<Widget> [    
         IconButton(
                icon: Icon(Icons.search),
                onPressed: (){}
                
            ),
        
        ],
      ),
      body:SingleChildScrollView(
              child: Column(
          children: <Widget>[
                          
           
            Padding(
              
              padding: const EdgeInsets.all(8.0),
              
              child: Row(
                
                children: <Widget>[

                  Expanded(child: Text("Supplier Code"),),
                   Expanded(child: Text("Supplier Name"),),
                    Expanded(child: Text("Address"),)
                ],
              ),
            ),
           // ignore: deprecated_member_use
           StreamBuilder(stream: Firestore.instance.collection
               ("suppliers").snapshots(),
               // ignore: missing_return
               builder: (context,snapshot){
                 if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder:( context,index){
                      DocumentSnapshot documentSnapshot=snapshot.data.documents[index];
                      return Row(
                          children:<Widget> [
                            Expanded(child: Text(documentSnapshot
                            ["supplierCode"].toString()),
                            ),
                            Expanded(child: Text(documentSnapshot
                            ["supplierName"].toString()),
                            ),
                            
                            Expanded(child: Text(documentSnapshot
                            ["supplierAddress"].toString()),
                            ),
                          ],
                      );
                    });
                 }else
                 {
                   return Align(
                     alignment: FractionalOffset.bottomCenter,
                     child: CircularProgressIndicator(),
                   );
                 }
               },
               )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return DisplayItemApp();
          }));
        },
        tooltip: 'Next',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}


