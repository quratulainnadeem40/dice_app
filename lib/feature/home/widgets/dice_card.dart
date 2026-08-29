import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
class DiceCard extends StatefulWidget {
  final int? result;
  final bool isRolling;
  final Color diceColor;
  final double size;

  const DiceCard({
    Key? key,
    this.result,
    required this.isRolling,
    required this.diceColor,
    this.size = 150,
  }) : super(key: key);

  @override
  State<DiceCard> createState() => _DiceCardState();
}

class _DiceCardState extends State<DiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0, end: 6.28).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    if (widget.isRolling) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(DiceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRolling && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isRolling && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_rotation.value * 0.5)
            ..rotateY(_rotation.value)
            ..rotateZ(_rotation.value * 0.3),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.diceColor,
              borderRadius: BorderRadius.circular(widget.size * 0.15),
              boxShadow: [
                BoxShadow(
                  color: widget.diceColor.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  widget.diceColor.withOpacity(1),
                  widget.diceColor.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: widget.isRolling
                ? Center(
                    child: SizedBox(
                      width: widget.size * 0.4,
                      height: widget.size * 0.4,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      '${widget.result ?? '?'}',
                      style: TextStyle(
                        fontSize: widget.size * 0.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}