import 'dart:async';

import 'package:flutter_client/models/user.dart';
import 'package:flutter_client/utils/style.dart';
import 'package:flutter_client/widgets/round_image.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class MyRoomProfile extends StatefulWidget {
  final User user;
  final double size;
  final bool isMute;
  final bool isModerator;
  final bool isSpeaking;
  final Function showEmailAddress;

  const MyRoomProfile({
    Key? key,
    required this.user,
    required this.size,
    this.isMute = false,
    this.isModerator = false,
    this.isSpeaking = false,
    required this.showEmailAddress,
  }) : super(key: key);

  @override
  State<MyRoomProfile> createState() => _MyRoomProfileState();
}

class _MyRoomProfileState extends State<MyRoomProfile> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      // padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Stack(
            children: [
              Ripples(
                size: 50,
                waveOn: widget.isSpeaking,
                color: Colors.blue,
                child: GestureDetector(
                  onDoubleTap: () async {
                    await widget.showEmailAddress();
                  },
                  child: RoundImage(
                    path: widget.user.profileImage,
                    width: widget.size,
                    height: widget.size,
                  ),
                ),
              ),
              // buildNewBadge(user.isNewUser),
              buildMuteBadge(widget.isMute),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildModeratorBadge(widget.isModerator),
              GestureDetector(
                onTap: () async {
                  await widget.showEmailAddress();
                },
                child: Text(
                  widget.user.name.split(' ')[0],
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildModeratorBadge(bool isModerator) {
    return isModerator
        ? Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: Style.AccentGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.star,
              color: Colors.white,
              size: 12,
            ),
          )
        : Container();
  }

  Widget buildMuteBadge(bool isMute) {
    return Positioned(
      right: 10,
      bottom: 10,
      child: isMute
          ? Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: const Icon(Icons.mic_off),
            )
          : Container(),
    );
  }

  Widget buildNewBadge(bool isNewUser) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: isNewUser
          ? Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: const Text(
                '🎉',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          : Container(),
    );
  }
}

class Ripples extends StatefulWidget {
  const Ripples({
    Key? key,
    this.size = 80.0,
    this.color = Colors.pink,
    required this.waveOn,
    required this.child,
  }) : super(key: key);

  final double size;
  final Color color;
  final Widget child;
  final bool waveOn;

  @override
  _RipplesState createState() => _RipplesState();
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);

  final Color color;
  final Animation<double> _animation;

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);

    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);

    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => true;
}

class _RipplesState extends State<Ripples> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget _button() {
    return Center(
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.waveOn == false) {
      return _button();
    }

    return CustomPaint(
      painter: _CirclePainter(
        _controller,
        color: widget.color,
      ),
      child: _button(),
    );
  }
}
