# KelvinToRGB

![KelvinToRGB](https://raw.githubusercontent.com/rin1024/p5/master/kelvinToRGB_test/demo.gif)

Util class of color translation for Processing.

you can easily translate Kelvin to RGB.

## Description

***DEMO:***

    KelvinToRGB k;

    void setup() {
      size(320, 240);

      k = new KelvinToRGB();
    }

    void draw() {
      float kel = 1096.0; // 1096 ~ 22026K
      k.getRGBFromKelvin(kel);
      background((int)k.R, (int)k.G, (int)k.B);

      fill(0);
      text("K: " + (int)kel + "K\tR: " + (int)k.R + "\tG: " + (int)k.G + "\tB: " + (int)k.B, 10, height - 20, width, height);
    }


## Requirement

- Processing 3.0

## Author

[@rin1024](https://twitter.com/rin1024)

import from http://www.kaede-software.com/2008/02/post_501.html

## License

[MIT](http://b4b4r07.mit-license.org)
