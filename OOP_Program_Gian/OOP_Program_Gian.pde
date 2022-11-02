//Hunger Games Simulation

//Variables
ArrayList<Tribute> TributeList = new ArrayList<Tribute>();
ArrayList<Tribute> OffToCornucopia = new ArrayList<Tribute>();
ArrayList<Weapon> AvailableWeaponList = new ArrayList<Weapon>();

String[] mildmishaps = {"being stung by a bee", "food poisoning", "stepping on legos", "getting their favourite movie/show spoiled", "slipping on ice", "eating the wrong berries"};
String[] severemishaps = {"being caught in an avalanche", "being caught playing on their phone by Mr. Schattman", "being chased by a pack of wild animals", "being zapped by the forcefield", "inhaling deadly toxins"};
//Executables
void setup() {
  
  //Generating Tributes - you can remove/add here! fields are: Name, District(One per), Training Received (Either RANGE or MELEE), Athleticis,(1-3)
  Tribute gian = new Tribute("Gian", 1, "RANGE", 3);
  Tribute justin = new Tribute("Justin", 2, "MELEE", 2);
  Tribute wali = new Tribute("Wali", 3, "RANGE", 1);
  Tribute joey = new Tribute("Joey", 4, "MELEE", 3);
  Tribute siting = new Tribute("Siting", 5, "RANGE", 2);
  Tribute andrew = new Tribute("Andrew", 6, "MELEE", 3);
  Tribute frank = new Tribute("Frank", 7, "RANGE", 2);
  Tribute david = new Tribute("David", 8, "MELEE", 1);
  Tribute daniel = new Tribute("Daniel", 9, "RANGE", 3);
  Tribute xiang = new Tribute("Xiang", 10, "MELEE", 1);
  Tribute yina = new Tribute("Yina", 11, "RANGE", 2);
  Tribute tian = new Tribute("Tian", 12, "MELEE", 1);
  
  //Generating Weapons - you can add here! fields are: Name, Type(All Caps), Damage (1-3)
  Weapon sword = new Weapon("Sword", "MELEE", 3);
  Weapon axe = new Weapon("Hammer", "MELEE", 3);
  Weapon bow = new Weapon("Bow", "RANGE", 3);
  Weapon slingshot = new Weapon("Slingshot", "RANGE", 2);
  Weapon dadjoke = new Weapon("Dad Jokes", "RANGE", 3);
  Weapon crossbow = new Weapon("CrossBow", "RANGE", 3);
  Weapon taser = new Weapon("Taser", "MELEE", 1);
  Weapon pepperspray = new Weapon("Pepper Spray", "RANGE", 1);
  Weapon bat = new Weapon("Baseball Bat", "MELEE", 2);
  Weapon nunchucks = new Weapon("Nunchucks", "MELEE", 3);
  Weapon rubberbands = new Weapon("Rubber Bands", "RANGE", 2);
  
  //Running Hunger Games
  println("{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}");
  println("|                     Welcome To The 2021 Annual Panem Hunger Games!                   |");
  println("|Today, we have 12 brave tributes from Mr. Schattman's Grade 12 Computer Science Class.|");
  println("|                 Here is some info on each tribute before the games begin.            |");
  println("{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}");
  
  gian.TributeInfo();
  justin.TributeInfo();
  wali.TributeInfo();
  joey.TributeInfo();
  siting.TributeInfo();
  andrew.TributeInfo();
  frank.TributeInfo();
  david.TributeInfo();
  daniel.TributeInfo();
  xiang.TributeInfo();
  yina.TributeInfo();
  tian.TributeInfo();
  
  println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  println("\nThat's it for introductions! Our contestants are entering the arena!");
  println("\nBeginning Countdown.");
  println("\nRemember tributes, to deter you from stepping off your platform before the countdown ends, we have placed landmines around you. They will be deactivated once this countdown is over.");
  println("I assure you, failing to be patient will result in an instant transformation to ketchup.\n");
  println("50... 49... 48...");
  println("\n...\n");
  println("3... 2... 1...");
  println("*siren blares* BEGIN!\n");
  
  //Determine which type of start each person gets (go to Cornucopia or Wild)
  for(int i = 0; i < TributeList.size(); i++) {
    int choiceStart = round(random(0,1));
    if(choiceStart == 1) {
      TributeList.get(i).StartCornucopia();
    }
    else{
      TributeList.get(i).StartWild();
    }
  }
  
  print("\n");
  
  //Giving weapons to those who go to Cornucopia
  for(int i = 0; i < OffToCornucopia.size(); i++) {
    if(AvailableWeaponList.size() > 0){
      OffToCornucopia.get(i).ClaimWeapon();
    }
  }
  
  print("\n");
  
  //Determine cornucopia instances
  while(OffToCornucopia.size() != 0) {
    for(int i = 0; i < OffToCornucopia.size(); i++){
      print("\n");
      if(OffToCornucopia.size() == 1){
        println("Tribute " + OffToCornucopia.get(i).name + " has exited the Cornucopia");
        OffToCornucopia.remove(OffToCornucopia.get(i));
      }
      else{
        int type = GenerateInstanceType(2); //1 = Tribute Encounter 2 = Run off
        if(type == 1) {
          int cornmatchup = i;
          while(cornmatchup == i){
            cornmatchup = round(random(0, ((OffToCornucopia.size())-1)));
          }
          println("District " + OffToCornucopia.get(i).district + " Tribute " + OffToCornucopia.get(i).name + " has encountered District " + OffToCornucopia.get(cornmatchup).district + " Tribute " + OffToCornucopia.get(cornmatchup).name + "!");
          OffToCornucopia.get(i).Fight(OffToCornucopia.get(cornmatchup));
        }
        else{
          println("Tribute " + OffToCornucopia.get(i).name + " has exited the Cornucopia");
          OffToCornucopia.remove(OffToCornucopia.get(i));
        }
      }
    }
  }
  
  println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  println("*ALL PARTICIPANTS HAVE DEPARTED TO THE WILD*");
  println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
  //println(TributeList.size());
  
  //Determines instances for rest of game
  while(TributeList.size() > 1) {
    for(int i = 0; i < TributeList.size(); i++) {
      GenerateInstance(TributeList.get(i));
      print("\n");
    }
  }
  
  if(TributeList.size() == 1){
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    println("District " + TributeList.get(0).district + " Tribute " + TributeList.get(0).name + " is the official winner of the 2021 Panem Hunger Games!");
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }
  else{
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    println("This year's official Panem Hunger Games has ended without a victor. How boring.");
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }
  
  //printArray(AvailableWeaponList.toArray());
}

