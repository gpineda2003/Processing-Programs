// Enter your array here
int[] a = {6,7,1,3,2,5,4};

void setup(){
  printArray(a);
  for(int p = 0; p < (a.length-1); p++){
    for(int i = 0; i < (a.length - p - 1); i++){
      
      if(a[i] > a[i+1]){
        int temp= a[i];
        a[i] = a[i+1];
        a[i+1] = temp;
      }
    }
  }
  print("\n");
  printArray(a);
}
