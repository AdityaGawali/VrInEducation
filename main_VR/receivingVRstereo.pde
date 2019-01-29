import processing.vr.*;
import ketai.sensors.*;
import com.pubnub.api.builder.dto.*;
import com.pubnub.api.builder.*;
import com.pubnub.api.callbacks.*;
import com.pubnub.api.endpoints.access.*;
import com.pubnub.api.endpoints.channel_groups.*;
import com.pubnub.api.endpoints.*;
import com.pubnub.api.endpoints.presence.*;
import com.pubnub.api.endpoints.pubsub.*;
import com.pubnub.api.endpoints.push.*;
import com.pubnub.api.endpoints.vendor.*;
import com.pubnub.api.enums.*;
import com.pubnub.api.interceptors.*;
import com.pubnub.api.managers.*;
import com.pubnub.api.models.consumer.access_manager.*;
import com.pubnub.api.models.consumer.channel_group.*;
import com.pubnub.api.models.consumer.history.*;
import com.pubnub.api.models.consumer.*;
import com.pubnub.api.models.consumer.presence.*;
import com.pubnub.api.models.consumer.pubsub.*;
import com.pubnub.api.models.consumer.push.*;
import com.pubnub.api.models.server.access_manager.*;
import com.pubnub.api.models.server.*;
import com.pubnub.api.models.server.presence.*;
import com.pubnub.api.models.*;
import com.pubnub.api.*;
import com.pubnub.api.vendor.*;
import com.pubnub.api.workers.*;
import retrofit2.*;
import retrofit2.http.*;
import okhttp3.logging.*;
import org.slf4j.event.*;
import org.slf4j.helpers.*;
import org.slf4j.*;
import org.slf4j.spi.*;
import com.google.gson.annotations.*;
import com.google.gson.*;
import com.google.gson.internal.*;
import com.google.gson.internal.bind.*;
import com.google.gson.internal.bind.util.*;
import com.google.gson.reflect.*;
import com.google.gson.stream.*;
import retrofit2.converter.gson.*;
import lombok.*;
import lombok.delombok.ant.*;
import lombok.experimental.*;
import lombok.extern.apachecommons.*;
import lombok.extern.java.*;
import lombok.extern.jbosslog.*;
import lombok.extern.log4j.*;
import lombok.extern.slf4j.*;
import lombok.javac.apt.*;
import lombok.launch.*;
import okhttp3.*;
import okhttp3.internal.cache.*;
import okhttp3.internal.cache2.*;
import okhttp3.internal.connection.*;
import okhttp3.internal.http.*;
import okhttp3.internal.http1.*;
import okhttp3.internal.http2.*;
import okhttp3.internal.*;
import okhttp3.internal.io.*;
import okhttp3.internal.platform.*;
import okhttp3.internal.tls.*;
import okhttp3.internal.ws.*;
import okio.*;
import java.util.Arrays;
import processing.opengl.*;


KetaiSensor sensor;
PubNub pubnub;
//PeasyCam cam;
float accelerometerX, accelerometerY, accelerometerZ, rotx;
String points[];
ArrayList<Point> pts = new ArrayList<Point>();
float recievedX, recievedY, recievedZ, px, py, pz;
int count=0;
Point currentPoint;
Point previousPoint = new Point(0,0,0);
void setup()
{

   //size(700,700,P3D);
  fullScreen(PVR.STEREO);
  // fullScreen(P3D);
  //cam=new PeasyCam(this,500);
  sensor = new KetaiSensor(this);
  sensor.start();
  //cam=new PeasyCam(this,500);


  PNConfiguration pnConfiguration = new PNConfiguration();
  pnConfiguration.setSubscribeKey("demo");
  pnConfiguration.setPublishKey("demo");

  pubnub = new PubNub(pnConfiguration);

  pubnub.addListener(new SubscribeCallback() {
    //long previous_time=0;
    @Override
      public void status(PubNub pubnub, PNStatus status) {
    }
    public void message(PubNub pubnub, PNMessageResult message) {
      // Handle new message stored in message.message
      if (message.getChannel() != null) {
        // Message has been received on channel group stored in
        // message.getChannel()
        long current_time =message.getTimetoken();
        String msg = message.getMessage().toString();
        msg = msg.substring(1, msg.length()-1);
        points = msg.split(",");
        recievedX = Float.parseFloat(points[0]);
        recievedY = Float.parseFloat(points[1]);
        recievedZ=Float.parseFloat(points[2]);
        currentPoint=new Point(recievedX, recievedY, recievedZ);
        count=count+1;
        if(count==1)
        {
          previousPoint=currentPoint;
        }
        pts.add(currentPoint);
        //println("X: "+ recievedX + " Y: " + recievedY);
        //previous_time=message.getTimetoken();
      } else {
        // Message has been received on channel stored in
        // message.getSubscription()
        //println(message.getSubscription());
      }
    }
    @Override
      public void presence(PubNub pubnub, PNPresenceEventResult presence) {
    }
  }
  );
  pubnub.subscribe()
    .channels(Arrays.asList("my_channel")) // subscribe to channels
    .execute();

  translate(-width/2, -height/2);
}
void draw()
{
  background(200);
  rotx=map(accelerometerX, -10, 10, 0, 2);
  //translate(width/2,height/2);
  rotateY(PI/rotx);

        if(pts.size()!=0)
        {
          previousPoint=pts.get(0);
        }
        
  for (int i = 0; i< pts.size(); i++)
  {
    Point curr_pt = pts.get(i);

    curr_pt.display();
    curr_pt.drawLine(previousPoint);
    previousPoint = curr_pt;
  }
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}