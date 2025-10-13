import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:shophomework/screens/homecontent.dart';

import 'package:shophomework/screens/searchscreen.dart';

class Homescreen extends StatefulWidget {
  final String username;
  Homescreen({super.key, required this.username});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _pageIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeContent(username: widget.username),

      const Searchscreen(),

      const Center(
        child: Text('Shopping Cart Screen', style: TextStyle(fontSize: 24)),
      ),

      const Center(
        child: Text('Notifications Screen', style: TextStyle(fontSize: 24)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _pageIndex == 0 ? _buildHomeAppBar() : null,

      body: _screens[_pageIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        height: 60.0,
        backgroundColor: Colors.transparent,
        color: Colors.pink,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _pageIndex == 0 ? Colors.pink : Colors.white,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: _pageIndex == 1 ? Colors.pink : Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: _pageIndex == 2 ? Colors.pink : Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: _pageIndex == 3 ? Colors.pink : Colors.white,
          ),
        ],

        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }

  AppBar _buildHomeAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      actionsPadding: const EdgeInsets.only(right: 20),
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://th.bing.com/th/id/OIP.SH-RnT4VgSzVgv8ba6nZOAHaJ4?w=138&h=183&c=7&r=0&o=7&cb=12&dpr=1.5&pid=1.7&rm=3',
          ),
        ),
      ],
    );
  }
}
