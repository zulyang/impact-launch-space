package com.impactlaunchspace.dao;

import com.impactlaunchspace.entity.User;

public interface UserDAO {
		public void insert(User user);
		public void updatePasswordInDB(String username, String plaintextPassword);
		public User findByUsername(String username);
		public User findByEmail(String email);
		public void unlockAccount(String username);
		public void lockAccount(String username);
		public int getLoginAttempts(String username);
		public void increaseLoginAttempts(String username);
		public void resetLoginAttempts(String username);
}
