/**
 * ProcessingでOSCを使う時の便利クラス
 *
 * oscP5.jarが必要な様子
 **/
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