package com.embabel.demo.controller;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record SonicPiJob(
        String jobId,
        Status status,
        String result,
        String error) {

    public enum Status {
        RUNNING, COMPLETED, FAILED
    }

    public static SonicPiJob running(String jobId) {
        return new SonicPiJob(jobId, Status.RUNNING, null, null);
    }

    public static SonicPiJob completed(String jobId, String result) {
        return new SonicPiJob(jobId, Status.COMPLETED, result, null);
    }

    public static SonicPiJob failed(String jobId, String error) {
        return new SonicPiJob(jobId, Status.FAILED, null, error);
    }
}
