String t1 = "2:35";
String t2 = "9:40";

void setup() {
   println(addTimes(t1,t2));
}

String addTimes(String a, String b) {
  //splitting into hours and minutes
   String[] t1split = a.split(":");
   String[] t2split = b.split(":");
//locating hours and minutes to their own variables
   int t1h = int(t1split[0]);
   int t2h = int(t2split[0]);
   int t1m = int(t1split[1]);
   int t2m = int(t2split[1]);
   
   int hoursum = t1h + t2h;
   int minsum = t1m + t2m;
   
   if(minsum > 60) {
     hoursum = hoursum + 1;
     minsum = minsum - 60;
   }
   
   String timesum = str(hoursum) + ":" + str(minsum);
   
   return timesum;
}
