// lib/sections/about.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'dart:html' as html; // only used in web for download

class AboutSection extends StatelessWidget {
  final List<String> roles;
  final int roleIndex;
  final VoidCallback onDownloadCV;
  final VoidCallback onContactTap;

  const AboutSection({
    super.key,
    required this.roles,
    required this.roleIndex,
    required this.onDownloadCV,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF3F8FF), Color(0xFFFFFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: isWide
          ? Row(
              children: [
                Expanded(child: _leftColumn(context)),
                const SizedBox(width: 32),
                _profileCard(),
              ],
            )
          : Column(
              children: [
                _leftColumn(context),
                const SizedBox(height: 18),
                _profileCard(),
              ],
            ),
    );
  }

  Widget _leftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("I'm", style: AppTextStyles.heading(28)),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Pro",
                style: AppTextStyles.heading(20).copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                roles[roleIndex],
                key: ValueKey(roles[roleIndex]),
                style: AppTextStyles.heading(
                  22,
                ).copyWith(color: AppColors.text),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // descriptive text
        Text(
          "I build production-grade mobile & web apps using Flutter. Experienced in cross-platform UI, Firebase integration, REST APIs, and deploying responsive web apps.",
          style: AppTextStyles.subtitle,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            _hoverButton(
              label: 'Download CV',
              icon: Icons.download,
              onTap: onDownloadCV,
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: onContactTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Contact Me',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        // social icons
        Wrap(
          spacing: 12,
          children: [
            _socialIcon(
              'GitHub',
              Icons.code,
              'https://github.com/Muhammad-Rashid-172002',
            ),
            _socialIcon(
              'LinkedIn',
              Icons.business,
              'https://www.linkedin.com/in/muhammad-rashid-flutterdev/',
            ),
            _emailChip('muhammadrashid172002@gmail.com'),
          ],
        ),
      ],
    );
  }
// profile card widget
  Widget _profileCard() {
    return SizedBox(
      width: 420,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/Rashid_Profile_Pic_01.png',
            fit: BoxFit.cover,
            height: 320,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _hoverButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return _HoverActionButton(icon: icon, label: label, onTap: onTap);
  }

  Widget _socialIcon(String label, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // open url logic (left to implement using url_launcher)
          if (kDebugMode) print('open $url');
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _emailChip(String email) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.email, size: 18, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            email,
            style: AppTextStyles.subtitle.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

// small reusable hover button
class _HoverActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _HoverActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_HoverActionButton> createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<_HoverActionButton> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.primary.withOpacity(0.92)
              : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [const BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: AppTextStyles.button.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
