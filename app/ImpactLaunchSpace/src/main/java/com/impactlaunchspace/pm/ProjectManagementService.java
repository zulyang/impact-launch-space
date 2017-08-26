package com.impactlaunchspace.pm;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.impactlaunchspace.dao.BoardDAO;
import com.impactlaunchspace.dao.CardDAO;
import com.impactlaunchspace.dao.DocumentsProjectDAO;
import com.impactlaunchspace.dao.OrganizationAccountDAO;
import com.impactlaunchspace.dao.ProjectBanListDAO;
import com.impactlaunchspace.dao.ProjectDAO;
import com.impactlaunchspace.dao.ProjectMemberListDAO;
import com.impactlaunchspace.dao.ProjectRequestedResourceDAO;
import com.impactlaunchspace.dao.ProjectResourceCategoryDAO;
import com.impactlaunchspace.dao.ProjectTargetAreaDAO;
import com.impactlaunchspace.entity.Card;
import com.impactlaunchspace.entity.Project;
import com.impactlaunchspace.entity.ProjectBanList;
import com.impactlaunchspace.entity.ProjectMemberList;
import com.impactlaunchspace.entity.ProjectRequestedResource;
import com.impactlaunchspace.entity.ProjectResourceCategory;
import com.impactlaunchspace.entity.ProjectTargetArea;

@Service
public class ProjectManagementService {

	public ArrayList<Card> retrieveProjectCards(int board_id){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		CardDAO cardDAO = (CardDAO) context.getBean("cardDAO");
		return cardDAO.retrieveCards(board_id);	
	}
	
	public int retrieveBoardId(String Project_Name, String Project_Proposer){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");
		BoardDAO boardDAO = (BoardDAO) context.getBean("boardDAO");
		return boardDAO.retrieveBoardId(Project_Name, Project_Proposer);
	}
}
