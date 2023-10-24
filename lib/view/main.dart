import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.amber[50],
    //   body: SafeArea(
    //     child: Container(
    //         width: 200,
    //         height: 200,
    //         alignment: Alignment.center,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: Colors.amberAccent,
    //           border: Border.all(
    //             color: Colors.black,
    //             width: 2,
    //           ),
    //         ),
    //         child: const Text('Hello world')
    //         //child: const Text('I am a Container'),
    //         ),
    //   ),
    // );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image'),
        ),
        body: Center(
          child: Center(
              child: SizedBox(
            height: 400,
            width: 400,
            child: CircleAvatar(
              radius: 50,

              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1677101410309-6eaf07d67271?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80'),
            )

          )
              //child: Image.asset('assets/images/cat1.jpg'),
              ),
        ),
      ),
    );
  }
}

//add multiple image by creating column
