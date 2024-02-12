import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int id;

  const PhotoDetailScreen({
    required this.imageUrl,
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Detail'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(imageUrl),
                SizedBox(height: 16),
                Text('Title: $title'),
                SizedBox(height:8),
                Text('ID: $id'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
