class Mahasiswa {
  int? nim = 0;
  String? nama = "";
  String? alamat = "";
  String? jk = "";
  String? tglLahir = "";
  List<String>? hobi = [];
  String? email = "";
  double? ipk = 0;
  String? fakultas = "";
  String? prodi = "";
  String? imgPath = "";

  setNim(nim) {
    this.nim = nim;
  }

  setNama(nama) {
    this.nama = nama;
  }

  setAlamat(alamat) {
    this.alamat = alamat;
  }

  setJK(jk) {
    this.jk = jk;
  }

  setTglLahir(tglLahir) {
    this.tglLahir = tglLahir;
  }

  setHobi(hobi) {
    this.hobi = hobi;
  }

  setEmail(email) {
    this.email = email;
  }

  setIpk(ipk) {
    this.ipk = ipk;
  }

  setFakultas(fakultas) {
    this.fakultas = fakultas;
  }

  setProdi(prodi) {
    this.prodi = prodi;
  }

  setImgPath(imgPath) {
    this.imgPath = imgPath;
  }

  getNim() {
    return nim;
  }

  getNama() {
    return nama;
  }

  getAlamat() {
    return alamat;
  }

  getJK() {
    return jk;
  }

  List<String>? getHobi() {
    return hobi;
  }

  getEmail() {
    return email;
  }

  getIPK() {
    return ipk;
  }

  getFakultas() {
    return fakultas;
  }

  getProdi() {
    return prodi;
  }

  getTglLahir() {
    return tglLahir;
  }

  getImgPath() {
    return imgPath;
  }
}
