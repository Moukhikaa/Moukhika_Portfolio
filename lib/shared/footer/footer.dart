import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polymorphism/core/constant.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/data/profile_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  late Timer _timer;
  String _indiaTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final utcNow = DateTime.now().toUtc();
    final indiaTime = utcNow.add(const Duration(hours: 5, minutes: 30));
    final formatter = DateFormat('h:mm a');
    setState(() {
      _indiaTime = formatter.format(indiaTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bgDark,
        border: Border(
          top: BorderSide(color: AppColors.textPrimary.withValues(alpha: .1)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding(context),
          vertical: isMobile
              ? verticalPadding(context) * 0.6
              : verticalPadding(context),
        ),
        child: Column(
          children: [
            if (isMobile)
              _buildMobileLayout(context)
            else
              _buildDesktopLayout(context),
            SizedBox(height: isMobile ? 16 : 24),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fitWidth,
              height: isMobile ? 40 : 60,
              errorBuilder: (context, error, stackTrace) => Text(
                ProfileData.fullName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '(c) 2026 ${ProfileData.shortName}.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textPrimary.withValues(alpha: .7),
        ),
      ),
      Text(
        ProfileData.email,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textPrimary.withValues(alpha: .7),
        ),
      ),
      Text(
        'India $_indiaTime',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textPrimary.withValues(alpha: .7),
        ),
      ),

      const Row(
        children: [
          _SocialIcon(
            icon: Icons.code,
            tooltip: 'GitHub',
            url: ProfileData.githubUrl,
          ),
          SizedBox(width: 16),
          _SocialIcon(
            icon: Icons.work,
            tooltip: 'LinkedIn',
            url: ProfileData.linkedInUrl,
          ),
          SizedBox(width: 16),
          _SocialIcon(
            icon: Icons.data_object,
            tooltip: 'LeetCode',
            url: ProfileData.leetCodeUrl,
          ),
          SizedBox(width: 16),
          _SocialIcon(
            icon: Icons.restaurant_menu,
            tooltip: 'CodeChef',
            url: ProfileData.codeChefUrl,
          ),
        ],
      ),
    ],
  );

  Widget _buildMobileLayout(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '(c) 2026 ${ProfileData.shortName}.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textPrimary.withValues(alpha: .7),
              fontSize: 12,
            ),
          ),
          Text(
            'India $_indiaTime',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textPrimary.withValues(alpha: .7),
              fontSize: 12,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              ProfileData.email,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary.withValues(alpha: .7),
                fontSize: 12,
              ),
            ),
          ),
          const Row(
            children: [
              _SocialIcon(
                icon: Icons.code,
                tooltip: 'GitHub',
                url: ProfileData.githubUrl,
              ),
              SizedBox(width: 12),
              _SocialIcon(
                icon: Icons.work,
                tooltip: 'LinkedIn',
                url: ProfileData.linkedInUrl,
              ),
              SizedBox(width: 12),
              _SocialIcon(
                icon: Icons.data_object,
                tooltip: 'LeetCode',
                url: ProfileData.leetCodeUrl,
              ),
              SizedBox(width: 12),
              _SocialIcon(
                icon: Icons.restaurant_menu,
                tooltip: 'CodeChef',
                url: ProfileData.codeChefUrl,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.url,
  });
  final IconData icon;
  final String tooltip;
  final String url;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: AppMotion.fast, vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => _handleHover(true),
    onExit: (_) => _handleHover(false),
    child: ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: _launchUrl,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Tooltip(
              message: widget.tooltip,
              child: Icon(
                widget.icon,
                size: 20,
                color: _isHovered
                    ? AppColors.accent
                    : AppColors.textPrimary.withValues(alpha: .7),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
