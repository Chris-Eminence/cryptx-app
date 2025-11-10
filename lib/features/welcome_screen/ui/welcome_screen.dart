import 'package:cryptx/constants/colors.dart';
import 'package:cryptx/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlackColor,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kVerticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Crypt",
                  style: GoogleFonts.poppins(
                    color: kPrimaryWhiteColor,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "X",
                  style: GoogleFonts.poppins(
                    fontSize: 64,
                    color: kPrimaryPurpleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Image.asset("assets/png/welcome-image.png"),
            ),
            Spacer(),

            Text(
              "Find all your Crypto \nInformation",
              style: GoogleFonts.poppins(
                fontSize: 32,
                color: kPrimaryWhiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 22),

            Text(
              "All the information you ever need about \na coin in one place",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: kPrimaryWhiteColor,
              ),
            ),
            SizedBox(height: 44),

            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),

                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryPurpleColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                      color: kPrimaryWhiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16), 
          ],
        ),
      ),
    );
  }
}
