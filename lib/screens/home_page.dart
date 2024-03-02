import 'package:flutter/material.dart';
import '../widgets/home_card.dart';
import 'doctors_list_page.dart';
import 'appointment_booking_page.dart';
import 'specialization_list_page.dart';
 class HomePage extends StatelessWidget {
   const HomePage({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("H O M E"),

       ),
       body: Column(
         children: [
           HomeCard(
             title: 'Doctor',
             imagePath: 'assets/images/doctor_1.png',
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => DoctorsListPage()),
               );
             },
           ),
           // Inside HomePage widget
           HomeCard(
             title: 'Appointment',
             imagePath: 'assets/images/healthcareLogo.png',
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => SpecializationListPage()),
               );
             },
           ),
         ],
       ),
     );
   }
 }
