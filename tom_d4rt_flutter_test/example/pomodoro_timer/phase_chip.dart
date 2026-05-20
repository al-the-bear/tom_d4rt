// Notification chip that slides in from the top when a phase ends, then
// slides out again. Driven by `AnimatedSlide` + `AnimatedOpacity` so the
// implicit animations run inside the framework — no script-side ticker.
import 'package:flutter/material.dart';

class PhaseEndChip extends StatelessWidget {
  final String? message;
  final VoidCallback? onDismiss;

  const PhaseEndChip({
    super.key,
    required this.message,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final visible = message != null;
    final scheme = Theme.of(context).colorScheme;
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSlide(
        // Slides in from above (-1 = one chip-height up) to its rest
        // position (0). When the message clears, slides back up.
        offset: visible ? Offset.zero : const Offset(0, -1.4),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Material(
              elevation: 4,
              color: scheme.inverseSurface,
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: onDismiss,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications_active_outlined,
                        size: 18,
                        color: scheme.onInverseSurface,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          message ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: scheme.onInverseSurface,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: scheme.onInverseSurface.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
