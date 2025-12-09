package com.parking.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "car_photos")
public class CarPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String filename;

    private String fileType;

    @Lob
    @Basic(fetch = FetchType.LAZY)
    private byte[] fileContent;

    @OneToOne
    @JoinColumn(name = "car_id")
    private Car car;

    public Long getId() { return id; }

    public String getFilename() { return filename; }
    public void setFilename(String filename) { this.filename = filename; }

    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }

    public byte[] getFileContent() { return fileContent; }
    public void setFileContent(byte[] fileContent) { this.fileContent = fileContent; }

    public Car getCar() { return car; }
    public void setCar(Car car) { this.car = car; }
}