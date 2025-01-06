package model;

public class Kendaraan {
    private String nomorPolisi;
    private String merek;
    private String jenis;
    private int stok;
    private double harga;
    private String status;

    // Constructor
    public Kendaraan(String nomorPolisi, String merek, String jenis, int stok, double harga, String status) {
        this.nomorPolisi = nomorPolisi;
        this.merek = merek;
        this.jenis = jenis;
        this.stok = stok;
        this.harga = harga;
        this.status = status;
    }

    // Getters and Setters
    public String getNomorPolisi() {
        return nomorPolisi;
    }

    public void setNomorPolisi(String nomorPolisi) {
        this.nomorPolisi = nomorPolisi;
    }

    public String getMerek() {
        return merek;
    }

    public void setMerek(String merek) {
        this.merek = merek;
    }

    public String getJenis() {
        return jenis;
    }

    public void setJenis(String jenis) {
        this.jenis = jenis;
    }

    public int getStok() {
        return stok;
    }

    public void setStok(int stok) {
        this.stok = stok;
    }

    public double getHarga() {
        return harga;
    }

    public void setHarga(double harga) {
        this.harga = harga;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}