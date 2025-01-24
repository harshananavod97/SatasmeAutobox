import 'package:flutter/material.dart';

class NonearGrage extends StatelessWidget {
  const NonearGrage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[50]!,
            Colors.purple[50]!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stacked emojis with slight offset
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(5, 5),
                child: const Text('🔍', style: TextStyle(fontSize: 40)),
              ),
              Transform.translate(
                offset: const Offset(-5, -5),
                child: const Text('📱', style: TextStyle(fontSize: 40)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'No Grage Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Your location is missing!\nPlease update your profile ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
