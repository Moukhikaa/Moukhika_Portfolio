import 'package:flutter/material.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/shared/animations/scroll_reveal.dart';
import 'package:url_launcher/url_launcher.dart';

class WorksSection extends StatelessWidget {
  const WorksSection({super.key, this.scrollController});

  final ScrollController? scrollController;

  static const _ProjectItem _featuredProject = _ProjectItem(
    title: 'Detox BuildMatch',
    category: 'Trivium 2.0 Hackathon Winner',
    description:
        'Built and presented a functional web-based solution in a two-member team, secured 1st place, and won a 1-year JetBrains subscription prize.',
    liveUrl: 'https://detox-buildmatch.netlify.app/',
    tags: ['1st Place', 'Hackathon', 'Team Build', 'Web Solution'],
    icon: Icons.emoji_events_rounded,
    accent: Color(0xFFFFC857),
  );

  static const List<_ProjectItem> _projects = [
    _ProjectItem(
      title: 'Parking Detection',
      category: 'Computer Vision',
      description:
          'Detects occupied and empty parking slots from camera feeds, then exposes live availability through a backend endpoint.',
      githubUrl: 'https://github.com/Moukhikaa/parking-detection',
      liveUrl: 'https://parking-detection.onrender.com/video_feed',
      tags: ['Python', 'OpenCV', 'FastAPI', 'Docker'],
      icon: Icons.local_parking_rounded,
      accent: Color(0xFF62B2FF),
    ),
    _ProjectItem(
      title: 'BrightBucks Scholarships',
      category: 'Full Stack Web',
      description:
          'A scholarship discovery platform that helps students filter opportunities by education level and scholarship type.',
      githubUrl: 'https://github.com/Moukhikaa/BrightBucks-Scholarships',
      liveUrl: 'https://brightbucks05.netlify.app/',
      tags: ['HTML', 'CSS', 'JavaScript', 'Netlify'],
      icon: Icons.school_rounded,
      accent: Color(0xFF52C7EA),
    ),
    _ProjectItem(
      title: 'Speech Coach AI',
      category: 'AI Practice Tool',
      description:
          'A browser-based speaking coach for recording practice, checking transcripts, and reviewing delivery feedback.',
      githubUrl: 'https://github.com/Moukhikaa/speech_coach',
      liveUrl: 'https://speech-coach-ivory.vercel.app/',
      tags: ['JavaScript', 'Web Speech API', 'Vercel'],
      icon: Icons.record_voice_over_rounded,
      accent: Color(0xFFE6B980),
    ),
    _ProjectItem(
      title: 'Gesture Calculator',
      category: 'Computer Vision',
      description:
          'A hand-gesture calculator that maps finger signs to numeric input and operations using real-time vision tracking.',
      githubUrl: 'https://github.com/Moukhikaa/Gesture_Calculator',
      tags: ['Python', 'OpenCV', 'MediaPipe', 'NumPy'],
      icon: Icons.back_hand_rounded,
      accent: Color(0xFF9F8CFF),
    ),
    _ProjectItem(
      title: 'PhotoBooth',
      category: 'Interactive Web App',
      description:
          'A camera photobooth experience that captures timed shots locally and lets users download their photo memories.',
      githubUrl: 'https://github.com/Moukhikaa/PhotoBooth',
      liveUrl: 'https://photo-booth-drab.vercel.app/',
      tags: ['HTML', 'CSS', 'JavaScript', 'Webcam'],
      icon: Icons.photo_camera_front_rounded,
      accent: Color(0xFFFF8BA7),
    ),
    _ProjectItem(
      title: 'Voice Assistant',
      category: 'Automation',
      description:
          'A Python desktop assistant that listens to voice commands, fetches quick information, and automates useful tasks.',
      githubUrl: 'https://github.com/Moukhikaa/Voice_assistance',
      tags: ['Python', 'Speech', 'Wikipedia API', 'Automation'],
      icon: Icons.mic_rounded,
      accent: Color(0xFF66E3C4),
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
              ScrollReveal(child: _WorksHeader(isMobile: isMobile)),
              SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),
              const ScrollReveal(
                delay: Duration(milliseconds: 80),
                child: _FeaturedProjectCard(project: _featuredProject),
              ),
              SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns =
                      constraints.maxWidth >= 1120
                          ? 3
                          : constraints.maxWidth >= 740
                          ? 2
                          : 1;
                  final spacing = isMobile ? AppSpacing.md : AppSpacing.lg;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (columns - 1)) /
                      columns;
                  final cardHeight =
                      columns == 1
                          ? 380.0
                          : columns == 2
                          ? 390.0
                          : 370.0;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (var index = 0; index < _projects.length; index++)
                        ScrollReveal(
                          delay: Duration(milliseconds: 110 + index * 55),
                          child: SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: _ProjectCard(project: _projects[index]),
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

class _FeaturedProjectCard extends StatefulWidget {
  const _FeaturedProjectCard({required this.project});

  final _ProjectItem project;

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 760;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedSlide(
        duration: AppMotion.fast,
        curve: Curves.easeOutCubic,
        offset: Offset(0, _isHovered ? -0.014 : 0),
        child: AnimatedScale(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          scale: _isHovered ? 1.01 : 1,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: Curves.easeOutCubic,
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              border: Border.all(
                color: project.accent.withValues(
                  alpha: _isHovered ? 0.78 : 0.5,
                ),
                width: _isHovered ? 1.6 : 1.2,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  project.accent.withValues(alpha: 0.2),
                  AppColors.glassSurface,
                  AppColors.bgDark.withValues(alpha: 0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: project.accent.withValues(
                    alpha: _isHovered ? 0.22 : 0.12,
                  ),
                  blurRadius: _isHovered ? 34 : 22,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: isMobile ? -22 : 4,
                  top: isMobile ? -18 : -12,
                  child: AnimatedRotation(
                    duration: AppMotion.medium,
                    turns: _isHovered ? -0.03 : 0,
                    child: Icon(
                      Icons.emoji_events_rounded,
                      size: isMobile ? 110 : 170,
                      color: project.accent.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment:
                      isMobile
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: isMobile ? 0 : 7,
                      fit: isMobile ? FlexFit.loose : FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _WinnerBadge(accent: project.accent),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            project.title,
                            style: Theme.of(
                              context,
                            ).textTheme.displaySmall?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w900,
                              fontSize: isMobile ? 38 : 56,
                              height: 0.95,
                              letterSpacing: 0,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            project.category,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: project.accent,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            child: Text(
                              project.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textPrimary.withValues(
                                  alpha: 0.82,
                                ),
                                height: 1.45,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              for (final tag in project.tags)
                                _ProjectTag(text: tag, accent: project.accent),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _ProjectActionButton(
                            label: 'Try',
                            icon: Icons.open_in_new_rounded,
                            url: project.liveUrl!,
                            accent: project.accent,
                            filled: true,
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) ...[
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '1st',
                                style: Theme.of(
                                  context,
                                ).textTheme.displayLarge?.copyWith(
                                  color: project.accent.withValues(alpha: 0.95),
                                  fontSize: 118,
                                  fontWeight: FontWeight.w900,
                                  height: 0.8,
                                  letterSpacing: 0,
                                ),
                              ),
                              Text(
                                'Place',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium?.copyWith(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.86,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'Two-member team',
                                textAlign: TextAlign.right,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.7,
                                  ),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'JetBrains prize winner',
                                textAlign: TextAlign.right,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.7,
                                  ),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WinnerBadge extends StatelessWidget {
  const _WinnerBadge({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      border: Border.all(color: accent.withValues(alpha: 0.36)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.workspace_premium_rounded, color: accent, size: 18),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '1st Place Hackathon Winner',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary.withValues(alpha: 0.9),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );
}

class _WorksHeader extends StatelessWidget {
  const _WorksHeader({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '(Works.)',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Projects',
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

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});

  final _ProjectItem project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedSlide(
        duration: AppMotion.fast,
        curve: Curves.easeOutCubic,
        offset: Offset(0, _isHovered ? -0.018 : 0),
        child: AnimatedScale(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          scale: _isHovered ? 1.015 : 1,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: Curves.easeOutCubic,
            height: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color:
                  _isHovered
                      ? AppColors.textPrimary.withValues(alpha: 0.105)
                      : AppColors.glassSurface,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              border: Border.all(
                color:
                    _isHovered
                        ? project.accent.withValues(alpha: 0.62)
                        : AppColors.textPrimary.withValues(alpha: 0.12),
                width: _isHovered ? 1.4 : 1,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: project.accent.withValues(alpha: 0.16),
                    blurRadius: 26,
                    offset: const Offset(0, 16),
                  ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: AppMotion.fast,
                  curve: Curves.easeOutCubic,
                  left: 0,
                  right: _isHovered ? 0 : 190,
                  top: 0,
                  child: AnimatedContainer(
                    duration: AppMotion.fast,
                    height: 3,
                    decoration: BoxDecoration(
                      color: project.accent.withValues(
                        alpha: _isHovered ? 0.95 : 0.5,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedRotation(
                          duration: AppMotion.fast,
                          turns: _isHovered ? -0.035 : 0,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: project.accent.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.sm,
                              ),
                            ),
                            child: Icon(
                              project.icon,
                              color: project.accent,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            project.category,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: project.accent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      project.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.76),
                        height: 1.45,
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final tag in project.tags) _ProjectTag(text: tag),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        if (project.githubUrl != null)
                          _ProjectActionButton(
                            label: 'GitHub',
                            icon: Icons.code_rounded,
                            url: project.githubUrl!,
                            accent: project.accent,
                            filled: false,
                          ),
                        if (project.liveUrl != null)
                          _ProjectActionButton(
                            label: 'Try',
                            icon: Icons.open_in_new_rounded,
                            url: project.liveUrl!,
                            accent: project.accent,
                            filled: true,
                          ),
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
}

class _ProjectTag extends StatelessWidget {
  const _ProjectTag({required this.text, this.accent});

  final String text;
  final Color? accent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(
      color:
          accent == null
              ? AppColors.bgDark.withValues(alpha: 0.48)
              : accent!.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      border: Border.all(
        color:
            accent == null
                ? AppColors.textPrimary.withValues(alpha: 0.08)
                : accent!.withValues(alpha: 0.24),
      ),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.textPrimary.withValues(alpha: 0.74),
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _ProjectActionButton extends StatelessWidget {
  const _ProjectActionButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.accent,
    required this.filled,
  });

  final String label;
  final IconData icon;
  final String url;
  final Color accent;
  final bool filled;

  Future<void> _launch() async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final foreground = filled ? AppColors.bgDark : AppColors.textPrimary;

    return SizedBox(
      height: 40,
      child: OutlinedButton.icon(
        onPressed: _launch,
        icon: Icon(icon, size: 17),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          backgroundColor: filled ? accent : Colors.transparent,
          foregroundColor: foreground,
          side: BorderSide(
            color:
                filled
                    ? accent.withValues(alpha: 0.7)
                    : AppColors.textPrimary.withValues(alpha: 0.28),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

@immutable
class _ProjectItem {
  const _ProjectItem({
    required this.title,
    required this.category,
    required this.description,
    required this.tags,
    required this.icon,
    required this.accent,
    this.githubUrl,
    this.liveUrl,
  });

  final String title;
  final String category;
  final String description;
  final String? githubUrl;
  final String? liveUrl;
  final List<String> tags;
  final IconData icon;
  final Color accent;
}
