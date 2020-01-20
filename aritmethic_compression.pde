// 1301154229 zakiy farhan fuad
// menggunakan bahasa java dengan library processing

// inisialisasi array kelas PChar yang memiliki atribut huruf dan probabilitasnya 
PChar[] arrHuruf;

// insialisasi low dan high atau current interval
float high = 1;
float low  = 0;

// inisialisasi string
String input = "ABBC#";

void setup() {
  // pengisian array arrHuruf dengan huruf yang akan digunakan (semesta)
  arrHuruf = new PChar[4];
  arrHuruf[0] = new PChar('A', 0.4);
  arrHuruf[1] = new PChar('B', 0.3);
  arrHuruf[2] = new PChar('C', 0.1);
  arrHuruf[3] = new PChar('#', 0.2);


  // ENCODING
  println("Proses encoding");
  for (int i = 0; i < input.length(); i++) {
    // update batas/interval tiap probabilitas;
    float mulai = low;
    for (int j = 0; j < arrHuruf.length; j++) {
      //penghitungan interval tiap huruf dengan
      float batas1 = mulai;
      float area = arrHuruf[j].prob * (high - low);
      float batas2 = batas1 + area;
      arrHuruf[j].updateBatas(batas1, batas2);
      mulai = batas2;
    }


    for (int j = 0; j < arrHuruf.length; j++) {
      // pemilihan high-low atau current interval selanjutnya berdasarkan char sekarang
      if (arrHuruf[j].huruf == input.charAt(i) ) {
        low  = arrHuruf[j].batas1;
        high = arrHuruf[j].batas2;
      }
    }
  }

  println("low  : " + low);
  println("high : " + high);
  // ketika sudah selesai sampai character terakhir dihitung rata rata low-high nya
  float rata = (low+high)/2;
  println("Rata - rata aritmethic : " + rata);




  // DECODING
  println();
  println("Proses decoding");
  // inisialisasi array of char sebanyak character inputan yang diketahui
  char[] deco = new char[input.length()];
  float mulai = 0;
  // proses pembuatan sub interval berdasarkan probabilitas character
  for (int i = 0; i < arrHuruf.length; i++) {
    float batas1 = mulai;
    float area = arrHuruf[i].prob;
    float batas2 = batas1 + area;
    arrHuruf[i].updateBatas(batas1, batas2);
    mulai = batas2;
  }

  for (int i = 0; i < deco.length; i++) {
    // boolean cek untuk mengetahui apakah sudah pernah masuk if statement
    boolean cek = true;
    for (int j = 0; j < arrHuruf.length; j++) {
      // pengecekan rata-rata berada pada interval setiap huruf 
      if (rata >= arrHuruf[j].batas1 && rata < arrHuruf[j].batas2 && cek) {
        // jika benar, interval yang terpilih akan menjadi huruf selanjutnya (mulai dari char pertama)
        deco[i] = arrHuruf[j].huruf;
        // normalisasi rata-rata yang didapatkan menjadi 0 sampai 1 untuk pengecekan huruf selanjutnya
        rata = (rata - arrHuruf[j].batas1)/arrHuruf[j].prob;
        cek = false;
      }
    }
  }
  // output hasil dengan menjadikan array of char menjadi string
  println("Hasil : " + new String(deco));
}