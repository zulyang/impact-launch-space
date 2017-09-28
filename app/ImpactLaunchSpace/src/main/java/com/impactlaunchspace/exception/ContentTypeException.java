package com.impactlaunchspace.exception;

@SuppressWarnings("serial")
public class ContentTypeException extends Exception {
    /**
     * Content-Type not found
     */
    public ContentTypeException(Throwable cause) {
        super(cause);
    }

}