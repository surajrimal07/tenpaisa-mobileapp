import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _MainHomeState();
}

class _MainHomeState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Dashboard",
            style: GoogleFonts.pacifico(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue)),
      ),
    );
  }
}
