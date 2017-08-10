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
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.impactlaunchspace.dao.DocumentsProjectDAO;
import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.exception.ContentTypeException;
import com.impactlaunchspace.utility.FileTypeUtils;

public class JdbcProjectDAO implements ProjectDAO {
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(Project project) {
		
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		DocumentsProjectDAO documentsProjectDAO = (DocumentsProjectDAO) context.getBean("documentsProjectDAO");
		
		String sql = "INSERT INTO PROJECTS "
				+ "(project_name, description, purpose, duration, location, project_proposer, organization, isPublic, hiddenToOutsiders, hiddenToAll, project_status, created_date, page_views, project_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			FileInputStream fis = new FileInputStream(project.getProjectImage());
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project.getProject_name());
			ps.setString(2, project.getDescription());
			ps.setString(3, project.getPurpose());
			ps.setInt(4, project.getDuration());
			ps.setString(5, project.getLocation());
			ps.setString(6, project.getProject_proposer());
			ps.setString(7, project.getOrganization());
			ps.setBoolean(8, project.isPublic());
			ps.setBoolean(9, project.isHiddenToOutsiders());
			ps.setBoolean(10, project.isHiddenToAll());
			ps.setString(11, project.getProject_status());
			ps.setTimestamp(12, project.getCreated_date());
			ps.setInt(13, project.getPage_Views());
			ps.setBlob(14, fis);

