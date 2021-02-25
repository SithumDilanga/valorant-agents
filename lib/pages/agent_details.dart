import 'dart:async';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_agents/backend/backend.dart';
import 'package:valorant_agents/models/ability.dart';
import 'package:valorant_agents/models/agent.dart';
import 'package:valorant_agents/common/country_flags.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AgetDetailsScreen extends StatefulWidget {

  final Agent agent;
  final int index;

  const AgetDetailsScreen({
    Key key, 
    this.agent,
    this.index
  }) : super(key: key);

  @override
  _AgetDetailsScreenState createState() => _AgetDetailsScreenState();
}

class _AgetDetailsScreenState extends State<AgetDetailsScreen> with TickerProviderStateMixin{

  // country flags class instance
  CountryFlags countryFlags = CountryFlags();

  double opacityLevel = 1.0;
  // double opacityLevelAbilities = 1.0;
  bool showAbilitiesText = false;
  int _abilityCardNum = 0;
  String _abilityKey = 'Q';


  AnimationController _animationController;

  // fade, slide transition  controller
  AnimationController _animTextShowupController;
  AnimationController _animSecondSmallBoxController;

  // fade, slide transition offsets
  Animation<Offset> _animationOffset;
  Animation<Offset> _boxAnimationOffset;
  Animation<Offset> _smallBoxAnimationOffset;
  Animation<Offset> _secondSmallBoxAnimationOffset;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    // fade, slide transition
    _animTextShowupController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );


    _animSecondSmallBoxController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );


    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animTextShowupController,
    );

    final curveSecond = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animSecondSmallBoxController,
    );

    // offset values for agent name animation
    _animationOffset = Tween<Offset>(
      begin: const Offset(0.0, -5.0), //5, 0.0
      end: Offset.zero,
    ).animate(curve);

    // offset values for red box animation
    _boxAnimationOffset = Tween<Offset>(
      begin: const Offset(0.0, 5.0), //5, 0.0
      end: Offset.zero,
    ).animate(curve);

    // offset values for small box animation
    _smallBoxAnimationOffset = Tween<Offset>(
      begin: const Offset(-5.0, 0.0), //5, 0.0
      end: Offset.zero,
    ).animate(curve);
    
    // offset values for second small box animation
    _secondSmallBoxAnimationOffset = Tween<Offset>(
      begin: const Offset(20.0, 0.0), //5, 0.0
      end: Offset.zero
    ).animate(curveSecond);
    
    _animTextShowupController.forward();
    // _animSecondSmallBoxController.forward();

  // Timer(Duration(seconds: 2), () {
  //   _animTextShowupController.forward();

  //   Timer(Duration(seconds: 3), () {
  //   _animTextShowupController.reverse();
  //   });

  // });

  }

  @override
  void dispose() {
    _animationController.dispose();
    _animTextShowupController.dispose();
    _animSecondSmallBoxController.dispose();
    super.dispose();
  }

  void _changeOpacity() {
    setState(() {
      opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
    });
  }

  // void _changeOpacityAbilities() {
  //   setState(() {
  //     opacityLevelAbilities = opacityLevelAbilities == 0 ? 1.0 : 0.0;
  //     showAbilitiesText = !showAbilitiesText;
  //   });
  // }

  @override
  Widget build(BuildContext context) {   

    // if(_animTextShowupController.isAnimating) {
    //   print('completed');
    //   Future.delayed(Duration(seconds: 5), () {
    //   _animTextShowupController.reverse();
    //   });
    // }

    // if(_animTextShowupController.isAnimating) {
      
    //   Future.delayed(Duration(seconds: 2), () {
    //   _animSecondSmallBoxController.forward();

    //   if(_animSecondSmallBoxController.isAnimating){

    //     Future.delayed(Duration(seconds: 7), () {
    //       _animSecondSmallBoxController.reverse();
    //     });
    //   }

    //   });
      
    // }

    _animTextShowupController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 4), () {
        _animTextShowupController.reverse();
        });

        Future.delayed(Duration(seconds: 1), () {
          _animSecondSmallBoxController.forward();
        });

      } else if(status == AnimationStatus.dismissed) {

        Future.delayed(Duration(seconds: 4), () {
        _animTextShowupController.forward();
        });

        Future.delayed(Duration(seconds: 1), () {
          _animSecondSmallBoxController.reverse();
        });

      }
    });

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('${widget.agent.displayName}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded), 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        backgroundColor: Colors.blueGrey[900]//Colors.blueGrey,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size biggest = constraints.biggest;

          return Stack(
          children: [
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromLTRB(0, 0, 0, 0),
                end: RelativeRect.fromLTRB(0, 90, 0, 40)
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.linear
              )),
              child: AnimatedOpacity(
                opacity: opacityLevel, 
                duration: Duration(seconds: 3),
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 5,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 12,
                      height: 290,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            // ------- Agent name slide,fade animation text -------
            Positioned(
              top: 200,
              left: 240,
              child: FadeTransition(
                opacity: _animTextShowupController,
                child: SlideTransition(
                  position: _animationOffset,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        '${widget.agent.displayName}',
                        style: GoogleFonts.francoisOne( 
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ------- End Agent name slide,fade animation text -------

            // ------- big red box animation --------
            Positioned(
              top: 200,
              left: 50,
              child: FadeTransition(
                opacity: _animTextShowupController,
                child: SlideTransition(
                  position: _boxAnimationOffset,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.red,
                    )
                  ),
                ),
              ),
            ),
            // ------- End big red box animation --------

            // ------- small red box animation --------
            Positioned(
              top: 30,
              left: 80,
              child: FadeTransition(
                opacity: _animTextShowupController,
                child: SlideTransition(
                  position: _smallBoxAnimationOffset,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: 10,
                      width: 10,
                      color: Colors.red,
                    )
                  ),
                ),
              ),
            ),
            // ------- End small red box animation --------

            // ------- small second red box animation --------
            Positioned(
              top: 60,
              left: 30,
              child: FadeTransition(
                opacity: _animSecondSmallBoxController,
                child: SlideTransition(
                  position: _secondSmallBoxAnimationOffset ,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: 10,
                      width: 10,
                      color: Colors.red,
                    )
                  ),
                ),
              ),
            ),
            // ------- End small second red box animation --------

            ListView(
              children: <Widget> [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 8
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                    )
                  ),
                  child: InkWell(
                    child: Hero(
                      tag: 'hero-${widget.agent.uuid}-image',
                      child: 
                      CachedNetworkImage(
                        imageUrl: widget.agent.fullPortrait,
                        placeholder: (context, url) {
                          return Padding(
                            padding: const EdgeInsets.all(42.0),
                            child: CupertinoActivityIndicator(),
                          );
                        } 
                      ),
                      // Image.network(         // main image
                      //   widget.agent.fullPortrait,
                      // ),
                    ),
                    onTap: _changeOpacity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.agent.displayName}',
                      style: GoogleFonts.francoisOne( //righteous
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    '${widget.agent.description}',
                    style: GoogleFonts.robotoSlab( //robotoMono, notoSans
                      fontSize: 14.0,
                      color: Colors.white
                    ),
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0),
                  child: Card(
                    color: Colors.blueGrey,
                    child: ListTile(
                      // dense: true,
                      contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      leading: Image.network(
                        widget.agent.role.displayIcon,
                        height: double.infinity,
                      ),
                      title: Text(
                        '${widget.agent.role.displayName}',
                        style: GoogleFonts.marmelad(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      subtitle: Text(
                        '${widget.agent.role.description}',
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // ------- Nationality --------
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Nationality : ',
                        style: GoogleFonts.francoisOne(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(width: 8.0,),
                      Flag(
                        //countryFlagCodes[widget.index], //se
                        countryFlags.countryFlagCodes[widget.index],  
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        // countryFlags[countryFlagCodes[widget.index]] ,
                        countryFlags.countryFlags[countryFlags.countryFlagCodes[widget.index]],
                        style: GoogleFonts.robotoSlab( 
                          fontSize: 14.0,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                // ------- End Nationality --------
                SizedBox(height: 8.0),
                // ------- character tags --------
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Character Tags : ',
                        style: GoogleFonts.francoisOne(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      if(widget.agent.characterTags != null)
                        for(var tag in widget.agent.characterTags)
                          Flexible(
                            child: Text(
                              '$tag, ',
                              style: GoogleFonts.robotoSlab( 
                                fontSize: 14.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                      if(widget.agent.characterTags == null)
                        Text(
                          '---',
                          style: GoogleFonts.robotoSlab( 
                            fontSize: 14.0,
                            color: Colors.white
                          ),
                        ),
                      // Text(
                      //   widget.agent.characterTags == null ? '---' :
                      //   '${widget.agent.characterTags[0]}, ${widget.agent.characterTags[1]}',
                      //   style: GoogleFonts.robotoSlab( 
                      //     fontSize: 14.0,
                      //     color: Colors.white
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // ------- End character tags --------
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                    'Abilities',
                    style: GoogleFonts.francoisOne(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                // ----- ability buttons ------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AbilityButton(
                      displayIcon: widget.agent.abilities[0].displayIcon,
                      color: _abilityCardNum == 0 ? Colors.red : null,
                      onTap: () {
                        setState(() {
                          _abilityCardNum = 0;
                          _abilityKey = 'Q';
                        });
                      },                      
                    ),
                    AbilityButton(
                      displayIcon: widget.agent.abilities[1].displayIcon,
                      color: _abilityCardNum == 1 ? Colors.red : null,
                      onTap: () {
                        setState(() {
                          _abilityCardNum = 1;
                          _abilityKey = 'E';
                        });
                      },
                    ),
                    AbilityButton(
                      displayIcon: widget.agent.abilities[2].displayIcon,
                      color: _abilityCardNum == 2 ? Colors.red : null,
                      onTap: () {
                        setState(() {
                          _abilityCardNum = 2;
                          _abilityKey = 'C';
                        });
                      },
                    ),
                    AbilityButton(
                      displayIcon: widget.agent.abilities[3].displayIcon,
                      color: _abilityCardNum == 3 ? Colors.red : null,
                      onTap: () {
                        setState(() {
                          _abilityCardNum = 3;
                          _abilityKey = 'X';
                        });
                      },
                    ),
                  ],
                ),
                // ----- End ability buttons ------

                // ----- ability details card -------
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 16.0, right: 16.0),
                  child: AbilityCard(ability: widget.agent.abilities[_abilityCardNum], abilityKey: _abilityKey,),
                )
              ]
            ),
          ],
        );
        },  
      ),
    );
  }
}

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

class AbilityButton extends StatelessWidget {

  final String displayIcon;
  final VoidCallback onTap;
  final Color color;

  const AbilityButton({
    Key key, 
    this.displayIcon,
    this.color, 
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4)
        ),
        // color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              displayIcon,
              width: 30,
              height: 30,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}