import 'package:flutter/material.dart'; // Make sure this is imported for the animations
import 'package:go_router/go_router.dart';
import 'package:portfolio_v2/pages/about_page.dart';
import 'package:portfolio_v2/pages/home_page.dart';
import 'package:portfolio_v2/pages/project_page.dart';
import 'package:portfolio_v2/pages/resume_page.dart';
import 'package:portfolio_v2/widgets/global_widgets/custom_app_bar.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => CustomAppBar(widget: child), 
        routes: [
          GoRoute(
            path: '/', 
            pageBuilder: (context, state) => _buildSlideTransition(state, const HomePage()),
          ),
          GoRoute(
            path: '/about', 
            pageBuilder: (context, state) => _buildSlideTransition(state, const AboutPage()),
          ),
          GoRoute(
            path: '/project', 
            pageBuilder: (context, state) => _buildSlideTransition(state, const ProjectPage()),
          ),
          GoRoute(
            path: '/resume', 
            pageBuilder: (context, state) => _buildSlideTransition(state, const ResumePage()),
          ),
        ]
      )
    ],
  );

 // --- Helper Method for the Slide Transition ---
  // --- Helper Method for a Clean Slide & Fade Transition ---
  static CustomTransitionPage _buildSlideTransition(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      // Slightly increased duration makes the combination look much smoother
      transitionDuration: const Duration(milliseconds: 400), 
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        
        const curve = Curves.easeOutCubic;

        // 1. Slide animation for the new page coming in
        var slideTween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: curve));
            
        // 2. Fade animation for the new page coming in
        var fadeInTween = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve));
            
        // 3. Fade animation for the old page going out (secondaryAnimation)
        var fadeOutTween = Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: curve));

        return FadeTransition(
          // Fades OUT the previous page
          opacity: fadeOutTween.animate(secondaryAnimation),
          child: SlideTransition(
            // Slides IN the new page
            position: slideTween.animate(animation),
            child: FadeTransition(
              // Fades IN the new page
              opacity: fadeInTween.animate(animation),
              child: child,
            ),
          ),
        );
      },
    );
  }
}