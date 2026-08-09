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

  const SocialLink({required this.label, required this.handle, required this.href});
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
  name: 'Alex Rivera',
  role: 'Software Engineer & Interface Designer',
  location: 'Lisbon, Portugal',
  available: true,
  email: 'hello@alexrivera.dev',
  tagline:
      'I build fast, considered interfaces where the engineering is invisible and the experience feels obvious.',
  intro: [
    'I am a software engineer who cares as much about the seam between two components as I do about the system that renders them. For the last eight years I have shipped products at the intersection of design and infrastructure — design systems, developer tools, and the quiet performance work that makes an app feel instant.',
    'My favourite problems are the ones nobody notices when they are solved well: a form that never loses your input, a page that hydrates before you finish blinking, an animation that gets out of your way.',
  ],
);

const socials = <SocialLink>[
  SocialLink(label: 'GitHub', handle: '@alexrivera', href: 'https://github.com'),
  SocialLink(label: 'LinkedIn', handle: 'in/alexrivera', href: 'https://linkedin.com'),
  SocialLink(label: 'X', handle: '@alexrivera', href: 'https://x.com'),
  SocialLink(label: 'Read.cv', handle: 'alexrivera', href: 'https://read.cv'),
];

const skillGroups = <SkillGroup>[
  SkillGroup(title: 'Languages', items: ['TypeScript', 'JavaScript', 'Rust', 'Python', 'SQL', 'Go']),
  SkillGroup(
    title: 'Frameworks',
    items: ['React', 'Next.js', 'Node.js', 'Svelte', 'tRPC', 'Tailwind CSS'],
  ),
  SkillGroup(
    title: 'Systems & Infra',
    items: ['PostgreSQL', 'Redis', 'Docker', 'Vercel', 'AWS', 'GraphQL'],
  ),
  SkillGroup(
    title: 'Craft',
    items: ['Design systems', 'Accessibility', 'Motion', 'Perf profiling', 'Prototyping'],
  ),
];

const experience = <Job>[
  Job(
    company: 'Northwind',
    role: 'Staff Software Engineer',
    period: '2022 — Present',
    location: 'Remote',
    summary:
        'Lead engineer on the design systems and editor platform teams, owning the component library used across every product surface.',
    highlights: [
      'Rebuilt the rendering pipeline, cutting time-to-interactive by 43% across the suite.',
      'Shipped a token-driven theming system adopted by 6 product teams.',
      'Mentored 4 engineers from mid to senior level.',
    ],
  ),
  Job(
    company: 'Loom Labs',
    role: 'Senior Frontend Engineer',
    period: '2019 — 2022',
    location: 'Berlin',
    summary:
        'Built the collaborative editor core and the real-time presence layer powering multiplayer documents.',
    highlights: [
      'Designed a CRDT-backed sync engine handling 20k concurrent sessions.',
      'Led the migration from a monolith to a typed, modular frontend.',
    ],
  ),
  Job(
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
  ),
];