			ps.executeUpdate();
			ps.close();
			// update documents table
			for (File document : project.getDocumentList()) {
				documentsProjectDAO.insert(project.getProject_name(), project.getProject_proposer(), document);
			}

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} catch (FileNotFoundException e) {
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

	public Project retrieveProject(String project_name, String project_proposer) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		DocumentsProjectDAO documentsProjectDAO = (DocumentsProjectDAO) context.getBean("documentsProjectDAO");
		
		String sql = "SELECT * FROM PROJECTS WHERE PROJECT_NAME = ? AND PROJECT_PROPOSER = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, project_proposer);
			Project project = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Blob blob = rs.getBlob("project_image");
				InputStream in = blob.getBinaryStream();
				byte[] bytes = IOUtils.toByteArray(in);
				String fileType = "";
				try {
					fileType = FileTypeUtils.getContentType(bytes);
				} catch (ContentTypeException e) {
					e.printStackTrace();
				}
				fileType = "." + fileType.split("/")[1];
				in = blob.getBinaryStream();
				File temp = File.createTempFile("project_image", fileType);
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"), rs.getBoolean("isPublic"),
						rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getTimestamp("created_date"), 
						rs.getInt("page_views"), temp, documentsProjectDAO.retrieveAll(rs.getString("project_name"), rs.getString("project_proposer")));
			}
			rs.close();
			ps.close();
			return project;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return null;
	}

	public ArrayList<Project> retrieveProjectByUser(String username) {
		ArrayList<Project> output = new ArrayList<Project>();
		
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		DocumentsProjectDAO documentsProjectDAO = (DocumentsProjectDAO) context.getBean("documentsProjectDAO");
		
		String sql = "SELECT * FROM PROJECTS WHERE project_proposer = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			Project project = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Blob blob = rs.getBlob("project_image");
				InputStream in = blob.getBinaryStream();
				byte[] bytes = IOUtils.toByteArray(in);
				String fileType = "";
				try {
					fileType = FileTypeUtils.getContentType(bytes);
				} catch (ContentTypeException e) {
					e.printStackTrace();
				}
				fileType = "." + fileType.split("/")[1];
				in = blob.getBinaryStream();
				File temp = File.createTempFile("project_image", fileType);
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"), rs.getBoolean("isPublic"),
						rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getTimestamp("created_date"), 
						rs.getInt("page_views"), temp, documentsProjectDAO.retrieveAll(rs.getString("project_name"), rs.getString("project_proposer")));
				output.add(project);
			}
			rs.close();
			ps.close();
			return output;
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
		return output;
	}

	public ArrayList<Project> retrievePublicProjects() {
		ArrayList<Project> output = new ArrayList<Project>();

		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		DocumentsProjectDAO documentsProjectDAO = (DocumentsProjectDAO) context.getBean("documentsProjectDAO");
		
		String sql = "SELECT * FROM PROJECTS WHERE isPublic = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1, true);
			Project project = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Blob blob = rs.getBlob("project_image");
				InputStream in = blob.getBinaryStream();
				byte[] bytes = IOUtils.toByteArray(in);
				String fileType = "";
				try {
					fileType = FileTypeUtils.getContentType(bytes);
				} catch (ContentTypeException e) {
					e.printStackTrace();
				}
				fileType = "." + fileType.split("/")[1];
				in = blob.getBinaryStream();
				File temp = File.createTempFile("project_image", fileType);
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"), rs.getBoolean("isPublic"),
						rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getTimestamp("created_date"), 
						rs.getInt("page_views"), temp, documentsProjectDAO.retrieveAll(rs.getString("project_name"), rs.getString("project_proposer")));
				output.add(project);
			}
			rs.close();
			ps.close();
			return output;
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
		return output;
	}

	public void updateProject(String project_name, String description, String purpose, int duration, String location,
			boolean isPublic, boolean hiddenToOutsiders, boolean hiddenToAll, String old_project_name,
			String project_proposer) {
		String sql = "UPDATE PROJECTS SET "
				+ "project_name = ?,  description = ?, purpose = ?, duration = ?, location = ?, isPublic = ?, hiddenToOutsiders = ?, hiddenToAll = ? WHERE project_name = ? AND project_proposer = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, project_name);
			ps.setString(2, description);
			ps.setString(3, purpose);
			ps.setInt(4, duration);
			ps.setString(5, location);
			ps.setBoolean(6, isPublic);
			ps.setBoolean(7, hiddenToOutsiders);
			ps.setBoolean(8, hiddenToAll);
			ps.setString(9, old_project_name);
			ps.setString(10, project_proposer);
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public ArrayList<Project> retrieveProjectsBySearch(String causes, String location, String searchbox) {
		ArrayList<Project> output = new ArrayList<Project>();

		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		DocumentsProjectDAO documentsProjectDAO = (DocumentsProjectDAO) context.getBean("documentsProjectDAO");
		
		// If Search bar is not empty

		// Multiple SQL's to select from the Misc filters.
		// Default Setting when the user hits the search landing page.
		String sql = "SELECT * FROM PROJECTS p INNER JOIN PROJECT_TARGET_AREAS pt ON p.Project_Name = pt.Project_Name"
					+ " AND p.Project_Proposer = pt.Project_Proposer WHERE pt.PROJECT_NAME LIKE '%" + searchbox + "%' ";
		
		if (!causes.equals("Select Cause")) {
			sql += "AND pt.PROJECT_AREA = '" + causes + "'";
		}
		if (!location.equals("All")){
			sql += "AND p.LOCATION = '" + location + "'";
		}
		
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);

			Project project = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Blob blob = rs.getBlob("project_image");
				InputStream in = blob.getBinaryStream();
				byte[] bytes = IOUtils.toByteArray(in);
				String fileType = "";
				try {
					fileType = FileTypeUtils.getContentType(bytes);
				} catch (ContentTypeException e) {
					e.printStackTrace();
				}
				fileType = "." + fileType.split("/")[1];
				in = blob.getBinaryStream();
				File temp = File.createTempFile("project_image", fileType);
				OutputStream out = new FileOutputStream(temp);
				byte[] buff = new byte[4096]; // how much of the blob to
												// read/write at a time
				int len = 0;

				while ((len = in.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				
				project = new Project(rs.getString("project_name"), rs.getString("description"),
						rs.getString("purpose"), rs.getInt("duration"), rs.getString("location"),
						rs.getString("project_proposer"), rs.getString("organization"), rs.getBoolean("isPublic"),
						rs.getBoolean("hiddenToOutsiders"), rs.getBoolean("hiddenToAll"),
						rs.getString("project_status"), rs.getTimestamp("created_date"), 
						rs.getInt("page_views"), temp, documentsProjectDAO.retrieveAll(rs.getString("project_name"), rs.getString("project_proposer")));
				output.add(project);
			}
			rs.close();
			ps.close();
			return output;
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
		return output;
	}

}