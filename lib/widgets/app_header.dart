import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.onMenuTap,
  });

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,

      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(
            width: 90,
            height: 40,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/reside_logo.png',
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
            GestureDetector(
              onTap: onMenuTap,

              child: SizedBox(
                width: 40,
                height: 40,

                child: Stack(
                  clipBehavior: Clip.none,

                  children: [

                    // Hamburger lines
                    Center(
                      child: SizedBox(
                        width: 24,
                        height: 18,

                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            Align(
                              alignment:
                                  Alignment.centerRight,

                              child: Container(
                                width: 24,
                                height: 2,
                                color:
                                    const Color(0xFF555555),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Align(
                              alignment:
                                  Alignment.centerRight,

                              child: Container(
                                width: 18,
                                height: 2,
                                color:
                                    const Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Red notification dot
                    Positioned(
                      top: 7,
                      right: 4,

                      child: Container(
                        width: 6,
                        height: 6,

                        decoration:
                            const BoxDecoration(
                          color: AppColors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}