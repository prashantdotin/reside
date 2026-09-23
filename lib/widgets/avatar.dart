import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.member,
    this.size = 40,
  });

  final dynamic member;
  final double size;

  @override
  Widget build(BuildContext context) {
    final String imagePath = member.imagePath.toString();
    final String initials = member.initials.toString();
    final int colorValue = member.colorValue as int;

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
  imagePath,
  width: size,
  height: size,
  fit: BoxFit.cover,
  alignment: Alignment.topCenter,
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: size,
      height: size,
      color: Color(colorValue),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.32,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  },
)
      ),
    );
  }
}