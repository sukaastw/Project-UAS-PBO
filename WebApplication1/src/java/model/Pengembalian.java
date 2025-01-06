package model;

import java.sql.Date;

public class Pengembalian {
    private String nomorPolisi;
    private String alamat;
    private String noHp;
    private String jenisMobil;
    private Date tanggalSewa;
    private Date tanggalKembali;
    private Date tanggalDikembalikan;
    private double denda;
    private double biayaKerusakan;
    private double totalBiaya;
    private String nama;

    public Pengembalian(String nomorPolisi, String alamat, String noHp, String jenisMobil, Date tanggalSewa, Date tanggalKembali, Date tanggalDikembalikan, double denda, double biayaKerusakan, double totalBiaya, String nama) {
        this.nomorPolisi = nomorPolisi;
        this.alamat = alamat;
        this.noHp = noHp;
        this.jenisMobil = jenisMobil;
        this.tanggalSewa = tanggalSewa;
        this.tanggalKembali = tanggalKembali;
        this.tanggalDikembalikan = tanggalDikembalikan;
        this.denda = denda;
        this.biayaKerusakan = biayaKerusakan;
        this.totalBiaya = totalBiaya;
        this.nama = nama;
    }

    // Getters and Setters
    public String getNomorPolisi() {
        return nomorPolisi;
    }

    public void setNomorPolisi(String nomorPolisi) {
        this.nomorPolisi = nomorPolisi;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public String getNoHp() {
        return noHp;
    }

    public void setNoHp(String noHp) {
        this.noHp = noHp;
    }

    public String getJenisMobil() {
        return jenisMobil;
    }

    public void setJenisMobil(String jenisMobil) {
        this.jenisMobil = jenisMobil;
    }

    public Date getTanggalSewa() {
        return tanggalSewa;
    }

    public void setTanggalSewa(Date tanggalSewa) {
        this.tanggalSewa = tanggalSewa;
    }

    public Date getTanggalKembali() {
        return tanggalKembali;
    }

    public void setTanggalKembali(Date tanggalKembali) {
        this.tanggalKembali = tanggalKembali;
    }

    public Date getTanggalDikembalikan() {
        return tanggalDikembalikan;
    }

    public void setTanggalDikembalikan(Date tanggalDikembalikan) {
        this.tanggalDikembalikan = tanggalDikembalikan;
    }

    public double getDenda() {
        return denda;
    }

    public void setDenda(double denda) {
        this.denda = denda;
    }

    public double getBiayaKerusakan() {
        return biayaKerusakan;
    }

    public void setBiayaKerusakan(double biayaKerusakan) {
        this.biayaKerusakan = biayaKerusakan;
    }

    public double getTotalBiaya() {
        return totalBiaya;
    }

    public void setTotalBiaya(double totalBiaya) {
        this.totalBiaya = totalBiaya;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }
}