import 'package:flutter/material.dart';

class WrongConnection extends StatelessWidget {
  const WrongConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/wrong_connection.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 230,
            left: 30,
            child: Text(
              'Oops!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Positioned(
            bottom: 170,
            left: 30,
            child: Text(
              'You are connected to the wrong network,\nplease check your connection.',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 30,
            right: 250,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[800]!,
                ),
                child: Center(
                    child: Text(
                  "Go Back".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
