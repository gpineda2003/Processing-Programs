class Tribute{
  //Predetermined
  String name;
  int district;
  boolean alive;
  String training;
  int athleticism;
  
  //To Be Determined
  int health;
  int attack;
  Weapon weapon;
  Tribute lastmatchup;
  
  Tribute(String n, int d, String t, int a){
    this.name = n;
    this.district = d;
    this.alive = true;
    this.training = t;
    this.athleticism = a;
    TributeList.add(this);
    
    this.health = round(random(1,7)) + this.athleticism;
    this.attack = 1;
  }
  
  void TributeInfo(){
    print("\n");
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    println("Introducing District " + this.district + " Tribute: " + this.name);
    this.TributeDistrict();
    println("Over the two week training period, " + this.name + " has developed a natural affinity for " + this.training + " weapons.");
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }
  
  void TributeDistrict(){
    if (this.district == 1) {
      println("District 1 is home to the wealthiest citizens of Panem, mostly known for their fine abilites to create jewellery.");
    }
    else if (this.district == 2){
      println("District 2 is known for their fine masonry and weapon manufacturing ability.");
    }
    else if (this.district == 3){
      println("District 3 is in charge of creating most of Panem's technology. They specialize in televisions and computers. ");
    }
    else if (this.district == 4){
      println("District 4 is maintains the fishing industry. They are also known for having the most attractive tributes.");
    }
    else if (this.district == 5){
      println("District 5 powers all of Panem using its very large hydroelectric dam.");
    }
    else if (this.district == 6){
      println("District 6 is Panem's transportation hub, they abilites to create cars, planes, and boats exceed all other.");
    }
    else if (this.district == 7){
      println("District 7 supplies Panem with lumber. Watch out! This tribute might chop you with an axe!");
    }
    else if (this.district == 8){
      println("District 8 is in charge of textile production. They also produce the uniforms of our country's Peacekeepers.");
    }
    else if (this.district == 9){
      println("District 9 is the head of grain production. Not much is known about this district's victors.");
    }
    else if (this.district == 10){
      println("District 10 runs our livestock industry. Be careful not to get butchered by this tribute!");
    }
    else if (this.district == 11){
      println("District 11 known for agriculture. Their land is covered in orchards, crop fields, and cattle farms.");
    }
    else if (this.district == 12){
      println("District 12 is our smallest and poorest district. They are in charge of coal mining. I don't expect this tribute to be the next Katniss Everdeen.");
    }
  }
  
  void StartCornucopia(){
    println("*Tribute " + this.name + " of District " + this.district + " charges towards the cornucopia in search of weapons/supplies!");
    OffToCornucopia.add(this);
  }
  
  void StartWild(){
    println("*Tribute " + this.name + " of District " + this.district + " flees off to the wild to dodge the early battle!");
  }
  
  void ClaimWeapon(){
    int claim = round(random(0,(((AvailableWeaponList.size())-1))));
    this.weapon = AvailableWeaponList.get(claim);
    AvailableWeaponList.remove(AvailableWeaponList.get(claim));
    this.weapon.owner = this;
    
    this.attack = this.CheckAttack(this.weapon);
    
    println("District " + this.district + " Tribute " + this.name + " has claimed a " + this.weapon.type + " weapon - " + this.weapon.name);
  }
  
  void Fight(Tribute other){
    lastmatchup = other;
    other.lastmatchup = this;
    this.health = this.health - other.attack;
    other.health = other.health - this.attack;
    
    this.IsAlive();
    other.IsAlive();
    
    if(this.alive == false){
      println("*BOOM* A cannon fires off in the distance...");
      if(other.weapon != null){
        println("District " + other.district + " Tribute " + other.name + " has slain District " + this.district + " Tribute " + this.name + " using their " + other.weapon.name + "!");
        this.Erase();
        other.weapon.Break();
      } 
      else{
        println("District " + other.district + " Tribute " + other.name + " has slain District " + this.district + " Tribute " + this.name + " using their bare hands!");
        this.Erase();
      }
    }
    else{
      println("District " + this.district + " Tribute " + this.name + " has survived with " + this.health + " health.");
    }
    
    if(other.alive == false){
      println("*BOOM* A cannon fires off in the distance...");
      if(this.weapon != null){
        println("District " + this.district + " Tribute " + this.name + " has slain District " + other.district + " Tribute " + other.name + " using their " + this.weapon.name + "!");
        other.Erase();
        this.weapon.Break();
      }
      else{
        println("District " + this.district + " Tribute " + this.name + " has slain District " + other.district + " Tribute " + other.name + " using their bare hands!");
        other.Erase();
      }
    }
    else{
      println("District " + other.district + " Tribute " + other.name + " has survived with " + other.health + " health.");
    }
  }
  
  void IsAlive(){
    if(this.health <= 0) {
      alive = false;
    }
  }
  
  void Erase(){
    if(OffToCornucopia.size() != 0){
      OffToCornucopia.remove(this);
      TributeList.remove(this);
      if(this.weapon != null){
        AvailableWeaponList.add(this.weapon);
        this.weapon.owner = null;
      }
    }
    else{
      TributeList.remove(this);
      if(this.weapon != null){
        AvailableWeaponList.add(this.weapon);
        this.weapon.owner = null;
      }
    }
  }
  
  int CheckAttack(Weapon w){
    if(this.training == w.type){
      return w.damage + 2;
    }
    else{
      return w.damage;
    }
  }
}
