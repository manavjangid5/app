// import "package:flutter/material.dart";
// import "../pages/ladleInfo.dart";
// import "../pages/currentStatus.dart";
//
//
// class CustomNavigationBar extends StatefulWidget {
//   final String username;
//
//   const CustomNavigationBar({Key? key, required this.username}) : super(key: key);
//   @override
//   State<CustomNavigationBar> createState() => _CustomNavigationBarState();
// }
//
// class _CustomNavigationBarState extends State<CustomNavigationBar> {
//   int _currentIndex = 0;
//
//   // List of pages to navigate to
//   final List<Widget> _pages = [
//     HomePage(Widget.username), // Replace with your actual HomePage widget
//     const CurrentStatusPage(), // Replace with your actual CurrentStatusPage widget
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex], // Display the current page
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.live_tv),
//             label: 'Overview',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Status',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index; // Update the current index
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.red,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         selectedFontSize: 16,
//         unselectedFontSize: 14,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
// }
