package com.impactlaunchspace.profile;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ProfileController {
	
	@RequestMapping(value ="/setup-organization", method= RequestMethod.GET)
	public String showSetupPageForOrganization(){
		return "setup-organization";
	}
	
	@RequestMapping(value ="/setup-organization111", method= RequestMethod.POST)
	public String blah1(HttpServletRequest request, HttpServletResponse response){
		
		return "redirect:/";
	}
}
