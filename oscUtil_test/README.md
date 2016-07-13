# SerialUtil

![Badge Status](https://ci-as-a-service)

Serial Utility class files for Processing

## Description

***DEMO:***

    OscUtil oscUtil;

    void setup() {
      // {自分のポート、送信先のポート}
      int[] port = {8001, 8000};
      // 自分のIPアドレス
      oscUtil = new OscUtil("127.0.0.1", port);
    }

    void draw() {
    }

    void mouseClicked() {
      sendStringDataTest();
      //sendIntDataTest();
    }

    void sendStringDataTest() {
      String address = "/msg";
      String[] datas = {"hoge", "fuga", "piyo"};

      println("[sendStringDataTest]");
      oscUtil.sendByOSC(address, datas);
    }

    void sendIntDataTest() {
      String address = "/msg";
      int[] datas = {100,200,300,400,500,600};

      println("[sendIntDataTest]");
      oscUtil.sendByOSC(address, datas);
    }


## Requirement

- Processing 3.0
- oscP5.jar

## Author

[@rin1024](https://twitter.com/rin1024)

## License

[MIT](http://b4b4r07.mit-license.org)
