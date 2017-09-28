package com.impactlaunchspace.jdbc;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.tika.io.IOUtils;

import com.impactlaunchspace.dao.DocumentsIndividualDAO;
import com.impactlaunchspace.exception.ContentTypeException;
import com.impactlaunchspace.utility.FileTypeUtils;

public class JdbcDocumentsIndividualDAO implements DocumentsIndividualDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public void insert(String username, File document) {
		String sql = "INSERT INTO DOCUMENTS_INDIVIDUAL (username, document, document_name) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setBlob(2, new FileInputStream(document));
			ps.setString(3, document.getName());
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	@Override
	public void delete(String username, File document) {
		String sql = "DELETE FROM documents_individual WHERE username = ? and document_name = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, document.getName());
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	@Override
	public ArrayList<File> retrieveAll(String username) {
		String sql = "SELECT * FROM DOCUMENTS_INDIVIDUAL WHERE username = ?";

		Connection conn = null;
		ArrayList<File> documentList = new ArrayList<>();

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Blob blob = rs.getBlob("document");
				String name = rs.getString("document_name");
				InputStream in = blob.getBinaryStream();
				
				File temp = new File(name);
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				documentList.add(temp);
				temp.deleteOnExit();
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return documentList;
	}

}
