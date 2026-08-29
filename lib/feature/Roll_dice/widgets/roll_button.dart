// import 'package:flutter/material.dart';

// class RollButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final bool isLoading;

//   const RollButton({
//     Key? key,
//     required this.onPressed,
//     this.isLoading = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF8B5CF6),
//           disabledBackgroundColor: const Color(0xFF8B5CF6).withOpacity(0.5),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           elevation: 4,
//         ),
//         child: isLoading
//             ? const CircularProgressIndicator(color: Colors.white)
//             : const Text(
//                 'ROLL DICE',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class RollButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isRolling;

  const RollButton({Key? key, required this.onTap, required this.isRolling}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF4C1D95), Color(0xFF2E1065)],
        ),
        border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6D28D9).withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: isRolling ? null : onTap,
        child: isRolling
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
            : const Text(
                'ROLL DICE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
      ),
    );
  }
}