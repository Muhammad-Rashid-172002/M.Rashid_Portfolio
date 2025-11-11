// lib/sections/contact.dart
import 'package:flutter/material.dart';
import 'package:m_rashid/theme/app_colors.dart';
import 'package:m_rashid/theme/app_text_styles.dart';


class ContactSection extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final void Function(String name, String email, String message) onSend;

  const ContactSection({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.onSend,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _hoverSend = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact With Me', style: AppTextStyles.heading(24)),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width > 1000 ? 900 : width - 48),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: widget.formKey,
                  // form fields
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: width > 800 ? 420 : double.infinity,
                            child: TextFormField(
                              controller: widget.nameController,
                              decoration: const InputDecoration(labelText: 'Your name'),
                              validator: (v) => (v == null || v.isEmpty) ? 'Please enter name' : null,
                            ),
                          ),
                          SizedBox(
                            width: width > 800 ? 420 : double.infinity,
                            child: TextFormField(
                              controller: widget.emailController,
                              decoration: const InputDecoration(labelText: 'Email address'),
                              validator: (v) => (v == null || v.isEmpty) ? 'Please enter email' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: widget.messageController,
                        maxLines: 6,
                        decoration: const InputDecoration(labelText: 'Message'),
                        validator: (v) => (v == null || v.isEmpty) ? 'Please enter message' : null,
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MouseRegion(
                          onEnter: (_) => setState(() => _hoverSend = true),
                          onExit: (_) => setState(() => _hoverSend = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            decoration: BoxDecoration(
                              color: _hoverSend ? AppColors.primary.withOpacity(0.92) : AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: _hoverSend ? [BoxShadow(color: AppColors.primary.withOpacity(0.22), blurRadius: 8, offset: const Offset(0, 6))] : [const BoxShadow(color: Colors.black12, blurRadius: 6)],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (widget.formKey.currentState!.validate()) {
                                    widget.onSend(widget.nameController.text, widget.emailController.text, widget.messageController.text);
                                    widget.nameController.clear();
                                    widget.emailController.clear();
                                    widget.messageController.clear();
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  child: Text('Send Message', style: AppTextStyles.button.copyWith(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
