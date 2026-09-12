import 'package:flutter/material.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/data/profile_data.dart';

class CurtainLoader extends StatefulWidget {
  const CurtainLoader({
    required this.onComplete,
    super.key,
    this.duration = const Duration(milliseconds: 2500),
  });

  final VoidCallback onComplete;
  final Duration duration;

  @override
  State<CurtainLoader> createState() => _CurtainLoaderState();
}

class _CurtainLoaderState extends State<CurtainLoader>
    with TickerProviderStateMixin {
  late AnimationController _curtainController;
  late AnimationController _textController;
  late Animation<double> _leftCurtainAnimation;
  late Animation<double> _rightCurtainAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();

    _curtainController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _leftCurtainAnimation = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(
        parent: _curtainController,
        curve: const Interval(0.5, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _rightCurtainAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _curtainController,
        curve: const Interval(0.52, 1, curve: Curves.easeInOutCubic),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0, 0.7, curve: Curves.easeOutQuart),
      ),
    );

    _textScaleAnimation = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0, 0.9, curve: Curves.easeOutBack),
      ),
    );

    _startAnimationSequence();
  }

  Future<void> _startAnimationSequence() async {
    await _textController.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      await _curtainController.forward().then((_) {
        if (mounted) {
          widget.onComplete();
        }
      });
    }
  }

  @override
  void dispose() {
    _curtainController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _curtainController,
            builder:
                (context, child) => Transform.translate(
                  offset: Offset(
                    screenSize.width * _leftCurtainAnimation.value,
                    0,
                  ),
                  child: Container(
                    width: screenSize.width / 2 + 2, // +2 for overlap
                    height: screenSize.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.bgDark,
                          AppColors.bgDark,
                          AppColors.bgDark.withValues(alpha: 0.95),
                        ],
                        stops: const [0.0, 0.8, 1.0],
                      ),
                    ),
                    child: _buildCurtainTexture(),
                  ),
                ),
          ),

          AnimatedBuilder(
            animation: _curtainController,
            builder:
                (context, child) => Transform.translate(
                  offset: Offset(
                    screenSize.width / 2 +
                        (screenSize.width * _rightCurtainAnimation.value),
                    0,
                  ),
                  child: Container(
                    width: screenSize.width / 2 + 2, // +2 for overlap
                    height: screenSize.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          AppColors.bgDark,
                          AppColors.bgDark,
                          AppColors.bgDark.withValues(alpha: 0.95),
                        ],
                        stops: const [0.0, 0.8, 1.0],
                      ),
                    ),
                    child: _buildCurtainTexture(),
                  ),
                ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _textController,
                _curtainController,
              ]),
              builder:
                  (context, child) => Transform.scale(
                    scale: _textScaleAnimation.value,
                    child: Opacity(
                      opacity:
                          _textOpacityAnimation.value *
                          (1.0 -
                              (_curtainController.value * 1.5).clamp(0.0, 1.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ProfileData.fullName.toUpperCase(),
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            ProfileData.role.toUpperCase(),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.86,
                              ),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 60,
                            height: 2,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            ProfileData.tagline,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.7,
                              ),
                              letterSpacing: 0,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurtainTexture() => DecoratedBox(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.1)),
      ),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.02,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
