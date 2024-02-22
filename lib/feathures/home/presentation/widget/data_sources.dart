import 'package:flutter/material.dart';

class DataSourcesView extends StatelessWidget {
  const DataSourcesView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Data Sources'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This app is developed as an educational project for a university assingment. The data for this app is scraped from different stock market-related websites like:',
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            '- NpeseAlpha',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          ),
          Text(
            '- ShareSansar',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          ),
          Text(
            '- MeroLagani',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          Text(
            'Additional data is obtained from various other sources related to stock markets and financial analysis.',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Acknowledged'),
        ),
      ],
    );
  }
}
