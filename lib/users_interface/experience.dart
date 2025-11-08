// lib/sections/experience.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = [
      {
        'role': 'Mobile App Developer',
        'company': 'Noor Diesel Engineering (Company-based)',
        'duration': 'Jan 2022 — Present',
        'desc': 'Developed internal admin dashboards and client-facing mobile/web apps using Flutter & Firebase. Integrated REST APIs and optimized app performance for Android/iOS.'
      },
      {
        'role': 'Freelance Flutter Developer',
        'company': 'Freelancing (Fiverr / Direct Clients)',
        'duration': 'Jun 2021 — Present',
        'desc': 'Delivered 20+ small-to-medium projects: landing pages, dashboards, mobile apps, and integrations. Focus on UI polish, animations, and deployment.'
      }
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Work Experience', style: AppTextStyles.heading(24)),
          const SizedBox(height: 12),
          Column(
            children: experiences.map((e) {
              return _ExperienceCard(
                role: e['role']!,
                company: e['company']!,
                duration: e['duration']!,
                description: e['desc']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
// Individual experience card widget
class _ExperienceCard extends StatelessWidget {
  final String role, company, duration, description;
  const _ExperienceCard({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
              child: Center(child: Icon(Icons.work, color: AppColors.primary, size: 30)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(role, style: AppTextStyles.heading(16)),
                  const SizedBox(height: 4),
                  Text(company, style: AppTextStyles.subtitle.copyWith(color: AppColors.muted)),
                  const SizedBox(height: 6),
                  Text(duration, style: AppTextStyles.small.copyWith(color: AppColors.muted)),
                  const SizedBox(height: 8),
                  Text(description, style: AppTextStyles.subtitle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
