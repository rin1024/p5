/**
  * POST形式でJsonをBodyに入れてHTTPリクエストするときの便利クラス
  *
  * commons-logging-1.2.jar, httpclient-4.5.2.jar, httpcore-4.4.4.jar, httpmime-4.5.2.jarが必要な様子
  **/
import org.apache.http.HttpEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import java.nio.charset.StandardCharsets;

class HttpUtil {
  HttpUtil() {
  }

  // JSONObjectをPOST
  String postHttpRequest(String url, JSONObject json) {
    String result = "";
    try {
      StringEntity sentity = new StringEntity(json.toString());
      sentity.setContentType("application/json");
      result = postHttpRequest(url, sentity);
    }
    catch(Exception e) {
      println("[postHttpRequest]" + e);
    }
    return result;
  }

  // paramsをPOST
  String postHttpRequest(String url, HashMap<String,String> params) {
    String result = "";
    try {
      MultipartEntity mentity = new MultipartEntity();
      for ( String key : params.keySet() ) {
        String v = params.get( key );
        mentity.addPart(key, new StringBody(v));
      }
      result = postHttpRequest(url, mentity);
    }
    catch(Exception e) {
      println("[postHttpRequest]" + e);
    }
    return result;
  }

  // post
  String postHttpRequest(String url, HttpEntity entity) {
    String body = "";
    try {
      DefaultHttpClient httpClient = new DefaultHttpClient();
      HttpPost  httpPost  = new HttpPost(url);
      httpPost.setEntity(entity);
      // 送信内容をダンプ
      //println(EntityUtils.toString(entity));

      HttpResponse response = httpClient.execute(httpPost);
      // ステータスコードを取得
      //println(response.getStatusLine());

      HttpEntity rentity = response.getEntity();
      if ( rentity != null ) {
        body = EntityUtils.toString(rentity, StandardCharsets.UTF_8);
        rentity.consumeContent();
      }

      httpClient.getConnectionManager().shutdown();
    }
    catch(Exception e) {
      println("[postHttpRequest]" + e);
    }

    return body;
  }
}
