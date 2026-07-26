import 'package:flame/components.dart';
import 'dart:ui';

class Player extends PositionComponent {
  static const double playerWidth = 40;
  static const double playerHeight = 60;

  Player({required Vector2 position})
      : super(
          position: position,
          size: Vector2(playerWidth, playerHeight),
          anchor: Anchor.center,
        );

  void move(double deltaX) {
    position.x += deltaX;
  }

  bool isCollidingWith(dynamic other) {
    if (other == null) return false;

    final myLeft = position.x - playerWidth / 2;
    final myRight = position.x + playerWidth / 2;
    final myTop = position.y - playerHeight / 2;
    final myBottom = position.y + playerHeight / 2;

    final otherLeft = other.position.x;
    final otherRight = other.position.x + other.size.x;
    final otherTop = other.position.y;
    final otherBottom = other.position.y + other.size.y;

    return myLeft < otherRight &&
        myRight > otherLeft &&
        myTop < otherBottom &&
        myBottom > otherTop;
  }

  @override
  void render(Canvas canvas) {
    // Body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-playerWidth / 2, -playerHeight / 2, playerWidth, playerHeight),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0xFF42A5F5),
    );

    // Head
    canvas.drawCircle(
      const Offset(0, -playerHeight / 2 - 10),
      12,
      Paint()..color = const Color(0xFFFFCC80),
    );

    // Eyes
    canvas.drawCircle(
      const Offset(-4, -playerHeight / 2 - 13),
      2,
      Paint()..color = const Color(0xFF212121),
    );
    canvas.drawCircle(
      const Offset(4, -playerHeight / 2 - 13),
      2,
      Paint()..color = const Color(0xFF212121),
    );
  }
}
