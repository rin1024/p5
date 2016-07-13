# SerialUtil

![Badge Status](https://ci-as-a-service)

Serial Utility class files for Processing

## Description

***DEMO:***

    SerialUtil serialUtil;

    boolean connected = false;

    void setup() {
      serialUtil = new SerialUtil(this);
    }

    void draw() {
    }

    void mouseClicked() {
      if (connected == false) {
        connected = serialUtil.connectSerialPort();
      }
    }

    /**
      * シリアルデータ受信時のイベントハンドラ(serialEvent代わり)
      * 区切り文字はTab(\t)を使っている
      */
    void parseSerialData(SerialUtil s) {
      try {
        String[] serialDatas = s.messages.split("\t");
        for (int i = 0; i < serialDatas.length; i++) {
          if (serialDatas[i] == null) {
            continue;
          }
          try {
            //int val = Integer.parseInt(serialDatas[i]);
            String val = serialDatas[i];
            println("[" + i + "]" + val);
          }
          catch (Exception e2) {
            println("[parseSerialData][" + i + "]" + e2);
          }
        }
      }
      catch (Exception e) {
        println("[parseData]" + e);
      }
    }


## Requirement

- Processing 3.0

## Author

[@rin1024](https://twitter.com/rin1024)

## License

[MIT](http://b4b4r07.mit-license.org)
