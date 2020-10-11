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
import 'package:new_itp/main.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.cyan,
      ),
      home: DisplayItemApp(),
    ));

class DisplayItemApp extends StatefulWidget {
  @override
  _State createState() => _State();
}


class _State extends State<DisplayItemApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        
        title: Text(
          "Canteen Iten Report ",
          style: TextStyle(fontSize: 20.0),
          
          
        ),
        
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

                  Expanded(child: Text("Item Code"),),
                   Expanded(child: Text(" Name"),),
                    Expanded(child: Text("Quantity"),),
                     Expanded(child: Text("Unit price"),),
                ],
              ),
            ),
           // ignore: deprecated_member_use
           StreamBuilder(stream: Firestore.instance.collection
               ("Items").snapshots(),
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
                            ["ItemCode"].toString()),
                            ),
                            Expanded(child: Text(documentSnapshot
                            ["ItemName"].toString()),
                            ),
                            
                            Expanded(child: Text(documentSnapshot
                            ["quantity"].toString()),
                            ),
                            Expanded(child: Text(documentSnapshot
                            ["unitPrice"].toString()),
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
            return MyApp();
          }));
        },
        tooltip: 'Home',
        child: Icon(Icons.home),
      ),
      
    );
  }
}
