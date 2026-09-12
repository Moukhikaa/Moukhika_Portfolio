import 'package:flutter/material.dart';

@immutable
class CertificateProof {
  const CertificateProof({required this.label, this.fileName, this.url})
    : assert(
        fileName != null || url != null,
        'CertificateProof requires a local file name or URL.',
      );

  final String label;
  final String? fileName;
  final String? url;

  String? get webPath =>
      fileName == null ? null : 'assets/assets/certificates/$fileName';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateProof &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          fileName == other.fileName &&
          url == other.url;

  @override
  int get hashCode => label.hashCode ^ fileName.hashCode ^ url.hashCode;
}

@immutable
class CareerEvent {
  const CareerEvent({
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
    this.proofs = const [],
    this.company,
    this.location,
  });
  final int year;
  final String title;
  final String description;
  final IconData icon;
  final List<CertificateProof> proofs;
  final String? company;
  final String? location;

  static List<CareerEvent> get sampleEvents => [
    const CareerEvent(
      year: 2024,
      title: 'Mastering Data Structures & Algorithms',
      description:
          'Completed a 58.5 hour Udemy course on data structures and algorithms using C and C++, strengthening problem solving foundations.',
      icon: Icons.account_tree_outlined,
      company: 'Udemy - Abdul Bari',
      location: 'June 18, 2024',
      proofs: [
        CertificateProof(
          label: 'DSA Certificate',
          fileName: 'dsa_c_cpp_udemy.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'Data Engineering Virtual Internship',
      description:
          'Completed a 10 week AICTE EduSkills virtual internship with curriculum provided by AWS Academy.',
      icon: Icons.storage_outlined,
      company: 'AICTE x EduSkills - AWS Academy',
      location: 'January - March 2025',
      proofs: [
        CertificateProof(
          label: 'AWS Proof',
          fileName: 'data_engineering_aicte_eduskills_aws.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'Cisco Programming Essentials',
      description:
          'Completed JavaScript Essentials 1 and 2, followed by Python Essentials 1 and 2 through Cisco Networking Academy.',
      icon: Icons.terminal_outlined,
      company: 'Cisco Networking Academy',
      location: 'January - February 2025',
      proofs: [
        CertificateProof(
          label: 'JavaScript 1',
          fileName: 'javascript_essentials_1_cisco.pdf',
        ),
        CertificateProof(
          label: 'JavaScript 2',
          fileName: 'javascript_essentials_2_cisco.pdf',
        ),
        CertificateProof(
          label: 'Python 1',
          fileName: 'python_essentials_1_cisco.pdf',
        ),
        CertificateProof(
          label: 'Python 2',
          fileName: 'python_essentials_2_cisco.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'AI, GitHub & Critical Thinking',
      description:
          'Earned AI Fundamentals from DataCamp, GitHub Career Essentials from LinkedIn Learning, and Critical Thinking for Better Judgment and Decision-Making.',
      icon: Icons.psychology_outlined,
      company: 'DataCamp + LinkedIn Learning',
      location: 'February - March 2025',
      proofs: [
        CertificateProof(
          label: 'AI Fundamentals',
          fileName: 'ai_fundamentals_datacamp.pdf',
        ),
        CertificateProof(
          label: 'GitHub',
          fileName: 'github_career_essentials_linkedin.pdf',
        ),
        CertificateProof(
          label: 'Critical Thinking',
          fileName: 'critical_thinking_linkedin.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'Web Full Stack Developer Virtual Internship',
      description:
          'Completed a 10 week EduSkills Academy virtual internship focused on full stack development foundations.',
      icon: Icons.developer_mode_outlined,
      company: 'AICTE x EduSkills Academy',
      location: 'April - June 2025',
      proofs: [
        CertificateProof(
          label: 'Web FSD Proof',
          fileName: 'web_full_stack_developer_eduskills.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'HTML & CSS Essentials',
      description:
          'Completed HTML Essentials and CSS Essentials through the Cisco Networking Academy program at VIIT.',
      icon: Icons.web_asset_outlined,
      company: 'Cisco Networking Academy',
      location: 'June 2025',
      proofs: [
        CertificateProof(label: 'HTML', fileName: 'html_essentials_cisco.pdf'),
        CertificateProof(label: 'CSS', fileName: 'css_essentials_cisco.pdf'),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'Web Development Intern',
      description:
          'Completed a virtual web development internship, developing interactive pages with HTML, CSS, and JavaScript while applying responsive front-end concepts.',
      icon: Icons.web_outlined,
      company: 'AICTE x IBM SkillsBuild',
      location: 'June - July 2025',
      proofs: [
        CertificateProof(
          label: 'Certificate',
          url: 'https://canva.link/7z577e7y69gkrnm',
        ),
      ],
    ),
    const CareerEvent(
      year: 2025,
      title: 'Front End Web Development Internship',
      description:
          'Completed a 6 week Front End Web Development internship in collaboration with AICTE, implemented by Edunet Foundation.',
      icon: Icons.devices_outlined,
      company: 'AICTE x Edunet Foundation',
      location: 'August - September 2025',
      proofs: [
        CertificateProof(
          label: 'Front End Proof',
          fileName: 'front_end_web_development_aicte_edunet.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2026,
      title: 'AI & ML Intern',
      description:
          'Completed a short-term virtual internship focused on artificial intelligence and machine learning, including model development, experimentation, and technical problem-solving.',
      icon: Icons.model_training_outlined,
      company: 'APSCHE x SmartBridge',
      location: 'June - August 2026',
      proofs: [
        CertificateProof(
          label: 'Certificate',
          url: 'https://canva.link/exqveqpwg3ruun3',
        ),
      ],
    ),
    const CareerEvent(
      year: 2026,
      title: 'Data Science & Applied AI',
      description:
          'Completed Cisco Networking Academy credentials in Introduction to Data Science, Introduction to Modern AI, and applied AI analysis for customer reviews.',
      icon: Icons.insights_outlined,
      company: 'Cisco Networking Academy',
      location: 'June 09, 2026',
      proofs: [
        CertificateProof(
          label: 'Data Science',
          fileName: 'introduction_to_data_science_cisco.pdf',
        ),
        CertificateProof(
          label: 'Modern AI',
          fileName: 'introduction_to_modern_ai_cisco.pdf',
        ),
        CertificateProof(
          label: 'Apply AI',
          fileName: 'apply_ai_analyze_customer_reviews_cisco.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2026,
      title: 'CCNA Networking Track',
      description:
          'Completed the Cisco CCNA learning track across networking fundamentals, switching, routing, wireless essentials, enterprise networking, security, and automation.',
      icon: Icons.hub_outlined,
      company: 'Cisco Networking Academy',
      location: 'June 10, 2026',
      proofs: [
        CertificateProof(
          label: 'Intro Networks',
          fileName: 'ccna_introduction_to_networks_cisco.pdf',
        ),
        CertificateProof(
          label: 'SRWE',
          fileName: 'ccna_switching_routing_wireless_essentials_cisco.pdf',
        ),
        CertificateProof(
          label: 'ENSA',
          fileName: 'ccna_enterprise_networking_security_automation_cisco.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2026,
      title: 'Full Stack Web Development Intern',
      description:
          'Built responsive full-stack applications using HTML, CSS, JavaScript, React.js, Node.js, and Express.js, with REST APIs and GitHub workflow practice.',
      icon: Icons.code_outlined,
      company: 'ElevanceSkills',
      location: 'May - June 2026',
      proofs: [
        CertificateProof(
          label: 'Internship Proof',
          fileName: 'full_stack_web_development_elevanceskills.pdf',
        ),
      ],
    ),
    const CareerEvent(
      year: 2026,
      title: 'MERN Full Stack Development Internship',
      description:
          'Completed an 8 week MERN full stack internship with project work covering React, Node.js, Express.js, MongoDB, REST APIs, JWT authentication, deployment, and capstone projects.',
      icon: Icons.layers_outlined,
      company: 'MERN Full Stack Development with Project',
      location: 'Issued Aug 06, 2026',
      proofs: [
        CertificateProof(
          label: 'MERN Internship',
          fileName: 'mern_full_stack_development_internship_2026.pdf',
        ),
      ],
    ),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CareerEvent &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          title == other.title &&
          description == other.description &&
          icon == other.icon &&
          _listEquals(proofs, other.proofs) &&
          company == other.company &&
          location == other.location;

  @override
  int get hashCode =>
      year.hashCode ^
      title.hashCode ^
      description.hashCode ^
      icon.hashCode ^
      Object.hashAll(proofs) ^
      company.hashCode ^
      location.hashCode;

  @override
  String toString() =>
      'CareerEvent(year: $year, title: $title, company: $company)';
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) {
    return true;
  }
  if (a.length != b.length) {
    return false;
  }
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}
