import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const MenuItems(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(icon, color: Colors.white, size: 40),
          SizedBox(
            width: 20,
          ),
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
        ]),
      ),
    );
  }
}
