import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expanded & Flexible Example'),
        ),
        body: const MyExpandedView(),
      ),
    );
  }
}

class MyExpandedView extends StatelessWidget {
  const MyExpandedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          //fit: FlexFit.tight,
          child: GestureDetector(
            onDoubleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Container one pressed'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
            },
            child: Container(
              color: Colors.red,
              //height: 200,
              //height: MediaQuery.of(context).size.height * .5, //700
              child: const Center(
                child: Text('Red Container'),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onDoubleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Container two pressed'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
            },
            //fit: FlexFit.tight,
            child: Container(
              color: Colors.yellow,
              //height: 500,
              //height: MediaQuery.of(context).size.height * .5,
              child: const Center(
                child: Text('Yellow Container'),
              ),
            ),
          ),
        ),
        //third container
        Expanded(
          flex: 3,
          child: GestureDetector(
            onDoubleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Container third pressed'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
            },
            //fit: FlexFit.tight,
            child: Container(
              color: Colors.blue,
              //height: 500,
              //height: MediaQuery.of(context).size.height * .5,
              child: const Center(
                child: Text('Blue Container'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