int GenerateInstanceType(int limit){
  return round(random(1,limit));
}

void GenerateInstance(Tribute t){
  int type = GenerateInstanceType(2);
  if(type == 1) { //fight
    Tribute matchup = TributeList.get(round(random(0, ((TributeList.size())-1))));
    while(t == matchup){
      matchup = TributeList.get(round(random(0, ((TributeList.size())-1))));
    }
    println("District " + t.district + " Tribute " + t.name + " has encountered District " + matchup.district + " Tribute " + matchup.name + "!");
    t.Fight(matchup);
  }
  else{ //random event
  int type2 = GenerateInstanceType(2);
    if(type2 == 1){//Good Events
      int typege = GenerateInstanceType(2);
      if(typege == 1){//Sponsor
        println("District " + t.district + " Tribute " + t.name + " has been sponsored by their District and has recieved survival essentials.");
        int healthgain = round(random(1,3));
        t.health = t.health + healthgain;
        println("Tribute " + t.name + " has gained " + healthgain + " extra health, making their total health " + t.health + ".");
      }
      else{//Weapon Discovery
        if(AvailableWeaponList.size() > 0){
          int randomweapon = round(random(0,(((AvailableWeaponList.size())-1))));
          if(t.weapon == null){
            println("District " + t.district + " Tribute " + t.name + " has discovered a " + AvailableWeaponList.get(randomweapon).name + " in the wild! They have decided to use it.");
            t.weapon = AvailableWeaponList.get(randomweapon);
            AvailableWeaponList.remove(AvailableWeaponList.get(randomweapon));
            t.weapon.owner = t;
          }
          else{
            if(t.CheckAttack(t.weapon) < t.CheckAttack(AvailableWeaponList.get(randomweapon))){
              println("District " + t.district + " Tribute " + t.name + " has discovered a " + AvailableWeaponList.get(randomweapon).name + " in the wild! " + t.name + " has discarded their " + t.weapon.name + " in exchange for the " + AvailableWeaponList.get(randomweapon).name + "!");
              t.weapon.owner = null;
              t.weapon = AvailableWeaponList.get(randomweapon);
              AvailableWeaponList.remove(AvailableWeaponList.get(randomweapon));
              t.weapon.owner = t;
            }
          }
        }
      }
    }
    else{//Bad Events
    int typebe = GenerateInstanceType(2);
      if(typebe == 1){
        int mildevent = round(random(0,(mildmishaps.length-1)));
        int healthloss = round(random(1,3));
        
        t.health = t.health - healthloss;
        
        t.IsAlive();
    
        if(t.alive == false){
          println("*BOOM* A cannon fires off in the distance...");
          println("District " + t.district + " Tribute " + t.name + " has died as a result of " + mildmishaps[mildevent] + ".");
          t.Erase();
        }
        else{
          println("District " + t.district + " Tribute " + t.name + " has survived " + mildmishaps[mildevent] + " with " + t.health + " health. They lost " + healthloss + " health.");
        }
      }
      else{
        int severeevent = round(random(0,(severemishaps.length-1)));
        int healthloss = round(random(4,7));
        t.health = t.health - healthloss;
        
        t.IsAlive();
    
        if(t.alive == false){
          println("*BOOM* A cannon fires off in the distance...");
          println("District " + t.district + " Tribute " + t.name + " has died as a result of " + severemishaps[severeevent] + ".");
          t.Erase();
        }
        else{
          println("District " + t.district + " Tribute " + t.name + " has survived " + severemishaps[severeevent] + " with " + t.health + " health. They lost " + healthloss + " health.");
        }
      }
    }
  }
}
