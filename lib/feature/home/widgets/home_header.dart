// 
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext me) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Good to see you 👋', style: TextStyle(color: Colors.white70, fontSize: 14)),
            SizedBox(height: 4),
            Text('Ready to roll?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://placeholder.com/user.jpg'),
        ),
      ],
    );
  }
}