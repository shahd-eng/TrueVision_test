import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingSection extends StatelessWidget {
  final String lastUpdated;

  const TrendingSection({super.key, this.lastUpdated = 'Updated 2h ago'});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.local_fire_department, color: Colors.red[400], size: 24),
            const SizedBox(width: 5),
            Text(
              'Trending Now',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 28 / 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          lastUpdated,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }
}
