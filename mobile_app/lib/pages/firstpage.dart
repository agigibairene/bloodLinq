import 'package:flutter/material.dart';
import 'package:mobile_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _lift; 
  late final Animation<double> _scaleY; 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    // Rise slowly, fall faster, rest briefly on the ground.
    _lift = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 45,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 10),
    ]).animate(_controller);

    // Stretch in the air, squash on landing, then spring back.
    _scaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 45),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.82)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.82, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 5,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              _buildDroplet(),
              const SizedBox(height: 32),
              _buildTexts(),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.crimson,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // TODO: navigate to phone sign-in
                  },
                  child: const Text(
                    'Get started',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDroplet() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final lift = _lift.value; 
        final sy = _scaleY.value;
        final sx = 2 - sy; 

        return SizedBox(
          height: 260,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Transform.scale(
                scaleX: 1 + lift * 0.35,
                child: Container(
                  width: 110,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.10 + lift * 0.06),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Transform.translate(
                  offset: Offset(0, lift * 50),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.diagonal3Values(sx, sy, 1),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Image.asset(
        'assets/images/droplet.png',
        height: 180,
        width: 180,
      ),
    );
  }

  Widget _buildTexts() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOut,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, (1 - t) * 20), child: child),
      ),
      child: Column(
        children: [
          Text(
            'BloodLinq'.toUpperCase(),
            style: GoogleFonts.dynaPuff(
              textStyle: const TextStyle(
              color: AppColors.crimson,
              fontWeight: FontWeight.bold,
              fontSize: 32,
              letterSpacing: -0.5,
            ),
            )
          ),
          SizedBox(height: 12),
          Text(
            'Find blood donors near you, or help someone who needs your blood group.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 16,
              height: 1.4,
            ),
            
          ),
        ],
      ),
    );
  }
}