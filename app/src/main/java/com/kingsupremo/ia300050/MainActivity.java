package com.kingsupremo.ia300050;

import android.app.*;
import android.os.*;
import android.graphics.Color;
import android.view.*;
import android.widget.*;
import org.json.*;
import java.net.*;
import java.io.*;
import java.util.concurrent.*;

public class MainActivity extends Activity {
    EditText endpoint, model, apiKey, message;
    TextView output;
    ExecutorService executor = Executors.newSingleThreadExecutor();

    public void onCreate(Bundle b) {
        super.onCreate(b);
        LinearLayout root = new LinearLayout(this);
        root.setOrientation(1);
        root.setPadding(24,24,24,24);
        root.setBackgroundColor(Color.rgb(18,18,28));

        TextView title = new TextView(this);
        title.setText("👑 KINGSUPREMO IA 300050");
        title.setTextColor(Color.WHITE);
        title.setTextSize(24);
        root.addView(title);

        endpoint = field(root, "API URL", "https://api.openai.com/v1");
        model = field(root, "Modelo", "gpt-4o-mini");
        apiKey = field(root, "Clave API", "");
        apiKey.setInputType(129);
        message = field(root, "Escribe tu mensaje", "");

        Button send = new Button(this);
        send.setText("ENVIAR MENSAJE");
        root.addView(send);

        output = new TextView(this);
        output.setTextColor(Color.WHITE);
        output.setTextSize(16);
        output.setPadding(0,24,0,0);
        root.addView(output);

        send.setOnClickListener(v -> sendMessage());
        setContentView(root);
    }

    EditText field(LinearLayout root, String hint, String value) {
        EditText e = new EditText(this);
        e.setHint(hint);
        e.setText(value);
        e.setTextColor(Color.WHITE);
        e.setHintTextColor(Color.LTGRAY);
        root.addView(e);
        return e;
    }

    void sendMessage() {
        String url = endpoint.getText().toString().trim();
        String key = apiKey.getText().toString().trim();
        String modelName = model.getText().toString().trim();
        String question = message.getText().toString().trim();

        if(key.isEmpty() || question.isEmpty()) {
            output.setText("Escribe tu mensaje y configura tu clave API.");
            return;
        }

        output.setText("KINGSUPREMO IA está pensando...");
        executor.execute(() -> {
            try {
                URL address = new URL(url.replaceAll("/+$","") + "/chat/completions");
                HttpURLConnection c = (HttpURLConnection) address.openConnection();
                c.setRequestMethod("POST");
                c.setConnectTimeout(20000);
                c.setReadTimeout(60000);
                c.setDoOutput(true);
                c.setRequestProperty("Content-Type","application/json");
                c.setRequestProperty("Authorization","Bearer " + key);

                JSONObject body = new JSONObject();
                body.put("model",modelName);
                JSONArray messages = new JSONArray();
                JSONObject user = new JSONObject();
                user.put("role","user");
                user.put("content",question);
                messages.put(user);
                body.put("messages",messages);

                try(OutputStream os = c.getOutputStream()) {
                    os.write(body.toString().getBytes("UTF-8"));
                }

                int status = c.getResponseCode();
                InputStream stream = status < 400 ? c.getInputStream() : c.getErrorStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
                StringBuilder result = new StringBuilder();
                String line;
                while((line=reader.readLine())!=null) result.append(line);
                reader.close();

                if(status >= 400) throw new Exception(result.toString());

                JSONObject response = new JSONObject(result.toString());
                String answer = response.getJSONArray("choices")
                    .getJSONObject(0).getJSONObject("message").getString("content");

                runOnUiThread(() -> output.setText(answer));
                c.disconnect();
            } catch(Exception ex) {
                runOnUiThread(() -> output.setText("Error: " + ex.getMessage()));
            }
        });
    }
}
