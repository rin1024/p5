/**
 * 色温度からRGBに変換するプログラム
 * 元ソース : http://www.kaede-software.com/2008/02/post_501.html
 */
KelvinToRGB k;

final float MIN_K = 1096.0;
final float MAX_K = 10000.0; //22026.0;
final float INCREMENT_K = 100;

final long UPDATE_INTERVAL = 100;

long timer;
float kel = MIN_K; // 1096 ~ 22026K

void setup() {
  size(320, 240);
  
  k = new KelvinToRGB();
}

void draw() {
  if (millis() - timer > UPDATE_INTERVAL) {
    k.getRGBFromKelvin(kel);

    background((int)k.R, (int)k.G, (int)k.B);

    fill(0);
    text("K: " + (int)kel + "K\tR: " + (int)k.R + "\tG: " + (int)k.G + "\tB: " + (int)k.B, 10, height - 20, width, height);

    kel += INCREMENT_K;
    if (kel > MAX_K) {
      kel = MIN_K;
    }

    timer = millis();
  }
}