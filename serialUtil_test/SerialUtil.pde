/**
 * ProcessingでArduinoのシリアルポートを使う時の便利クラス
 *
 * 「/dev/tty.usb-xxx」や「/dev/tty.SLAB-xxx」といったポートに自動的に接続する
 *
 * Arduinoからの送信データは「\n」を終端文字として判断
 * 受信データは本体の.pdeのparseSerialDataで処理
 **/
import processing.serial.*;
import processing.net.*;
import java.lang.reflect.Method;
import java.lang.reflect.InvocationTargetException;

public class SerialUtil extends PApplet  {
  PApplet parent;
  Serial serialPort;
  String targetPort;
  int baudRate;
  String messages;

  SerialUtil(PApplet _parent, String _targetPort, int _baudRate) {
    parent = _parent;
    targetPort = _targetPort;
    baudRate = _baudRate;
  }

  SerialUtil(PApplet _parent) {
    parent = _parent;
    targetPort = "";
    baudRate = 115200;
  }

  // シリアルポートを検出して接続
  boolean connectSerialPort() {
    boolean connected = false;
    
    String[] list = Serial.list();
    for (int i=0; i<list.length; i++) {
      println("[" + i + "]" + list[i]);
      if (list[i].equals(targetPort) || 
          list[i].indexOf("/dev/tty.usb") == 0 || 
          list[i].indexOf("/dev/tty.SLAB") == 0) {
        try {
          println(" => try to connect ");         

          targetPort = list[i];
          if (serialPort == null) {
            serialPort = new Serial(this, targetPort, baudRate);
          }
          connected = true;
        }
        catch (Exception e) {
          println(" => error, " + e);
        }
      }
    }
    
    return connected;
  }

  // イベントハンドラ
  void serialEvent(Serial _serialPort) {
    String str = serialPort.readString();
    if (str.equals("\r")) {
      try {
        if (messages != null && !messages.equals("")) {
          // 親クラスのparseSerialDataを叩く
          Method serialEventMethod = findCallback("parseSerialData"); 
          serialEventMethod.invoke(parent, this);
        }
        messages = "";
      }
      catch (Exception e) {
        println("[serialEvent]" + e);
      }
    }
    else if (str.equals("\n")) {
      return;
    }
    else {
      messages = messages + str;
    }
  }

  private Method findCallback(final String name) {
    try {
      return parent.getClass().getMethod(name, this.getClass());
    } 
    catch (Exception e) {
      println("[findCallback]" + e);
    }
    // Permit callback(Object) as alternative to callback(Serial).
    try {
      return parent.getClass().getMethod(name, Object.class);
    } 
    catch (Exception e) {
      println("[findCallback2]" + e);
    }
    return null;
  }
}