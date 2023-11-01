import 'package:app/common/async_widget.dart';
import 'package:app/models/daily_card.dart';
import 'package:app/providers/assets_provider.dart';
import 'package:app/providers/daily_cards_provider.dart';
import 'package:app/views/home/home_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dailyCardsProvider = dailyCardsProviderFamily(_selectedDay);
    final asyncDailyCards = ref.watch(dailyCardsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildBackground(context),
            Column(children: [
              _buildHeader(context, ref, colorScheme),
              _buildCalendar(context, colorScheme),
              AsyncWidget(
                asyncValue: asyncDailyCards,
                onRetryAfterError: () => ref.refresh(dailyCardsProvider),
                buildWidget: _buildDailyCards,
              )
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: colorScheme.onPrimary,
                ),
                onPressed: () {},
              ),
            ],
          ),
          _buildLogo(context, ref),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, ColorScheme colorScheme) {
    return HomeCalendar(
      selectedDay: _selectedDay,
      setSelectedDay: (day) => setState(() => _selectedDay = day),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final diameter = screenWidth*2.66;

    return Positioned(
      top: -diameter*0.75,
      left: (screenWidth - diameter) / 2,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Container _buildLogo(BuildContext context, WidgetRef ref) {
    return Container(
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsetsDirectional.only(top: 8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 8, offset: Offset(0, 2.5))]
              ),
              child: ref.read(logoProvider),
            ),
          ],
        ));
  }

  Widget _buildDailyCards(List<DailyCardObj> dailyCards) {
    return Column(
      children: dailyCards.map(_buildDailyCard).toList(),
    );
  }

  Widget _buildDailyCard(DailyCardObj cardObj) {
    return Container();
  }
}
