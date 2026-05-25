import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'obstacle.dart';
import 'coin.dart';

class SubwaySurfersGame extends FlameGame {
  late Player player;
  late List<Obstacle> obstacles;
  late List<Coin> coins;
  
  int score = 0;
  int coinsCollected = 0;
  bool gameOver = false;
  double spawnRate = 0.02;
  double gameSpeed = 200;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    camera.viewfinder.position = size / 2;
    
    player = Player(position: Vector2(size.x / 2, size.y - 100));
    add(player);
    
    obstacles = [];
    coins = [];
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (gameOver) return;
    
    score += (dt * 10).toInt();
    
    if (random.nextDouble() < spawnRate) {
      spawnObstacle();
    }
    
    if (random.nextDouble() < spawnRate * 0.5) {
      spawnCoin();
    }
    
    for (int i = obstacles.length - 1; i >= 0; i--) {
      obstacles[i].position.y += gameSpeed * dt;
      
      if (obstacles[i].isCollidingWith(player)) {
        endGame();
      }
      
      if (obstacles[i].position.y > size.y) {
        remove(obstacles[i]);
        obstacles.removeAt(i);
      }
    }
    
    for (int i = coins.length - 1; i >= 0; i--) {
      coins[i].position.y += gameSpeed * dt;
      
      if (coins[i].isCollidingWith(player)) {
        coinsCollected++;
        score += 50;
        remove(coins[i]);
        coins.removeAt(i);
      }
      
      if (coins[i].position.y > size.y) {
        remove(coins[i]);
        coins.removeAt(i);
      }
    }
    
    if (score > 0 && score % 1000 == 0) {
      gameSpeed += 10;
      spawnRate += 0.001;
    }
  }

  void spawnObstacle() {
    final randomLane = random.nextInt(3);
    final x = 50.0 + (randomLane * (size.x / 3));
    
    final obstacle = Obstacle(position: Vector2(x, -50));
    add(obstacle);
    obstacles.add(obstacle);
  }

  void spawnCoin() {
    final randomLane = random.nextInt(3);
    final x = 50.0 + (randomLane * (size.x / 3));
    
    final coin = Coin(position: Vector2(x, -50));
    add(coin);
    coins.add(coin);
  }

  void endGame() {
    gameOver = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    player.move(event.delta.x);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final textPaint = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
    
    textPaint.render(
      canvas,
      'Score: $score',
      Vector2(20, 20),
    );
    
    textPaint.render(
      canvas,
      'Coins: $coinsCollected',
      Vector2(20, 60),
    );
    
    if (gameOver) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y),
        Paint()..color = Colors.black.withOpacity(0.5),
      );
      
      final gameOverPaint = TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      );
      
      gameOverPaint.render(
        canvas,
        'GAME OVER',
        Vector2(size.x / 2 - 120, size.y / 2 - 50),
      );
      
      final scoreTextPaint = TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
      );
      
      scoreTextPaint.render(
        canvas,
        'Final Score: $score',
        Vector2(size.x / 2 - 100, size.y / 2 + 20),
      );
    }
  }
}
