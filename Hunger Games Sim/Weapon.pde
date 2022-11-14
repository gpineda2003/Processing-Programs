class Weapon {
  String name;
  String type;
  int damage;
  Tribute owner;
  
  Weapon(String n, String t, int d){
    this.name = n;
    this.type = t;
    this.damage = d;
    AvailableWeaponList.add(this);
  }
  
  void Break(){
    int chancebreak = round(random(1,10));
    
    if(chancebreak <= 3){
      println(this.owner.name + "'s " + this.name + " has broken! They are now left bare handed.");
      owner.weapon = null;
      owner = null;
      AvailableWeaponList.remove(this);
    }
  }
}
