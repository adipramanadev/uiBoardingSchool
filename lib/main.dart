import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const BoardingSchoolApp());
}

class BoardingSchoolApp extends StatelessWidget {
  const BoardingSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boarding School',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SchoolProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SchoolProfilePage extends StatelessWidget {
  const SchoolProfilePage({super.key});

  // Demo content (replace with real data / models)
  static const String schoolName = 'Boarding School XYZ';
  static const String tagline = 'Mencetak Generasi Unggul & Berakhlak';
  static const String about =
      'Boarding School XYZ berdiri sejak 2010 dengan lingkungan asri dan program pendidikan terpadu antara akademik dan karakter. Kami berkomitmen menghadirkan pengalaman belajar yang aman, nyaman, dan inspiratif.';

  static const List<_Facility> facilities = [
    _Facility(Icons.school, 'Asrama'),
    _Facility(Icons.local_library, 'Perpustakaan'),
    _Facility(Icons.sports_soccer, 'Lapangan'),
    _Facility(Icons.science, 'Laboratorium'),
    _Facility(Icons.mosque, 'Masjid'),
    _Facility(Icons.local_hospital, 'Klinik'),
  ];

  static const List<String> programs = [
    'Kurikulum Nasional',
    'Tahfidz Qur\'an',
    'Ekstrakurikuler Olahraga & Seni',
    'Leadership Camp',
  ];

  static const List<String> gallery = [
    // Replace with your own asset image paths or network links
    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=1600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519455953755-af066f52f1ea?q=80&w=1600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1588072432836-e10032774350?q=80&w=1600&auto=format&fit=crop',
  ];

  static const String phone = '+62 812-0000-0000';
  static const String email = 'info@xyz.ac.id';
  static const String address = 'Jl. Pendidikan No.123, Kota Asri';
  static const String mapsQuery = 'Boarding School XYZ, Kota Asri Indonesia';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            leading: IconButton(
              icon: Icon(
                Icons.school_outlined,
                color: Colors.green[200],
                size: 28,
              ),
              onPressed: () {}, // Hook up to Navigator.pop if needed
              tooltip: 'Kembali',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.greenAccent,
                  size: 28,
                ),
                onPressed: () {
                  // connect to Share plugin if desired
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share coming soon...')),
                  );
                },
                tooltip: 'Bagikan',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Hero image (replace with AssetImage if you have assets)
                  CachedNetworkImage(
                    imageUrl:
                        'https://www.mustseespots.com/saudi-arabia/img/al-masjid-an-nabawi.jpg',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(color: Colors.black.withOpacity(0.5)),
                ],
              ),
            ),
          ),

          // Header card with logo, name, tagline
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _HeaderCard(title: schoolName, subtitle: tagline),
            ),
          ),

          // About section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionCard(
                title: 'Tentang Sekolah',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(about, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton.tonal(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Buka detail profil...'),
                            ),
                          );
                        },
                        child: const Text('Selengkapnya'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Facilities grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionCard(
                title: 'Fasilitas',
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.2, // increased from 1.1
                    mainAxisSpacing: 8, // reduced spacing
                    crossAxisSpacing: 8, // reduced spacing
                  ),
                  itemCount: facilities.length,
                  itemBuilder: (context, index) {
                    final f = facilities[index];
                    return FacilityCard(facility: f);
                  },
                ),
              ),
            ),
          ),

          // Programs list + small photo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionCard(
                title: 'Program Pendidikan',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: programs
                            .map(
                              (p) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(p)),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1571260899304-425eee4c7efc?q=80&w=800&auto=format&fit=crop',
                        width: 110,
                        height: 88,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Gallery slider
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SectionCard(
                title: 'Galeri',
                child: SizedBox(
                  height: 180,
                  child: _GalleryCarousel(images: gallery),
                ),
              ),
            ),
          ),

          // Contact & Location
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: SectionCard(
                title: 'Kontak & Lokasi',
                child: Column(
                  children: [
                    InfoRow(icon: Icons.place_outlined, text: address),
                    InfoRow(icon: Icons.phone_outlined, text: phone),
                    InfoRow(icon: Icons.email_outlined, text: email),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () => _launchUrl(
                              Uri.parse('https://wa.me/6281200000000'),
                            ),
                            child: const Text('Hubungi Kami'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _launchUrl(
                              Uri.parse(
                                'https://www.google.com/maps/search/?api=1&query=' +
                                    Uri.encodeComponent(mapsQuery),
                              ),
                            ),
                            child: const Text('Lihat di Maps'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: theme.colorScheme.primary,
            child: const Icon(
              Icons.account_balance,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  const FacilityCard({super.key, required this.facility});
  final _Facility facility;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withAlpha(
          102,
        ), // replaced withOpacity
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ), // reduced padding
      child: Column(
        mainAxisSize: MainAxisSize.min, // add this
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            facility.icon,
            size: 24,
            color: theme.colorScheme.primary,
          ), // reduced icon size
          const SizedBox(height: 4), // reduced spacing
          Text(
            facility.label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11,
            ), // smaller text
            textAlign: TextAlign.center,
            maxLines: 1, // limit to 1 line
            overflow: TextOverflow.ellipsis, // handle text overflow
          ),
        ],
      ),
    );
  }
}

class _Facility {
  final IconData icon;
  final String label;
  const _Facility(this.icon, this.label);
}

class _GalleryCarousel extends StatefulWidget {
  const _GalleryCarousel({required this.images});
  final List<String> images;

  @override
  State<_GalleryCarousel> createState() => _GalleryCarouselState();
}

class _GalleryCarouselState extends State<_GalleryCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _index = i),
            itemCount: widget.images.length,
            itemBuilder: (context, i) {
              final url = widget.images[i];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${i + 1}/${widget.images.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (i) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == _index
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(Uri uri) async {
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } else {
      throw 'Could not launch $uri';
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}
