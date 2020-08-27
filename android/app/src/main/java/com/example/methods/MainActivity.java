package com.example.methods;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.json.JSONObject;

import java.util.List;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "method";
    Gson gson = new GsonBuilder().setPrettyPrinting().create();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
        new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("getadress")) {

                    String city = call.argument("city");
                    Log.i("city değeri ", String.valueOf(city), null);
                    List streets = call.argument("streets");
                    Log.i("adress değeri ", String.valueOf(streets), null);
                    //int cap= call.argument("cap");
                    Person person = new Person("mazlum","gürbüz",22);
                    Adress adress = new Adress(city,streets,9, ((List) person));
                    Log.i("sehir değeri ", String.valueOf(adress.city), null);

                    result.success(gson.toJson(adress));
                }

            }
        });
    }
    public class Adress{
        String city;
        List<String> streets;
        int cap;
        List<Person> personList;

        public Adress(String city, List<String> streets, int cap, List<Person> personList) {
            this.city = city;
            this.streets = streets;
            this.cap = cap;
            this.personList = personList;
        }
    }
    public class Person{
        String name,surname;
        int age;

        public Person(String name, String surname, int age) {
            this.name = name;
            this.surname = surname;
            this.age = age;
        }
    }
}