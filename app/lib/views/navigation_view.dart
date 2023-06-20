import 'package:app/common/async_widget.dart';
import 'package:app/common/chat_widget.dart';
import 'package:app/common/loading_widget.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/views/journal/journal_page.dart';
import 'package:app/views/tracking/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    TrackingPage(),
    JournalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Journal',
          ),
          // Add more bottom navigation bar items here
        ],
      ),
    );
  }
}