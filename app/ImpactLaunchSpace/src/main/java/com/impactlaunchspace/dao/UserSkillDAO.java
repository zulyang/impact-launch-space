package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.UserSkill;

public interface UserSkillDAO {
	public void insert(UserSkill userSkill);
	public ArrayList<UserSkill> retrieveAllSkillsOfUser(String username);
	public void deleteUserSkillset(String username);
}
