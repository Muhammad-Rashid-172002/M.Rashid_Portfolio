// lib/sections/projects.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.onOpenProject});

  final void Function(String title) onOpenProject;

  // Replace these with your real asset image names
  static const List<Map<String, String>> _projects = [
    {
      'title': 'Noor Diesel Engineering company Website',
      'subtitle': 'Company web app for Noor Diesel Engineering',
      'image': 'assets/noor_diesel.png',
      'desc':
          'A responsive company website with service pages, contact form, and admin panel for managing projects and employees.',
    },
    {
      'title': 'Fiverr Client App',
      'subtitle': 'Client project on Fiverr',
      'image': 'assets/projects/fiverr_client.png',
      'desc':
          'Custom expanse tracker web and mobile landing created for a Fiverr client. Integrated payment links and analytics.',
    },
    {
      'title': 'Artha App',
      'subtitle': 'Finance / Wallet App',
      'image': 'assets/Artha.jpg',
      'desc':
          'Digital wallet app with transaction history, balance analytics, and secure authentication.',
    },
    {
      'title': 'Chatbot',
      'subtitle': 'AI Chatbot project',
      'image': 'assets/projects/chatbot.png',
      'desc':
          'An AI-powered conversational assistant integrated with a backend to assist users and provide replies.',
    },
    {
      'title': 'Chess Game',
      'subtitle': 'Custom chess game with hints',
      'image': 'assets/chess_game.jpg',
      'desc':
          'A native-like chess game implemented in Flutter with move hints, an elegant board UI, and local multiplayer.',
    },
    {
      'title': 'NutriScan',
      'subtitle': 'Food nutrition scanner',
      'image': 'assets/nutriscan.jpg',
      'desc':
          'Scan food images to extract nutrition facts, show history and personalized health suggestions.',
    },
    {
      'title': 'Tailor Pro',
      'subtitle': 'Tailoring management app',
      'image': 'assets/TailorPro.jpg',
      'desc':
          'Order management for tailors, measurement profiles, and invoice generation.',
    },
    {
      'title': 'Bill Snap (AI)',
      'subtitle': 'Smart bill scanner with AI',
      'image': 'assets/Bill_Snap.jpg',
      'desc':
          'OCR + AI to extract line items, categorize expenses, and export CSV.',
    },
    {
      'title': 'Makkah Journey',
      'subtitle': 'Travel app for pilgrimage',
      'image': 'assets/Makkah_Journey.jpeg',
      'desc':
          'Guide app for pilgrims with itineraries, maps, and local facility info.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width > 1200 ? 3 : (width > 800 ? 2 : 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Portfolio', style: AppTextStyles.heading(26)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final p = _projects[index];
              return _ProjectCard(
                title: p['title']!,
                subtitle: p['subtitle']!,
                imageAsset: p['image']!,
                description: p['desc']!,
                onOpen: () => onOpenProject(p['title']!),
              );
            },
          ),
        ],
      ),
    );
  }
}
// Individual project card widget
class _ProjectCard extends StatefulWidget {
  final String title, subtitle, imageAsset, description;
  final VoidCallback onOpen;
  const _ProjectCard({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.description,
    required this.onOpen,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}
// State for hover effect
class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: _hover
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [const BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image area
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.asset(
                  widget.imageAsset,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 160,
                    color: AppColors.primary.withOpacity(0.06),
                    child: Center(
                      child: Icon(
                        Icons.photo,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: AppTextStyles.heading(16)),
                    const SizedBox(height: 6),
                    Text(widget.subtitle, style: AppTextStyles.subtitle),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: widget.onOpen,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('View Project'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Case Study',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
