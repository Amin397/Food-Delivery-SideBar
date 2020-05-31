import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testdeliverysidebar/pages/home_page.dart';

void main(){
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: GoogleFonts.reemKufiTextTheme()
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}