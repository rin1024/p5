import oscP5.*;
import netP5.*;

class OscUtil {
  OscP5 oscP5;
  NetAddress targetLocation;
  
  String targerDomain;
  int[] oscPort;

  OscUtil(String domain, int[] port) {
    targerDomain = domain;
    
    oscPort = new int[2];
    oscPort[0] = port[0];
    oscPort[1] = port[1];
    
    try {
      oscP5 = new OscP5(this, oscPort[0]);
      targetLocation = new NetAddress(targerDomain, oscPort[1]);
    }
    catch (Exception e) {
      println("[oscP5]" + e);
    }
  }

  // データを送る[int版]
  // フォーマットは "/sensor ,iiiiiiiiii 1 100 -1 -1 -1 -1 -1 -1 -1 -1" みたいな感じ
  void sendByOSC(String address, int[] datas) {
    OscMessage msg = new OscMessage(address);
    for (int i=0; i<datas.length; i++) {
      msg.add(datas[i]);
    }
    oscP5.send(msg, targetLocation);
  }

  // データを送る[string版]
  // フォーマットは "/sensor ,iiiiiiiiii 1 100 -1 -1 -1 -1 -1 -1 -1 -1" みたいな感じ
  void sendByOSC(String address, String[] datas) {
    OscMessage msg = new OscMessage(address);
    for (int i=0; i<datas.length; i++) {
      msg.add(datas[i]);
    }
    oscP5.send(msg, targetLocation);
  }
}