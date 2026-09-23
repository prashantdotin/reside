import 'package:flutter/material.dart';
import 'avatar.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    required this.value,
    required this.label,
    required this.members,
    required this.extraCount,
  });

  final int value;
  final String label;
  final List<dynamic> members;
  final int extraCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(width: 10),

              SizedBox(
                width: 82,
                height: 40,
                child: Stack(
                  children: [
                    if (members.isNotEmpty)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: _avatar(
                          members[0],
                        ),
                      ),

                    if (members.length > 1)
                      Positioned(
                        left: 18,
                        top: 0,
                        child: _avatar(
                          members[1],
                        ),
                      ),

                    Positioned(
                      left: 42,
                      top: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F3F4),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '+$extraCount',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(dynamic member) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Avatar(
        member: member,
        size: 40,
      ),
    );
  }
}