import 'dart:convert';

import 'package:api/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {

 // List<UserModel> userList=[];
  var data;
  Future <void> getUserApi() async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode==200){
      /*for(Map i in data)
      userList.add(UserModel.fromJson(i));
      return userList;*/
      data =jsonDecode(response.body.toString());
    }
    else{

    }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course '),
      ),
      body: Column(
        children: [
        Expanded(
          child: FutureBuilder(
              future: getUserApi(),
              builder: (context,snapshot){
            /*if(snapshot.hasData){
              return CircularProgressIndicator();
            }*/
                if(snapshot.connectionState ==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
            else{
           return ListView.builder(
               itemCount: data.length,
               itemBuilder: (context,index){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                   ReusableRow(title:'Name',value: data[index]['name'].toString()),
                    ReusableRow(title:'Username',value: data[index]['username'].toString()),
                    ReusableRow(title:'Address',value: data[index]['address']['street'].toString()),
                    ReusableRow(title:'Lat',value: data[index]['address']['geo']['lat'].toString()),

                  ],
                ),
              ),
            );
           });
            }
          }),
        )
        ],
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}
