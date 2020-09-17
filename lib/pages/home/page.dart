import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
                child: Column(
                  children: [
                    Text('123')
                  ],
                )
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Text('hello world')
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}