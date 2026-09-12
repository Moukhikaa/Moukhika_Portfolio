import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:polymorphism/core/constant.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/data/profile_data.dart';
import 'package:polymorphism/shared/animations/scroll_reveal.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      height: screenHeight(context),
      width: screenWidth - horizontalPadding(context) * 2,
      key: const ValueKey('about'),
      padding: EdgeInsets.only(
        top: AppSpacing.xxxl,
        bottom: AppSpacing.xxl,
        left: isMobile ? AppSpacing.md : AppSpacing.lg,
        right: isMobile ? AppSpacing.md : AppSpacing.lg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:
                isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ScrollReveal(
        delay: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 1200),
        child: Text(
          '(About.)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: AppSpacing.xl),
      ScrollReveal(
        delay: const Duration(milliseconds: 300),
        duration: const Duration(milliseconds: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: AutoSizeText(
            ProfileData.about,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 8,
            minFontSize: 16,
          ),
        ),
      ),
    ],
  );

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    final titleWidth = isTablet ? 0.35 : 0.3;
    final contentWidth = isTablet ? 0.55 : 0.5;

    return Row(
      children: [
        ScrollReveal(
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 1200),
          child: Container(
            width:
                screenWidth(context) * titleWidth - horizontalPadding(context),
            alignment: Alignment.center,
            child: Text(
              '(About.)',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ScrollReveal(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 1200),
          child: SizedBox(
            width:
                screenWidth(context) * contentWidth -
                horizontalPadding(context),
            child: AutoSizeText(
              ProfileData.about,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
