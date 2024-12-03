import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/screens/cart_screen.dart';
import 'package:food_ordering_customerapp/screens/homepage.dart';
import 'package:food_ordering_customerapp/screens/menu_items_screen.dart';
import 'package:food_ordering_customerapp/screens/orders_screen.dart';
import 'package:food_ordering_customerapp/screens/user/user_profile_screen.dart';

class Layout extends StatefulWidget {
  final int? index;
  const Layout({super.key, this.index});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late int _pageindex;

  @override
  void initState() {
    super.initState();
    _pageindex = widget.index ?? 0;
  }

  final List<Widget> navbarPages = [
    const Homepage(),
    const MenuItemsScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageindex,
        backgroundColor: const Color.fromARGB(0, 243, 120, 120),
        buttonBackgroundColor: const Color.fromARGB(255, 255, 119, 0),
        color: const Color.fromARGB(255, 251, 148, 4),
        animationDuration: const Duration(milliseconds: 500),
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.shop,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 25,
            color: Colors.white,
          )
        ],
        onTap: (index) {
          setState(() {
            _pageindex = index;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 0, right: 0, bottom: 8),
        child: navbarPages[_pageindex],
      ),
    );
  }
}
