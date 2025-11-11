// lib/main.dart
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html; // for web download
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m_rashid/users_interface/About_me.dart';
import 'package:m_rashid/users_interface/Contact.dart';
import 'package:m_rashid/users_interface/Projects.dart';
import 'package:m_rashid/users_interface/experience.dart';
import 'package:m_rashid/users_interface/header.dart';

// theme & sections
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';


void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Muhammad Rashid — Portfolio",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.surface,
        textTheme: AppTextStyles.textTheme,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();

  // roles rotating
  final List<String> _roles = [
    "Flutter Developer",
    "Android Developer",
    "iOS Developer",
    "UI Engineer",
    "Mobile Engineer"
  ];
  int _roleIndex = 0;
  Timer? _roleTimer;

  // contact form controllers (passed down to contact section)
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // EmailJS placeholders
  static const String emailJsServiceId = 'YOUR_SERVICE_ID';
  static const String emailJsTemplateId = 'YOUR_TEMPLATE_ID';
  static const String emailJsUserId = 'YOUR_PUBLIC_KEY';

  // hover states (for header actions)
  bool _isHoveringHire = false;

  @override
  void initState() {
    super.initState();
    _roleTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() => _roleIndex = (_roleIndex + 1) % _roles.length);
    });
  }

  @override
  void dispose() {
    _roleTimer?.cancel();
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // EmailJS send (used by Contact section via callback)
  Future<void> sendEmailJS({
    required String name,
    required String email,
    required String message,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final body = json.encode({
      'service_id': emailJsServiceId,
      'template_id': emailJsTemplateId,
      'user_id': emailJsUserId,
      'template_params': {
        'from_name': name,
        'from_email': email,
        'message': message,
      }
    });

    try {
      final res = await http.post(url, headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      }, body: body);

      if (res.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Message sent successfully')),
          );
        }
        // fields reset
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('❌ Failed to send message')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Error sending message')),
        );
      }
    }
  }

  // scroll to section helper
  void scrollTo(GlobalKey key) {
    // we use context & RenderObject to bring into view
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  // keys for sections
  final GlobalKey headerKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // Download CV action
  void _downloadCV() {
    const cvAsset = 'assets/MuhammadRashidCV.pdf';
    if (kIsWeb) {
      html.AnchorElement(href: cvAsset)
        ..download = 'Muhammad_Rashid_CV.pdf'
        ..click();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('📄 CV download (mobile/desktop) - use file manager to save.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Scaffold(
      body: Column(
        children: [
          // Header (pass keys and callbacks)
          Header(
            key: headerKey,
            onNavTap: (section) {
              if (section == 'about') scrollTo(aboutKey);
              if (section == 'projects') scrollTo(projectsKey);
              if (section == 'experience') scrollTo(experienceKey);
              if (section == 'contact') scrollTo(contactKey);
            },
            onHireTap: () => scrollTo(contactKey),
            onDownload: _downloadCV,
            isWide: isWide,
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HERO / ABOUT
                  AboutSection(
                    key: aboutKey,
                    roles: _roles,
                    roleIndex: _roleIndex,
                    onDownloadCV: _downloadCV,
                    onContactTap: () => scrollTo(contactKey),
                  ),

                  // Projects
                  ProjectsSection(
                    key: projectsKey,
                    onOpenProject: (title) {
                      // placeholder for opening a modal or url
                      if (kDebugMode) print('Open project: $title');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Open project: $title')),
                      );
                    },
                  ),

                  // Experience
                  ExperienceSection(key: experienceKey),

                  // Contact (passes form controllers and send callback)
                  ContactSection(
                    key: contactKey,
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    messageController: _messageController,
                    onSend: (name, email, message) =>
                        sendEmailJS(name: name, email: email, message: message),
                  ),

                  const SizedBox(height: 48),
                  // footer
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28.0),
                      child: Text(
                        '© ${DateTime.now().year} Muhammad Rashid — All rights reserved',
                        style: AppTextStyles.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
