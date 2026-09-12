import 'package:flutter/material.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/shared/animations/scroll_reveal.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  static const List<_EducationItem> _items = [
    _EducationItem(
      period: '2023 - 2027',
      title: 'B.Tech in Computer Science and Engineering',
      institution: "Vignan's Institute of Information Technology",
      result: 'CGPA 8.46',
      location: 'Visakhapatnam, India',
      icon: Icons.school_outlined,
    ),
    _EducationItem(
      period: '2021 - 2023',
      title: 'Intermediate',
      institution: 'Sri Chaitanya Junior College',
      result: '81.6%',
      location: 'Andhra Pradesh, India',
      icon: Icons.menu_book_outlined,
    ),
    _EducationItem(
      period: '2020 - 2021',
      title: 'Class 10 - ICSE',
      institution: 'De Paul School',
      result: '80.5%',
      location: 'Visakhapatnam, India',
      icon: Icons.workspace_premium_outlined,
    ),
  ];

  static const List<String> _coursework = [
    'Data Structures & Algorithms',
    'Object-Oriented Programming',
    'Database Management Systems',
    'Operating Systems',
    'Computer Networks',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 720;

    return Container(
      width: double.infinity,
      color: AppColors.bgDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xxxl,
        vertical: isMobile ? AppSpacing.xxl : AppSpacing.xxxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollReveal(child: _buildHeader(context, isMobile)),
              SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final spacing = isMobile ? AppSpacing.md : AppSpacing.lg;
                  final cardWidth =
                      isMobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth - spacing * 2) / 3;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (var index = 0; index < _items.length; index++)
                        ScrollReveal(
                          delay: Duration(milliseconds: 150 + index * 100),
                          child: SizedBox(
                            width: cardWidth,
                            height: isMobile ? 300 : 320,
                            child: _EducationCard(item: _items[index]),
                          ),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),
              const ScrollReveal(child: _CourseworkBlock(courses: _coursework)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '(Education.)',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Academic Foundation',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: isMobile ? 34 : 48,
          height: 1,
          letterSpacing: 0,
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Text(
          'A steady Computer Science path built through engineering fundamentals, programming practice, and consistent academic performance.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary.withValues(alpha: 0.78),
            height: 1.55,
          ),
        ),
      ),
    ],
  );
}

class _CourseworkBlock extends StatelessWidget {
  const _CourseworkBlock({required this.courses});

  final List<String> courses;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Relevant Coursework',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [for (final course in courses) _EducationChip(text: course)],
      ),
    ],
  );
}

class _EducationCard extends StatefulWidget {
  const _EducationCard({required this.item});

  final _EducationItem item;

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _isHovered = true),
    onExit: (_) => setState(() => _isHovered = false),
    child: AnimatedSlide(
      duration: AppMotion.fast,
      curve: Curves.easeOutCubic,
      offset: Offset(0, _isHovered ? -0.025 : 0),
      child: AnimatedScale(
        duration: AppMotion.fast,
        curve: Curves.easeOutCubic,
        scale: _isHovered ? 1.02 : 1,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          height: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color:
                _isHovered
                    ? AppColors.textPrimary.withValues(alpha: 0.1)
                    : AppColors.glassSurface,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            border: Border.all(
              color:
                  _isHovered
                      ? AppColors.accent.withValues(alpha: 0.55)
                      : AppColors.textPrimary.withValues(alpha: 0.12),
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow:
                _isHovered
                    ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.18),
                        blurRadius: 24,
                        spreadRadius: 2,
                        offset: const Offset(0, 12),
                      ),
                    ]
                    : null,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedPositioned(
                duration: AppMotion.fast,
                curve: Curves.easeOutCubic,
                left: 0,
                right: _isHovered ? 0 : 140,
                top: 0,
                child: AnimatedContainer(
                  duration: AppMotion.fast,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(
                      alpha: _isHovered ? 0.85 : 0,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: AppMotion.fast,
                        curve: Curves.easeOutCubic,
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(
                            alpha: _isHovered ? 0.28 : 0.16,
                          ),
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                        ),
                        child: AnimatedRotation(
                          duration: AppMotion.fast,
                          curve: Curves.easeOutCubic,
                          turns: _isHovered ? -0.04 : 0,
                          child: Icon(
                            widget.item.icon,
                            color: AppColors.accent,
                            size: 24,
                          ),
                        ),
                      ),
                      Text(
                        widget.item.period,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary.withValues(alpha: 0.68),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    widget.item.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.item.institution,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.82),
                      height: 1.35,
                    ),
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _EducationChip(text: widget.item.result),
                      _EducationChip(text: widget.item.location),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _EducationChip extends StatelessWidget {
  const _EducationChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    decoration: BoxDecoration(
      color: AppColors.bgDark.withValues(alpha: 0.48),
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.textPrimary.withValues(alpha: 0.78),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

@immutable
class _EducationItem {
  const _EducationItem({
    required this.period,
    required this.title,
    required this.institution,
    required this.result,
    required this.location,
    required this.icon,
  });

  final String period;
  final String title;
  final String institution;
  final String result;
  final String location;
  final IconData icon;
}
