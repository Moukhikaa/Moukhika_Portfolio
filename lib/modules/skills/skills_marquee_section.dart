import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/shared/animations/scroll_reveal.dart';

class SkillsMarqueeSection extends StatelessWidget {
  const SkillsMarqueeSection({super.key});

  static const List<String> _primarySkills = [
    'Python',
    'JavaScript',
    'Java',
    'C',
    'C++',
    'SQL',
    'HTML',
    'CSS',
    'React.js',
    'Flutter',
    'Node.js',
    'Express.js',
    'REST APIs',
    'MongoDB',
    'MySQL',
    'OpenCV',
    'MediaPipe',
    'Git',
    'GitHub',
  ];

  static const List<String> _secondarySkills = [
    'Django',
    'Flask',
    'Software Development',
    'Computer Vision',
    'AI Fundamentals',
    'Automation',
    'Data Structures',
    'OOP',
    'DBMS',
    'Operating Systems',
    'Networking',
    'Computer Networks',
    'Problem Solving',
    'Team Collaboration',
    'Agile Development',
    'Docker',
    'Vercel',
    'Netlify',
    'Render',
    'VS Code',
    'Critical Thinking',
    'Responsive UI',
  ];

  static const List<_SkillGroup> _groups = [
    _SkillGroup(
      title: 'Programming',
      skills: ['Python', 'JavaScript', 'Java', 'C', 'C++', 'SQL'],
      icon: Icons.terminal_rounded,
      accent: Color(0xFF62B2FF),
    ),
    _SkillGroup(
      title: 'Web Development',
      skills: [
        'HTML',
        'CSS',
        'JavaScript',
        'React.js',
        'Node.js',
        'Responsive UI',
      ],
      icon: Icons.design_services_rounded,
      accent: Color(0xFFFF8BA7),
    ),
    _SkillGroup(
      title: 'Backend',
      skills: [
        'Flask',
        'Django',
        'Express.js',
        'REST APIs',
        'Software Development',
      ],
      icon: Icons.storage_rounded,
      accent: Color(0xFFE6B980),
    ),
    _SkillGroup(
      title: 'Databases',
      skills: ['MongoDB', 'MySQL', 'DBMS'],
      icon: Icons.dataset_rounded,
      accent: Color(0xFF52C7EA),
    ),
    _SkillGroup(
      title: 'AI + Vision',
      skills: ['AI/ML', 'OpenCV', 'MediaPipe', 'Computer Vision'],
      icon: Icons.visibility_rounded,
      accent: Color(0xFF9F8CFF),
    ),
    _SkillGroup(
      title: 'Tools + Deploy',
      skills: ['Git', 'GitHub', 'VS Code', 'Docker', 'Vercel', 'Netlify'],
      icon: Icons.rocket_launch_rounded,
      accent: Color(0xFF66E3C4),
    ),
    _SkillGroup(
      title: 'Core CS',
      skills: ['DSA', 'OOP', 'Operating Systems', 'Computer Networks'],
      icon: Icons.account_tree_rounded,
      accent: Color(0xFFFFC857),
    ),
    _SkillGroup(
      title: 'Soft Skills',
      skills: ['Problem Solving', 'Team Collaboration', 'Agile Development'],
      icon: Icons.groups_rounded,
      accent: Color(0xFFFF8BA7),
    ),
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
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollReveal(child: _SkillsHeader(isMobile: isMobile)),
              SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
              const ScrollReveal(
                delay: Duration(milliseconds: 120),
                child: _SkillsTicker(
                  skills: _primarySkills,
                  duration: Duration(seconds: 26),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const ScrollReveal(
                delay: Duration(milliseconds: 180),
                child: _SkillsTicker(
                  skills: _secondarySkills,
                  duration: Duration(seconds: 32),
                  reverse: true,
                  muted: true,
                ),
              ),
              SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns =
                      constraints.maxWidth >= 1080
                          ? 3
                          : constraints.maxWidth >= 720
                          ? 2
                          : 1;
                  final spacing = isMobile ? AppSpacing.md : AppSpacing.lg;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (columns - 1)) /
                      columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (var index = 0; index < _groups.length; index++)
                        ScrollReveal(
                          delay: Duration(milliseconds: 160 + index * 60),
                          child: SizedBox(
                            width: cardWidth,
                            height: columns == 1 ? 210 : 230,
                            child: _SkillGroupCard(group: _groups[index]),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillsHeader extends StatelessWidget {
  const _SkillsHeader({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '(Skills.)',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Technical Toolkit',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: isMobile ? 34 : 50,
          height: 1,
          letterSpacing: 0,
        ),
      ),
    ],
  );
}

class _SkillsTicker extends StatefulWidget {
  const _SkillsTicker({
    required this.skills,
    required this.duration,
    this.reverse = false,
    this.muted = false,
  });

  final List<String> skills;
  final Duration duration;
  final bool reverse;
  final bool muted;

  @override
  State<_SkillsTicker> createState() => _SkillsTickerState();
}

class _SkillsTickerState extends State<_SkillsTicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 620;
      final itemWidth = isMobile ? 132.0 : 156.0;
      final rawWidth = widget.skills.length * itemWidth;
      final copies = math.max(2, (constraints.maxWidth / rawWidth).ceil() + 2);
      final segmentItems = [
        for (var copy = 0; copy < copies; copy++) ...widget.skills,
      ];
      final segmentWidth = segmentItems.length * itemWidth;

      return ClipRect(
        child: SizedBox(
          height: isMobile ? 50 : 58,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final travel = segmentWidth;
              final distance = _controller.value * travel;
              final base = widget.reverse ? distance : -distance;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  for (final left in [base - travel, base, base + travel])
                    Positioned(
                      left: left,
                      top: 0,
                      bottom: 0,
                      child: _TickerSegment(
                        skills: segmentItems,
                        itemWidth: itemWidth,
                        muted: widget.muted,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

class _TickerSegment extends StatelessWidget {
  const _TickerSegment({
    required this.skills,
    required this.itemWidth,
    required this.muted,
  });

  final List<String> skills;
  final double itemWidth;
  final bool muted;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (final skill in skills)
        SizedBox(
          width: itemWidth,
          child: Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color:
                    muted
                        ? AppColors.textPrimary.withValues(alpha: 0.055)
                        : AppColors.glassSurface,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                border: Border.all(
                  color:
                      muted
                          ? AppColors.textPrimary.withValues(alpha: 0.08)
                          : AppColors.accent.withValues(alpha: 0.26),
                ),
              ),
              child: Center(
                child: Text(
                  skill,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary.withValues(
                      alpha: muted ? 0.58 : 0.82,
                    ),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

class _SkillGroupCard extends StatefulWidget {
  const _SkillGroupCard({required this.group});

  final _SkillGroup group;

  @override
  State<_SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<_SkillGroupCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final group = widget.group;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
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
                    ? group.accent.withValues(alpha: 0.58)
                    : AppColors.textPrimary.withValues(alpha: 0.12),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: group.accent.withValues(alpha: 0.14),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedRotation(
                  duration: AppMotion.fast,
                  turns: _isHovered ? -0.035 : 0,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: group.accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Icon(group.icon, color: group.accent, size: 22),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    group.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final skill in group.skills)
                  _SkillPill(text: skill, accent: group.accent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  const _SkillPill({required this.text, required this.accent});

  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      border: Border.all(color: accent.withValues(alpha: 0.18)),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.textPrimary.withValues(alpha: 0.76),
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

@immutable
class _SkillGroup {
  const _SkillGroup({
    required this.title,
    required this.skills,
    required this.icon,
    required this.accent,
  });

  final String title;
  final List<String> skills;
  final IconData icon;
  final Color accent;
}
