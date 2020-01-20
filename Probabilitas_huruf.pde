class PChar{
 char huruf;
 float prob;
 float batas1;
 float batas2;
 
 PChar(char huruf, float prob){
   // inisialisasi kelas
   this.huruf = huruf;
   this.prob = prob;
 }
 
 void updateBatas(float batas1, float batas2){
   // untuk menyimpan batas interval setiap hurufnya
   this.batas1 = batas1;
   this.batas2 = batas2;
 }
  
}