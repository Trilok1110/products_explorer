import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue, size: 26),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 15, height: 1.5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // App Information
            buildSection(
              icon: FontAwesomeIcons.cube,
              title: 'Products Explorer',
              children: const [
                Text("Version: 1.0.0"),
                SizedBox(height: 6),
                Text("Developed by: Trilok"),
                SizedBox(height: 12),
                Text(
                  "Products Explorer is a Flutter app that allows users to browse a list of products, view details, and search efficiently. "
                      "It features both Future and Stream-based data fetching with a clean, modern UI.",
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),

            // Company Overview
            buildSection(
              icon: FontAwesomeIcons.building,
              title: 'CyberPoint Private Limited',
              children: [
                Text(
                  "Welcome to CyberPoint Private Limited, a media company that specializes in creating and managing a portfolio of review websites in various niches.",
                  style: textStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  "• Experience: Managing multiple review sites for over 8 years.\n"
                      "• Evolution: Started as a sole proprietorship, became a Pvt Ltd in 2023.\n"
                      "• Services: Review websites, digital marketing, SEO, PPC, and more.",
                  style: textStyle,
                ),
              ],
            ),

            // Team & Mission
            buildSection(
              icon: FontAwesomeIcons.peopleGroup,
              title: 'Our Team & Mission',
              children: [
                Text(
                  "Our team consists of 100+ experts in digital marketing, writing, research, and design. "
                      "We work together to provide unbiased, high-quality content.",
                  style: textStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  "Our mission is to help consumers make informed decisions by offering accurate and easy-to-understand product reviews. "
                      "We aim to empower the online community with reliable information.",
                  style: textStyle,
                ),
              ],
            ),

            // Contact Information
            buildSection(
              icon: FontAwesomeIcons.solidEnvelope,
              title: 'Contact & Offices',
              children: [
                const Text("📧 Email: info@cyberpoint.com"),
                const SizedBox(height: 8),
                Text(
                  "📍 Offices:\n"
                      "• Mohaladiya, Kokila, Neemrana, Alwar, Rajasthan - 301020\n"
                      "• Sardar Patel Nagar, Pathankot, Punjab - 145001\n"
                      "• Unit 614/614A, 6th Floor, Tower B4, Spaze I-Tech Park, Gurugram, Haryana - 122018",
                  style: textStyle,
                ),
                const SizedBox(height: 12),
                const Text("© 2025 CyberPoint Private Limited"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
