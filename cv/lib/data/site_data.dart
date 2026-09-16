// Central place for all CV content. Replace the placeholder values below
// with your real information — nothing else in the app needs to change.

class Profile {
  final String name;
  final String role;
  final String location;
  final bool available;
  final String email;
  final String tagline;
  final List<String> intro;

  const Profile({
    required this.name,
    required this.role,
    required this.location,
    required this.available,
    required this.email,
    required this.tagline,
    required this.intro,
  });
}

class SocialLink {
  final String label;
  final String handle;
  final String href;

  const SocialLink({
    required this.label,
    required this.handle,
    required this.href,
  });
}

class SkillGroup {
  final String title;
  final List<String> items;

  const SkillGroup({required this.title, required this.items});
}

class Job {
  final String company;
  final String role;
  final String period;
  final String location;
  final String summary;
  final List<String> highlights;

  const Job({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.summary,
    required this.highlights,
  });
}

const profile = Profile(
  name: 'Christian Maciosek',
  role: 'Software Engineer',
  location: 'Oelde Germany',
  available: false,
  email: 'christian-maciosek@t-online.de',
  tagline:
      'I build fast, considered interfaces where the engineering is invisible and the experience feels obvious.',
  intro: [
    'I am a software engineer who cares as much about the seam between two components as I do about the system that renders them. For the last eight years I have shipped products at the intersection of design and infrastructure — design systems, developer tools, and the quiet performance work that makes an app feel instant.',
    'My favourite problems are the ones nobody notices when they are solved well: a form that never loses your input, a page that hydrates before you finish blinking, an animation that gets out of your way.',
  ],
);

const socials = <SocialLink>[
  SocialLink(
    label: 'GitHub',
    handle: '@OhioTeppich',
    href: 'https://github.com/OhioTeppich',
  ),
  SocialLink(
    label: 'LinkedIn',
    handle: 'in/christian-maciosek',
    href: 'https://www.linkedin.com/in/christian-maciosek-4921aa249/',
  ),
  SocialLink(
    label: 'TryHackMe',
    handle: '@OhioTeppich',
    href: 'https://tryhackme.com/p/OhioTeppich',
  ),
  //SocialLink(label: 'X', handle: '@alexrivera', href: 'https://x.com'),
  //SocialLink(label: 'Read.cv', handle: 'alexrivera', href: 'https://read.cv'),
];

const skillGroups = <SkillGroup>[
  SkillGroup(title: 'Languages', items: ['Dart', 'Python', 'PHP', 'SQL']),
  SkillGroup(title: 'Frameworks', items: ['Flutter']),
  SkillGroup(
    title: 'Systems & Infra',
    items: ['PostgreSQL', 'Redis', 'Docker'],
  ),
  SkillGroup(
    title: 'Craft',
    items: [
      'Design systems',
      'Accessibility',
      'Motion',
      'Perf profiling',
      'Prototyping',
    ],
  ),
];

const experience = <Job>[
  Job(
    company: 'Nielsen Design GmbH',
    role: 'Software Engineer',
    period: '2025 — Present',
    location: 'Rheda-Wiedenbrück',
    summary:
        'Responsible for e-commerce integrations and internal operational software, connecting business systems and introducing AI capabilities.',
    highlights: [
      'Own REST-based integrations for product, pricing, inventory and customer data across Plenty, Magento, ERP and PIM, including order synchronisation between Plenty and Magento.',
      'Lead development of an internal operational data-capture app with Flutter, Dart and BLoC state management, used by production employees to record order data.',
      'Built a Python HTTP server that connects the app to Microsoft SQL Server, providing the data foundation for Power BI reports used by management and team leads.',
      'Co-own the selection of internal AI tools and identify opportunities for automation and document processing.',
    ],
  ),
  Job(
    company: 'RockAByte GmbH',
    role: 'Flutter Developer',
    period: '2023-2025',
    location: 'Köln',
    summary:
        'Worked in an agency environment, delivering client products in agile Scrum teams and coordinating closely with clients.',
    highlights: [
      'Led frontend development for Vodafone’s TOBi chatbot, shaping its UI, accessible experience and conversation flow.',
      'Contributed to Worksheet Go in a cross-functional project team.',
      'Built both projects with Flutter and Dart, REST APIs and BLoC state management, following a domain-driven approach.',
      'Wrote unit and widget tests within a test setup that also included integration tests.',
      'Worked in teams of 2 developers and 1 designer (TOBi) and 6 developers and 1 designer (Worksheet Go).',
    ],
  ),
  /*Job(
    company: 'Fieldwork',
    role: 'Product Engineer',
    period: '2017 — 2019',
    location: 'London',
    summary:
        'Early engineer building the first version of the analytics dashboard and public API.',
    highlights: [
      'Owned the charting library and data-fetching layer end to end.',
      'Set up the CI/CD and preview-deploy workflow still in use today.',
    ],
  ),*/
];
