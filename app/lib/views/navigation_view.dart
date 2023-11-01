import 'package:app/views/create/creation_list.dart';
import 'package:app/views/home/home_page.dart';
import 'package:app/views/journal/journal_page.dart';
import 'package:app/views/tracking/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({super.key});

  @override
  ConsumerState<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerState<NavigationView> with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  int _currentButtonIndex = 0;
  bool _isOptionsVisible = false;
  final int _createButtonIndex = 2;

  final List<Widget> _pages = [
    const HomePage(),
    const TrackingPage(),
    const JournalPage(),
  ];

  late AnimationController _animationController;
  late Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentPageIndex,
            children: _pages,
          ),

          AnimatedBuilder(
            animation: _animationOffset,
            builder: (context, child) => Visibility(
              visible: _animationOffset.value.dy != 1,
              child: GestureDetector(
                onTap: () => _hideOptions(),
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  alignment: Alignment.bottomCenter,
                  child: child,
                ),
              ),
            ),
            child: SlideTransition(
              position: _animationOffset,
              child: CreationList(_hideOptions, _setCurrentPage),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        unselectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        currentIndex: _currentButtonIndex,
        onTap: (index) => _onNavigationButtonPress(index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                _setCurrentIndex(_createButtonIndex);
                _toggleOptionVisibility();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Journal',
          ),
        ],
      ),
    );
  }

  void _onNavigationButtonPress(int index) {
    _setCurrentIndex(index);

    if (index == _createButtonIndex) {
      _toggleOptionVisibility();
    } else {
      _hideOptions();
    }
  }

  void _setCurrentPage(Type pageType) {
    final idx = _pages.indexWhere((element) => element.runtimeType == pageType);
    _setCurrentIndex(idx);
  }

  void _setCurrentIndex(int buttonIndex) {
    if (buttonIndex != _createButtonIndex) {
      final index = buttonIndex < _createButtonIndex ? buttonIndex : buttonIndex - 1;
      setState(() {
        _currentPageIndex = index;
        _currentButtonIndex = buttonIndex;
      });
    } else {
      setState(() {
        _currentButtonIndex = buttonIndex;
      });
    }
  }

  void _toggleOptionVisibility() {
    setState(() {
      _isOptionsVisible = !_isOptionsVisible;
    });
    _animateOptions();
  }

  void _hideOptions() {
    setState(() {
      _isOptionsVisible = false;
    });
    _animateOptions();
  }

  void _animateOptions() {
    if (_isOptionsVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}