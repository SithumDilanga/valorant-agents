import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> with TickerProviderStateMixin{

  AnimationController _animTextShowupController;
  Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();

    _animTextShowupController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animTextShowupController,
    );

    _animationOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.35),
      end: Offset.zero,
    ).animate(curve);

    _animTextShowupController.forward();

  }

  @override
  void dispose() {
    super.dispose();
    _animTextShowupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded), 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        backgroundColor: Colors.blueGrey[900]//Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: FadeTransition(
            opacity: _animTextShowupController,
            child: SlideTransition(
              position: _animationOffset,
              child: Card(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Valorant Agents is a fan made app and isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing Riot Games properties. Riot Games, Valorant and all associated properties are trademarks or registered trademarks of Riot Games, Inc.",
                    style: GoogleFonts.robotoSlab( //robotoMono, notoSans
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}