import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/pages/settings_page.dart';
import 'package:redacted_card_game/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isUltraWide = size.aspectRatio > 2.1;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine if we should show animation based on screen size
            final showAnimation = !isUltraWide && constraints.maxHeight > 400;

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getHorizontalPadding(size.width),
                    vertical: 24.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isLandscape ? 600 : 500,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Animation or spacer
                        if (showAnimation) ...[
                          _buildLottieAnimation(constraints),
                          SizedBox(height: _getSpacing(size.height, 3)),
                        ] else
                          SizedBox(height: _getSpacing(size.height, 2)),

                        // Title
                        _buildTitle(context, size),
                        SizedBox(height: _getSpacing(size.height, 4)),

                        // Buttons
                        _buildButtons(context, size),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Returns appropriate horizontal padding based on screen width
  double _getHorizontalPadding(double width) {
    if (width < 360) return 16.0;
    if (width < 600) return 24.0;
    if (width < 1200) return 40.0;
    return 60.0;
  }

  /// Returns spacing based on screen height and multiplier
  double _getSpacing(double height, int multiplier) {
    final baseSpacing = height < 600 ? 8.0 : 12.0;
    return baseSpacing * multiplier;
  }

  /// Builds the Lottie animation with responsive sizing
  Widget _buildLottieAnimation(BoxConstraints constraints) {
    double animationSize;

    if (constraints.maxWidth < 360) {
      animationSize = constraints.maxWidth * 0.6;
    } else if (constraints.maxWidth < 600) {
      animationSize = constraints.maxWidth * 0.5;
    } else {
      animationSize = 300;
    }

    // Limit by height as well
    if (constraints.maxHeight < 700) {
      animationSize = animationSize.clamp(0, constraints.maxHeight * 0.35);
    }

    return SizedBox(
      width: animationSize,
      height: animationSize,
      child: Lottie.asset(
        'assets/lotties/ace_of_spade.json',
        fit: BoxFit.contain,
      ),
    );
  }

  /// Builds the title with responsive text sizing
  Widget _buildTitle(BuildContext context, Size size) {
    // Calculate responsive font size
    double fontSize = 70.0;
    double letterSpacing = 15.0;

    if (size.width < 360) {
      fontSize = 40.0;
      letterSpacing = 8.0;
    } else if (size.width < 600) {
      fontSize = 50.0;
      letterSpacing = 10.0;
    }

    return Hero(
      tag: 'title',
      child: Material(
        color: Colors.transparent,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'REDACTED',
            style: KTextStyle.welcomeTitleText.copyWith(
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// Builds the action buttons with responsive sizing
  Widget _buildButtons(BuildContext context, Size size) {
    // Calculate button dimensions
    double buttonWidth = size.width < 360 ? size.width * 0.8 : 280.0;
    double buttonHeight = size.width < 360 ? 60.0 : 70.0;
    double playFontSize = size.width < 360 ? 24.0 : 30.0;
    double settingsFontSize = size.width < 360 ? 18.0 : 22.0;

    return Column(
      children: [
        // Play Button
        SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WidgetTree()),
              );
            },
            child: Text(
              'Play',
              style: TextStyle(
                fontSize: playFontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        SizedBox(height: _getSpacing(size.height, 2)),

        // Settings Button
        SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: settingsFontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
