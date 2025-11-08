// lib/sections/header.dart
import 'package:flutter/material.dart';
import 'package:m_rashid/theme/app_colors.dart';
import 'package:m_rashid/theme/app_text_styles.dart';


class Header extends StatefulWidget {
  final void Function(String) onNavTap;
  final VoidCallback onHireTap;
  final VoidCallback onDownload;
  final bool isWide;

  const Header({
    super.key,
    required this.onNavTap,
    required this.onHireTap,
    required this.onDownload,
    required this.isWide,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _hoverHire = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      child: Row(
        children: [
          // logo + name
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary,
                child: Text('MR', style: AppTextStyles.heading(16).copyWith(color: Colors.white)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Muhammad Rashid', style: AppTextStyles.heading(16)),
                  Text('Prof Flutter Developer', style: AppTextStyles.subtitle),
                ],
              ),
            ],
          ),
          const Spacer(),
          // nav (only visible on wide screens)
          if (widget.isWide)
            Row(
              children: [
                _navButton('About', () => widget.onNavTap('about')),
                _navButton('Portfolio', () => widget.onNavTap('projects')),
                _navButton('Experience', () => widget.onNavTap('experience')),
                _navButton('Contact', () => widget.onNavTap('contact')),
                const SizedBox(width: 12),
                MouseRegion(
                  onEnter: (_) => setState(() => _hoverHire = true),
                  onExit: (_) => setState(() => _hoverHire = false),
                  child: GestureDetector(
                    onTap: widget.onHireTap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: _hoverHire
                            ? LinearGradient(colors: [AppColors.primary, AppColors.secondaryAccent])
                            : null,
                        color: _hoverHire ? null : AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _hoverHire
                            ? [BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 6))]
                            : [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      ),
                      child: Text(
                        'Hire Me',
                        style: AppTextStyles.button.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // download icon quick action
                IconButton(
                  tooltip: 'Download CV',
                  onPressed: widget.onDownload,
                  icon: const Icon(Icons.download_rounded),
                  color: AppColors.primary,
                ),
              ],
            ),
        ],
      ),
    );
  }
// navigation button widget
  Widget _navButton(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(title, style: AppTextStyles.subtitle.copyWith(color: AppColors.text)),
    );
  }
}
