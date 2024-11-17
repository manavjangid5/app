import 'package:flutter/material.dart';
import 'package:project1/components/appBar.dart';
import 'package:project1/components/customNavigationBar.dart';
import './currentStatus.dart';
import './ladleInfo.dart';


class Home extends StatefulWidget {
  final String username;

  const Home({Key? key, required this.username}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      CurrentStatusPage(username: widget.username),
      LadleInfo(username: widget.username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(username: widget.username)),

      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Current Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
