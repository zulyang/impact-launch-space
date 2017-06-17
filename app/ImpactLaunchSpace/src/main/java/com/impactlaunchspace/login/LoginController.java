package com.impactlaunchspace.login;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.impactlaunchspace.dao.UserDAO;
import com.impactlaunchspace.dao.VerificationTokenDAO;
import com.impactlaunchspace.entity.User;
import com.in28minutes.exception.ExceptionController;
import com.in28minutes.todo.TodoService;

@Controller
public class LoginController {
	@Autowired
	VerificationTokenService vtService;
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	RegisterService registerService;
	
	private Log logger = LogFactory.getLog(ExceptionController.class);
	private final int MAX_LOGIN_ATTEMPTS = 5;
	
	//Register Users
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegisterPage(ModelMap model) {
		return "register";
	}
	
	@RequestMapping(value = "/registernewuser", method = RequestMethod.POST)
	public String registerNewUserPost(@RequestParam String username,@RequestParam String password,
			@RequestParam String email, @RequestParam String user_type,ModelMap model) {
		model.clear();

	    boolean registerSuccess = registerService.registerNewUser(username, password, email, user_type);
	    if(registerSuccess){
	    	String verificationCode = vtService.retrieveVerificationCode(username);
	    	vtService.sendVerificationEmail(verificationCode);
	    	return "registrationsuccessful";
	    }
	    else{
	    	return "register";
	    }
	}

	
	// Verify Account
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String showWelcomePage(ModelMap model) {
		model.put("name", getLoggedInUserName());
		return "login";
	}
	
	@RequestMapping(value = "/verifyaccount", method = RequestMethod.GET)
	public String showVerifyAccountPage(ModelMap model) {
		return "verifyaccount";
	}
	
	@RequestMapping(value = "/verifyaccount", method = RequestMethod.POST)
	public String verifyAccount(@RequestParam String username, @RequestParam String password
			,@RequestParam String verificationcode,ModelMap model) {
		boolean isUser = loginService.authenticate(username, password);
		if(isUser){
			boolean isTokenValid = vtService.verifyToken(verificationcode, username);
			vtService.unlock(username);
			if(isTokenValid){
				return "verificationsuccessful";
			}else{
				return "verifyaccount";
			}
		}
		
		return "verifyaccount";
	}
	
	//Login and authenticate
	@RequestMapping(value = "/login1", method = RequestMethod.GET)
	public String showLogin1Page(ModelMap model) {
		return "login1";
	}
	
	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public String authenticate(@RequestParam String username,
			@RequestParam String password, ModelMap model) {

			boolean userExists = loginService.userExists(username);
			boolean isUser = false;
			boolean isEnabled = false;
			int loginAttempts = 0;
			
			if(!userExists){
				//user does not exist
				return "login1";
			}else{
				isUser = loginService.authenticate(username, password);
				isEnabled = loginService.checkEnabled(username);
					
				if(!isEnabled && isUser){
					//account locked or verified, do not increase login attempts
					return "lockedlogin";
				}else if(isEnabled && !isUser){
					loginAttempts = loginService.getLoginAttempts(username);

					//if wrong but still within max login threshold, increase attempts
					//and redirect to page
					if(loginAttempts < MAX_LOGIN_ATTEMPTS - 1){
						loginService.increaseLoginAttempts(username);
						return "login1";
					}else{
						//else lock the account
						loginService.lockAccount(username);
						return "accountjustlocked";
					}
						
				}else if(isEnabled && isUser){
						//if successful login reset the login attempts of the user
						//direct user to successful page
						loginService.resetLoginAttempts(username);
						return "loginsuccessful";
				}
			}
		return "login1";
	}
	
	
	
	@ExceptionHandler(value = Exception.class)
	public String handleError(HttpServletRequest req, Exception exception) {
		logger.error("Request: " + req.getRequestURL() + " raised " + exception);
		return "error-login-specific";
	}
	
	private String getLoggedInUserName() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails)
			return ((UserDetails) principal).getUsername();

		return principal.toString();
	}

}