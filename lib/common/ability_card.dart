import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_agents/models/ability.dart';


class AbilityCard extends StatefulWidget {

  final Ability ability;
  final String abilityKey;
  final Widget child;
  final int delay; 

  const AbilityCard({
    Key key, 
    this.ability,
    this.abilityKey,
    this.child,
    this.delay,
  }) : super(key: key);

  @override
  _AbilityCardState createState() => _AbilityCardState();
}

class _AbilityCardState extends State<AbilityCard> with TickerProviderStateMixin{

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

    if(widget.delay == null) {
      _animTextShowupController.forward();
    } else{
      Timer(Duration(milliseconds: widget.delay), () {
        _animTextShowupController.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant AbilityCard oldWidget) {
    _animTextShowupController.reset();
    _animTextShowupController.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _animTextShowupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animTextShowupController,
      child: SlideTransition(
        position: _animationOffset,
        child: Card(
          color: Colors.blueGrey,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            leading: Image.network(
              widget.ability.displayIcon
            ),
            title: Text(
              '${widget.abilityKey} - ${widget.ability.displayName}',
              style: GoogleFonts.marmelad(
                color: Colors.white60,
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text(
              '${widget.ability.description}',
              style: GoogleFonts.robotoSlab(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}