import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

class RollButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final IconData icon;

  const RollButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    this.label = 'ROLL',
    this.icon = Icons.casino_rounded,
  }) : super(key: key);

  @override
  State<RollButton> createState() => _RollButtonState();
}

class _RollButtonState extends State<RollButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(RollButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.reset();
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
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isLoading ? (1.0 + (_controller.value * 0.1)) : 1.0,
          child: GestureDetector(
            onTap: widget.isLoading ? null : widget.onPressed,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryPurple,
                    AppColors.primaryPurpleLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: widget.isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.textPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Rolling...',
                              style: AppTextStyles.buttonText,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              widget.icon,
                              color: AppColors.textPrimary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.label,
                              style: AppTextStyles.buttonText,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}