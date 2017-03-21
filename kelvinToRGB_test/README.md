# KelvinToRGB

![Badge Status](https://ci-as-a-service)

Util class of color translation for Processing.

you can easily translate Kelvin to RGB.

## Description

***DEMO:***

    KelvinToRGB k;

    final float MIN_K = 1096.0;
    final float MAX_K = 22026.0;
    final float INCREMENT_K = 100;

    final long UPDATE_INTERVAL = 100;

    long timer;
    float kel = MIN_K; // 1096 ~ 22026K

    void setup() {
      k = new KelvinToRGB();
    }

    void draw() {
      if (millis() - timer > UPDATE_INTERVAL) {
        k.getRGBFromKelvin(kel);

        println("K: " + (int)kel + "\tR: " + (int)k.R + "\tG: " + (int)k.G + "\tB: " + (int)k.B);
        background((int)k.R, (int)k.G, (int)k.B);

        kel += INCREMENT_K;
        if (kel > MAX_K) {
          kel = MIN_K;
        }

        timer = millis();
      }
    }


## Requirement

- Processing 3.0

## Author

[@rin1024](https://twitter.com/rin1024)

import from http://www.kaede-software.com/2008/02/post_501.html

## License

[MIT](http://b4b4r07.mit-license.org)
