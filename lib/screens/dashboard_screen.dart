import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_constants.dart';
import '../controllers/team_controller.dart';
import '../data/mock_data.dart';
import '../models/task.dart';
import '../widgets/app_header.dart';
import '../widgets/avatar.dart';
import '../widgets/opportunity_card.dart';
import '../widgets/section_title.dart';
import '../widgets/stat_card.dart';
import 'performance_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TeamController controller = TeamController();

  bool teamsSelected = true;

  bool profileMenuOpen = false;

  dynamic selectedMember;

  @override
  void initState() {
    super.initState();

    selectedMember = MockData.members.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            const AppHeader(),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      24,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        SizedBox(
                          height: 64,

                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              _userPill(
                                
                              ),
                            ],
                          ),
                        ),

                        _switcher(),

                        const SizedBox(height: 32),

                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.center,

                          children: [
                            const Expanded(
                              child: SectionTitle(
                                'Tasks',
                              ),
                            ),

                            _durationDropdown(),
                          ],
                        ),

                        const SizedBox(height: 12),

                        AnimatedBuilder(
                          animation: controller,

                          builder: (
                            context,
                            _,
                          ) {
                            return _taskStats();
                          },
                        ),

                        const SizedBox(height: 12),

                        _viewPerformanceButton(),

                        const SizedBox(height: 38),

                        const SectionTitle(
                          'Properties',
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                             Expanded(
                              child: StatCard(
                                value: 8,
                                label: 'All listings',
                                iconWidget: SvgPicture.asset(
                                  'assets/images/All_listings.svg',
                                  width: 20,
                                  height: 17,
                                ),
                                iconColor:const Color(0xFF567548),
                                iconBackgroundColor:const Color(0xFFF3FFEF),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: StatCard(
                                value: 5,
                                label: 'Under Onboarding',
                                iconWidget: SvgPicture.asset(
                                  'assets/images/property_onboarding.svg',
                                  width: 20.19,
                                  height: 19.18,
                                ),
                                iconColor: const Color(0xFF000000),
                                iconBackgroundColor: const Color(0xFFF0F4FF),
                              ),
                              
                            ),
                          ],
                        ),

                        const SizedBox(height: 38),

                        const SectionTitle(
                          'Opportunities',
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: OpportunityCard(
                                value: 12,
                                label: 'To rent-in',

                                members:
                                    MockData.members
                                        .take(2)
                                        .toList(),

                                extraCount: 10,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: OpportunityCard(
                                value: 4,
                                label: 'To lease-out',

                                members:
                                    MockData.members
                                        .skip(2)
                                        .take(2)
                                        .toList(),

                                extraCount: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (profileMenuOpen) ...[
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          profileMenuOpen = false;
                        });
                      },
                      child: const SizedBox.expand(),
                    ),
                  ),

                  // Actual dropdown
                  Positioned(
                    top: 50,
                    right: 16,
                    child: _profileDropdown(),
                  ),
                ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _userPill() {
  return GestureDetector(
    onTap: () {
      setState(() {
        profileMenuOpen = !profileMenuOpen;
      });
    },
    child: Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFD6DBE3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(
            member: selectedMember,
            size: 40,
          ),

          const SizedBox(width: 4),

          const Icon(
            Icons.keyboard_arrow_down,
            size: 22,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}
  Widget _profileDropdown() {
  // final screenWidth = MediaQuery.of(context).size.width;

  final double dropdownWidth =
      MediaQuery.of(context).size.width - 32.0;

  return Material(
    elevation: 8,
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(4),
    child: Container(
      width: dropdownWidth,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...MockData.members.map(
            (member) {
              final bool selected =
                  identical(selectedMember, member);

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedMember = member;
                    profileMenuOpen = false;
                  });
                },
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Row(
                      children: [
                        Avatar(
                          member: member,
                          size: 44,
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            _memberName(member),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ),

                        if (selected)
                          const Icon(
                            Icons.check,
                            size: 22,
                            color: Color(0xFF777777),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

  String _memberName(dynamic member) {
    try {
      return member.name.toString();
    } catch (_) {
      return 'Team Member';
    }
  }
  Widget _switcher() {
    return Container(
      height: 40,

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(
          color: const Color(0xFFD6DBE2),
        ),

        borderRadius:
            BorderRadius.circular(2),
      ),

      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  teamsSelected = false;
                });
              },

              child: Container(
                alignment:
                    Alignment.center,

                color: teamsSelected
                    ? Colors.white
                    : Colors.black,

                child: Text(
                  'My Tasks',

                  style: TextStyle(
                    fontSize: 16,

                    fontWeight:
                        teamsSelected
                            ? FontWeight.w400
                            : FontWeight.w500,

                    color: teamsSelected
                        ? const Color(
                            0xFF777777,
                          )
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  teamsSelected = true;
                });
              },

              child: Container(
                alignment:
                    Alignment.center,

                color: teamsSelected
                    ? Colors.black
                    : Colors.white,

                child: Text(
                  'Teams',

                  style: TextStyle(
                    fontSize: 16,

                    fontWeight:
                        FontWeight.w600,

                    color: teamsSelected
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _durationDropdown() {
  return PopupMenuButton<String>(
    onSelected: (value) {
      controller.selectDuration(value);
      setState(() {});
    },

    padding: EdgeInsets.zero,

    offset: const Offset(0, 32),

    color: Colors.white,

    elevation: 3,

    menuPadding: EdgeInsets.zero,

    constraints: const BoxConstraints(
      minWidth: 98,
      maxWidth: 98,
    ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: const BorderSide(
        color: Color(0xFF777777),
        width: 1,
      ),
    ),

    itemBuilder: (context) {
      // IMPORTANT:
      // Today ko remove mat karo.
      final options = DurationOption.all;

      return options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;

        final isLast = index == options.length - 1;

        return PopupMenuItem<String>(
          value: option,
          height: 30,
          padding: EdgeInsets.zero,

          child: Container(
            width: 98,
            height: 30,

            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),

            alignment: Alignment.centerLeft,

            decoration: BoxDecoration(
              color: Colors.white,

              border: isLast
                  ? null
                  : const Border(
                      bottom: BorderSide(
                        color: Color(0xFFB0B0B0),
                        width: 1,
                      ),
                    ),
            ),

            child: Text(
              option,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF777777),
              ),
            ),
          ),
        );
      }).toList();
    },

    child: Container(
      width: 98,
      height: 32,

      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(
          color: const Color(0xFF777777),
          width: 1,
        ),

        borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              controller.selectedDuration,

              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF555555),
              ),
            ),
          ),

          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Color(0xFF555555),
          ),
        ],
      ),
    ),
  );
}


  Widget _taskStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                value:
                    controller.countForStatus(
                  TaskStatus.open,
                ),

                label: 'Open',

                iconWidget: SvgPicture.asset(
                                  'assets/images/fit_check.svg',
                                  width: 13.33,
                                  height: 16.67,
                                ),

                iconColor:const Color(0XFFFAD155),
                iconBackgroundColor: const Color(0XFFFFF9E5),

              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StatCard(
                value:
                    controller.countForStatus(
                  TaskStatus.overdue,
                ),

                label: 'Overdue',

                iconWidget: SvgPicture.asset(
                                  'assets/images/clock.svg',
                                  width: 16.67,
                                  height: 16.67,
                                ),

                iconColor:
                    const Color(0xFFFE6161),
                iconBackgroundColor: const Color(0XFFFFEFF6),    
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,

          child: StatCard(
            value:
                controller.countForStatus(
              TaskStatus.closed,
            ),

            label: 'Closed',

            iconWidget: SvgPicture.asset(
                                  'assets/images/tick_mark.svg',
                                  width: 17.6,
                                  height: 13.4,
                                ),

            iconColor:
                const Color(0XFF84DF59),
            iconBackgroundColor: const Color(0xFFF3FFEF),    
          ),
        ),
      ],
    );
  }


  Widget _viewPerformanceButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,

      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) =>
                  PerformanceScreen(
                controller:
                    controller,
              ),
            ),
          );
        },

        style:
            OutlinedButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
          ),

          side:
              const BorderSide(
            color: Colors.black,
            width: 1,
          ),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              2,
            ),
          ),
        ),

        child: const Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

          children: [
            Text(
              'VIEW TEAM PERFORMANCE',

              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
                color: Colors.black,
              ),
            ),

            Icon(
              Icons.chevron_right,
              size: 23,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}