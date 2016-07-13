HttpUtil httpUtil;
String uri = "http://example.com/";

void setup() {
  httpUtil = new HttpUtil();
}

void draw() {
}

void mouseClicked() {
  //testJsonObject();
  testParams();
}

// JsonObjectの送信テスト
void testJsonObject() {
  // 配列も送れる
  JSONArray datas = new JSONArray();
  JSONObject sensorVals = new JSONObject();
  sensorVals.setInt("type", 1);
  sensorVals.setInt("val", 100);
  sensorVals.setString("created_at", millis() + "");
  datas.setJSONObject(datas.size(), sensorVals);

  // 送信するJSONObject
  JSONObject json = new JSONObject();
  json.setInt("id", 100);
  json.setJSONArray("data", datas);
  json.setString("created_at", millis() + "ms");

  String res = httpUtil.postHttpRequest(uri, json);
  println("[HTTP Request Response]" + res);
}

// HashMapの送信テスト
void testParams() {
  HashMap<String,String> params = new HashMap<String,String>();
  
  params.put("id", "1000");
  params.put("name", "rin1024");

  String res = httpUtil.postHttpRequest(uri, params);
  println("[HTTP Request Response]" + res);
}