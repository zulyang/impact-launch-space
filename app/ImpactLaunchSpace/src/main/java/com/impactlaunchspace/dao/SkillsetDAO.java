package com.impactlaunchspace.dao;

import java.util.ArrayList;

import com.impactlaunchspace.entity.Skillset;

public interface SkillsetDAO {
	public void insert(Skillset skillset);
	public void remove(Skillset skillset);
	public ArrayList<Skillset> retrieveAll();
}
