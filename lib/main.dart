import 'dart:convert';
import 'package:assignment3/photoDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> photoList=[];
  Future<List<Photo>> getPhoto() async{
    final respnonse= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(respnonse.body.toString());
    if(respnonse.statusCode==200){
      for(Map<String, dynamic> i in data){
        photoList.add(Photo.fromJson(i));
      }
      return photoList;
    }
    else return photoList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('photo gallery'),
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getPhoto(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                return ListTile(
                  leading: 
                  InkWell(child: Image.network(photoList[index].thumbnailUrl.toString()),
                  onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoDetailScreen(
                            imageUrl: photoList[index].url,
                            title: photoList[index].title,
                            id: photoList[index].id,
                          ),
                        ),
                      );
                },),
                  
                  title: Text(photoList[index].title),
                );
              });
            }
            else return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}

