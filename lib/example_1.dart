import 'dart:convert';

import 'package:api/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


 /* List<PostsModel> postList =[];
  Future <List<PostsModel>> getPostApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data =jsonDecode(response.body.toString());
    if(response.statusCode==200){
    for(Map i in data){
      postList.add(PostsModel.fromJson(i));
    }
    return postList;
    }else{
      return postList;
    }
  }*/
  List<Photos>  photolist= [];
  Future<List<Photos>> getPhotos() async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data =jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'],id: i['id']);
        photolist.add(photos);

      }
      return photolist;
    }
    else{
      return photolist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context,AsyncSnapshot<List<Photos>> snapshot){
      if(!snapshot.hasData){
        return Text('Loading');
      }
      else{
        return ListView.builder(
              itemCount: photolist.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  title: Text(snapshot.data![index].title.toString()),
                  subtitle: Text(snapshot.data![index].id.toString()),
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
class Photos{
  String title , url;
  int id;
Photos({required this.title,required this.url,required this.id});
}