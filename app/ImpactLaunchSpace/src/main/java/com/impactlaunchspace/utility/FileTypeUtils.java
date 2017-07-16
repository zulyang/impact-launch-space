package com.impactlaunchspace.utility;

import static org.apache.tika.mime.MimeTypes.OCTET_STREAM;

import java.io.File;
import java.io.IOException;

import org.apache.tika.Tika;

import com.impactlaunchspace.exception.ContentTypeException;

public class FileTypeUtils {

	private static Tika tika;

	private static Tika getTika() {
		if (tika == null) {
			synchronized (FileTypeUtils.class) {
				if (tika == null) {
					tika = new Tika();
				}
			}
		}
		return tika;
	}

	/**
	 * Get content type from file name
	 *
	 * @param filename
	 *            file name
	 * @return content type
	 */
	public static String getContentType(String filename) {
		return getTika().detect(filename);
	}

	public static String getContentType(File file) throws ContentTypeException {
		try {
			return getTika().detect(file);
		} catch (IOException e) {
			throw new ContentTypeException(e);
		}
	}

	public static String getContentType(byte[] bytes) throws ContentTypeException {
		return getTika().detect(bytes);
	}

	public static String getContentType(String filename, File file) throws ContentTypeException {
		String type = getContentType(filename);
		if (type.equalsIgnoreCase(OCTET_STREAM)) {
			type = getContentType(file);
		}
		return type;
	}

	public static String getContentType(String filename, byte[] bytes) throws ContentTypeException {
		String type = getContentType(filename);
		if (type.equalsIgnoreCase(OCTET_STREAM)) {
			type = getContentType(bytes);
		}
		return type;
	}
}