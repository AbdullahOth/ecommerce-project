import 'package:flutter/material.dart';

class LeezCardWidget extends StatelessWidget {
  final Color cardColor;
  final String cardHolderName;
  final String lastFourDigits;

  const LeezCardWidget({
    super.key,
    required this.cardColor,
    required this.cardHolderName,
    required this.lastFourDigits,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 226,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 10,
            right: -18,
            left: -5,
            child: Image.asset(
              'assets/images/LeezCard.png', 
            fit: BoxFit.contain
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height: 210,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'leez',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0,
                        ),
                      ),
                      const Icon(Icons.wifi, color: Colors.white, size: 28),
                    ],
                  ),

                  Container(
                    width: 44,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6D6D6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade500, width: 1),
                    ),
                    child: CustomPaint(painter: _ChipLinesPainter()),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '•••• $lastFourDigits',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cardHolderName.toUpperCase(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'Pay in 4',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, 0),
      Offset(size.width * 0.65, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width * 0.35, size.height * 0.5),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}