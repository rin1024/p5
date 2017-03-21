/**
 * 色温度からRGBに変換するクラス
 **/
class RColor {
  float  R, G, B;
  float  Y, x, y;
}

public class KelvinToRGB  {
  float kelvin;
  float R, G, B;

  KelvinToRGB() {

  }

  /**
   * 色温度をRGBに変換
   * 基本的にはこの関数を叩くだけでok
   */
  void getRGBFromKelvin(float _kelvin) {
    float x = this.KelvinToX(_kelvin);
    float y = this.XToY(x);

    // 色温度をYxy座標に変換
    RColor Yxy = new RColor();
    Yxy.Y = 1.0; // 輝度は1.0に固定
    Yxy.x = x;
    Yxy.y = y;

    // Yxy座標をRGBに変換
    RColor rgb = new RColor();
    this.YxyToRGB(Yxy, rgb);

    rgb.R = max(min(1.0, rgb.R), 0.0);
    rgb.G = max(min(1.0, rgb.G), 0.0);
    rgb.B = max(min(1.0, rgb.B), 0.0);

    this.kelvin = _kelvin;
    this.R = rgb.R * 255;
    this.G = rgb.G * 255;
    this.B = rgb.B * 255;
  }

  // ケルビンの自然対数値からx座標に変換する
  float KelvinLnToX(float _x) {
    return(-0.0108*_x*_x*_x + 0.3407*_x*_x - 3.5987*_x + 12.929);
  }

  // ケルビンからx座標に変換する
  float KelvinToX(float _K) {
    return this.KelvinLnToX(log(_K));
  }

  // x座標からy座標を求める
  float XToY(float _X) {
    return -2.700931324 * _X * _X + 2.675633166 * _X - 0.250545382;
  }

  // @param K : ケルビン
  // @param Y : 輝度 - 0.0 ～ 1.0
  // @return RGB24値 - 0x00RRGGBB
  long GetColor(float _K, float _Y) {
    RColor Yxy = new RColor();
    Yxy.Y = _Y;
    Yxy.x = this.KelvinToX(_K);
    Yxy.y = this.XToY(Yxy.x);
    return this.YxyToRGB32(Yxy);
  }

  // @param K : ケルビンの自然対数値
  // @param Y : 輝度 - 0.0 ～ 1.0
  // @return RGB24値 - 0x00RRGGBB
  long GetColorLn(float _K, float _Y) {
    RColor Yxy = new RColor();
    Yxy.Y = _Y;
    Yxy.x = this.KelvinLnToX(_K);
    Yxy.y = this.XToY(Yxy.x);
    return this.YxyToRGB32(Yxy);
  }

  // 色変換
  // RGB -> Yxy
  void RGBToYxy(RColor _rgb, RColor _Yxy) {
    float X = 0.412453 * _rgb.R + 0.35758 * _rgb.G + 0.180423 * _rgb.B;
    _Yxy.Y   = 0.212671 * _rgb.R + 0.71516 * _rgb.G + 0.072169 * _rgb.B;
    float Z = 0.019334 * _rgb.R + 0.119193 * _rgb.G + 0.950227 * _rgb.B;
    _Yxy.x = X / (X + _Yxy.Y + Z);
    _Yxy.y = _Yxy.Y / (X + _Yxy.Y + Z);
  }

  // Yxy -> RGB
  void YxyToRGB(RColor _Yxy, RColor _rgb) {
    float X = _Yxy.x / _Yxy.y * _Yxy.Y;
    float Z = (1.0 - _Yxy.x - _Yxy.y) / _Yxy.y * _Yxy.Y;
    _rgb.R = 3.240479 * X - 1.53715 * _Yxy.Y - 0.498535 * Z;
    _rgb.G = -0.969256 * X + 1.875991 * _Yxy.Y + 0.041556 * Z;
    _rgb.B = 0.055648 * X - 0.204043 * _Yxy.Y + 1.057311 * Z;
  }

  // Yxy -> RGB24 (0x00RRGGBB)
  long YxyToRGB32(RColor _Yxy) {
    RColor rgb = new RColor();
    this.YxyToRGB(_Yxy, rgb);

    // 各値を0 - 255にする
    int _r = (int)(rgb.R * 255);
    int _g =(int) (rgb.G * 255);
    int _b =(int)(rgb.B * 255);

    _r = max(min(255, _r), 0);
    _g = max(min(255, _g), 0);
    _b = max(min(255, _b), 0);

    return ((_r << 16) | (_g << 8) | _b);
  }
}
