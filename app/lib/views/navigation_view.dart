import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/journal/chat_journal_wizard.dart';
import 'package:app/views/journal/journal_page.dart';
import 'package:app/views/tracking/create_challenge_dialog.dart';
import 'package:app/views/tracking/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({super.key});

  @override
  ConsumerState<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerState<NavigationView> {
  int _currentPageIndex = 0;
  bool _isOptionsVisible = false;

  final List<Widget> _pages = [
    const TrackingPage(),
    const JournalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentPageIndex,
            children: _pages,
          ),

          if (_isOptionsVisible)
            _buildCreateOptions(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) => _setCurrentPageIndex(index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: _toggleOptionVisibility,
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

  Widget _buildCreateOptions() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOptionsVisible = false;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _onCreateChallenge,
                child: Text('Challenge'),
              ),
              ElevatedButton(
                onPressed: () => _onCreateChatJournalEntry(context),
                child: Text('Chat Journal Entry'),
              ),
              // Add more options as needed
            ],
          ),
        ),
      ),
    );
  }

  void _onCreateChallenge() {
    _hideOptions();
    _setCurrentPageIndex(0);

    showDialog(
      context: context,
      builder: (BuildContext context) => const CreateChallengeDialog(),
    );
  }
  
  void _onCreateChatJournalEntry(BuildContext context) {
    _hideOptions();
    _setCurrentPageIndex(1);

    _onAddJournalEntry(context);
  }

  void _onAddJournalEntry(
    BuildContext context,
  ) async {
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);
    selectedJournalEntryController.state = const AsyncLoading();

    _pushChatJournalWizardRoute(context);

    try {
      final journalController = ref.read(journalControllerProvider.notifier);

      final newJournalEntryObj = await journalController.addJournalEntry(
        JournalEntryObj.chat(
          name: 'New Journal Entry',
          date: DateTime.now(),
        ),
      );

      selectedJournalEntryController.state = AsyncData(newJournalEntryObj);
    } catch (err, st) {
      selectedJournalEntryController.state = AsyncError(err, st);
    }
  }

  void _pushChatJournalWizardRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatJournalWizard(),
      ),
    );
  }

  void _setCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _toggleOptionVisibility() {
    setState(() {
      _isOptionsVisible = !_isOptionsVisible;
    });
  }

  void _hideOptions() {
    setState(() {
      _isOptionsVisible = false;
    });
  }
}