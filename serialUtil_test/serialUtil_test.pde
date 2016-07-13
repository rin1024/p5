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