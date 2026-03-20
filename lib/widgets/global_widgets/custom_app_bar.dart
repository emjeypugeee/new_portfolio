import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  final Widget widget;
  const CustomAppBar({super.key, required this.widget});

  int _pathToIndex(String path) {
    switch (path) {
      case '/':
        return 0;
      case '/about':
        return 1;
      case '/project':
        return 2;
      case '/resume':
        return 3;
      default:
        return 0;
    }
  }

  void _onTabTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/about');
        break;
      case 2:
        context.go('/project');
        break;
      case 3:
        context.go('/resume');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final String currentPath = GoRouterState.of(context).uri.path;
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    final int currentIndex = _pathToIndex(currentPath);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 52,
        titleSpacing: 50,
        title: GestureDetector(
          onTap: currentPath == '/' ? null : () => context.go('/'),
          child: MouseRegion(
            cursor: currentPath == '/'
                ? SystemMouseCursors.basic
                : SystemMouseCursors.click,
            child: Text(
              'EMJEY.DEV',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: colorScheme.primary,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: colorScheme.outlineVariant),
        ),

        actions: isMobile
            ? [
                const SizedBox(width: 16),
                _hireButton(context),
                const SizedBox(width: 16),
              ]
            : [
                _navLink(
                  context,
                  'Home',
                  isActive: currentPath == '/',
                  onTap: () => context.go('/'),
                ),
                _navLink(
                  context,
                  'About',
                  isActive: currentPath == '/about',
                  onTap: () => context.go('/about'),
                ),
                _navLink(
                  context,
                  'Projects',
                  isActive: currentPath == '/project',
                  onTap: () => context.go('/project'),
                ),
                _navLink(
                  context,
                  'Resume',
                  isActive: currentPath == '/resume',
                  onTap: () => context.go('/resume'),
                ),
                const SizedBox(width: 16),
                _hireButton(context),
                const SizedBox(width: 32),
              ],
      ),

      // ── bottom nav (mobile only) ──
      bottomNavigationBar: isMobile
          ? Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (i) => _onTabTap(context, i),
                backgroundColor: colorScheme.surface,
                selectedItemColor: colorScheme.primary,
                unselectedItemColor: colorScheme.onSurfaceVariant,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType
                    .fixed, // 👈 prevents shifting animation
                selectedLabelStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person_rounded),
                    label: 'About',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.folder_outlined),
                    activeIcon: Icon(Icons.folder_rounded),
                    label: 'Projects',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.description_outlined),
                    activeIcon: Icon(Icons.description_rounded),
                    label: 'Resume',
                  ),
                ],
              ),
            )
          : null,

      body: widget,
    );
  }

  Widget _navLink(
    BuildContext context,
    String label, {
    bool isActive = false,
    void Function()? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.5,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  color: isActive
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  height: 1,
                  width: 24,
                  color: colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hireButton(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Hi There!',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: theme.scaffoldBackgroundColor,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
class _HoverableLogo extends StatefulWidget {
  final String currentPath;
  
  const _HoverableLogo({required this.currentPath});

  @override
  State<_HoverableLogo> createState() => _HoverableLogoState();
}

class _HoverableLogoState extends State<_HoverableLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHome = widget.currentPath == '/';

    return GestureDetector(
      onTap: isHome ? null : () => context.go('/'),
      child: MouseRegion(
        cursor: isHome ? SystemMouseCursors.basic : SystemMouseCursors.click,
        // Update state when mouse enters or leaves
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200), // Smooth transition
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 0.8,
            // Change the color/opacity when hovered AND not already on home
            color: (_isHovered && !isHome) 
                ? colorScheme.primary.withOpacity(0.6) 
                : colorScheme.primary,
          ),
          child: const Text('EMJEY.DEV'),
        ),
      ),
    );
  }
}