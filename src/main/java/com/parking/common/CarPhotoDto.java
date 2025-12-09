package com.parking.common;

public class CarPhotoDto {

    private final Long id;
    private final String filename;
    private final String fileType;
    private final byte[] fileContent;

    public CarPhotoDto(Long id, String filename, String fileType, byte[] fileContent) {
        this.id = id;
        this.filename = filename;
        this.fileType = fileType;
        this.fileContent = fileContent;
    }

    public Long getId() { return id; }
    public String getFilename() { return filename; }
    public String getFileType() { return fileType; }
    public byte[] getFileContent() { return fileContent; }
}