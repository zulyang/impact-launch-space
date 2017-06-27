package com.impactlaunchspace.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.exception.ExceptionController;

@Controller
public class LoginController {
	@Autowired
	VerificationTokenService vtService;
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	RegisterService registerService;
	
	@Autowired
	ResetTokenService rtService;
	
	private Log logger = LogFactory.getLog(ExceptionController.class);
	private final int MAX_LOGIN_ATTEMPTS = 5;
	
	

	//Unlocking locked accounts
	@RequestMapping(value = "/unlockmyaccount", method = RequestMethod.GET)
	public String showUnlockPage(ModelMap model) {
		return "unlockaccount";
	}
	
	@RequestMapping(value = "/sendresetcodelocked", method = RequestMethod.POST)
	public String sendResetCodeForLockedAccounts(@RequestParam String usernameemail
			,@RequestParam String password,ModelMap model) {
		boolean userExists = loginService.userExists(usernameemail);
		if(userExists){
			boolean isUser = loginService.authenticate(usernameemail, password);
			String email = loginService.returnEmailFromUsername(usernameemail);
			String username = loginService.returnUsernameFromEmail(usernameemail);
			rtService.regenerateResetCode(username, email);
			return "unlocksuccessful";
		}else{
			//print message that no such email exists
			//FRONT END TO PRINT ERROR THAT THE ACCOUNT DOES NOT EXIST
			return "unlockaccount";
		}
	}

	//Register Users
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegisterPage(ModelMap model) {
		return "register";
	}
	
	@RequestMapping(value = "/registernewuser", method = RequestMethod.POST)
	public String registerNewUserPost(@RequestParam String username,@RequestParam String password1,@RequestParam String password2,
			@RequestParam String email, @RequestParam String user_type,ModelMap model) {
		model.put("email", email);
		//FRONT END TO PRINT ERROR THAT THE 2 PASSWORDS ENTERED DONT MATCH
		if(!password1.equals(password2)){
			model.addAttribute("registerCheck", "Please ensure that both your passwords match.");
	    	return "register";
	    }
	    
		boolean usernameExists = loginService.userExists(username);
		boolean emailExists = loginService.userExists(email);
		
		//FRONT END TO PRINT ERROR THAT USERNAME AND EMAIL HAS ALR BEEN USED
		if(usernameExists && emailExists){
			model.addAttribute("registerCheck", "The username and email is already in use.");
			return "register";
		}else if(usernameExists && !emailExists){
			//FRONT END TO PRINT ERROR THAT USERNAME HAS ALR BEEN USED
			model.addAttribute("registerCheck", "The username is already in use.");
			return "register";
		}else if(!usernameExists && emailExists){
			//FRONT END TO PRINT ERROR THAT EMAIL HAS ALR BEEN USED
			model.addAttribute("registerCheck", "The email is already in use.");
			return "register";
		}
		
		boolean registerSuccess = registerService.registerNewUser(username, password1, email, user_type);
	    
	    if(registerSuccess){
	    	String verificationCode = vtService.retrieveVerificationCode(username);
	    	vtService.sendVerificationEmail(verificationCode, email);
	    	//below is for resending verification
	    	model.addAttribute("registerCheck", "success");
	    	return "registrationsuccessful";
	    }
	    else{
	    	//FRONT END TO PRINT GENERIC ERROR, ERROR REGISTERING
	    	model.addAttribute("registerCheck", "An error has occurred during registration.");
	    	return "register";
	    }
	}

	
	// Verify Account
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String showWelcomePage(ModelMap model) {
		model.put("name", getPrincipal());
		return "index";
	}
	
	@RequestMapping(value = "/verifyaccount", method = RequestMethod.GET)
	public String showVerifyAccountPage(ModelMap model) {
		return "verifyaccount";
	}
	
	@RequestMapping(value = "/tokenexpired", method = RequestMethod.GET)
	  public String showExpiredPage(ModelMap model) {
	    return "tokenexpired";
	  }
	
	@RequestMapping(value = "/verifyaccount", method = RequestMethod.POST)
	  public String verifyAccount(@RequestParam String usernameemail, @RequestParam String password
	      ,@RequestParam String verificationcode,ModelMap model) {
	    boolean isUser = loginService.authenticate(usernameemail, password);
	    String username = loginService.returnUsernameFromEmail(usernameemail);
	    String email = loginService.returnEmailFromUsername(usernameemail);
	    if(isUser){
	      boolean isTokenValid = vtService.verifyToken(verificationcode, usernameemail);
	      boolean isTokenExpired = vtService.ifTokenExpired(username);
	      
	      if(isTokenValid){
	        if(isTokenExpired){
	          vtService.regenerateVerificationCode(username, email);
	          //FRONT END TO PRINT TOKEN HAS EXPIRED, A NEW ONE HAS BEEN SENT TO UR INBOX
	          return "tokenexpired";
	        }
	        vtService.unlock(usernameemail);
	        //FRONT END TO BRING TO SUCCESS PAGE
	        return "verificationsuccessful";
	      }else{
	    	//FRONT END TO PRINT TOKEN IS INVALID
	    	  return "verifyaccount";
	      }
	    }
	    
	    return "verifyaccount";
	  }
	
	//Resending Verification Code at potentially other screens
	@RequestMapping(value = "/resendverification", method = RequestMethod.POST)
	public String unlockAccount(@RequestParam String usernameemail,
			ModelMap model) {
		model.clear();
		boolean userExists = loginService.userExists(usernameemail);
		if(userExists){
			String email = loginService.returnEmailFromUsername(usernameemail);
			String username = loginService.returnUsernameFromEmail(usernameemail);
			vtService.regenerateVerificationCode(username, email);
			return "unlocksuccessful";
		}else{
			//FRONT END TO PRINT NO SUCH EMAIL EXIST
			return "resendverification";
		}
	}
	
	//Resending Verification Code At success screen (after register)
	@RequestMapping(value = "/resendverification", method = RequestMethod.GET)
	public String unlockAccount2(@RequestParam String email,
			ModelMap model) {
		boolean userExists = loginService.userExists(email);
		if(userExists){
			String email2 = loginService.returnEmailFromUsername(email);
			String username = loginService.returnUsernameFromEmail(email);
			vtService.regenerateVerificationCode(username, email2);
			return "unlocksuccessful";
		}else{
			//FRONT END TO PRINT NO SUCH EMAIL EXIST
			return "resendverification";
		}
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
				//FRONT END TO PRINT USERNAME/PW IS WRONG
				return "login1";
			}else{
				isUser = loginService.authenticate(username, password);
				isEnabled = loginService.checkEnabled(username);
					
				if(!isEnabled && isUser){
					//FRONT END TO PRINT THIS ACCOUNT IS LOCKED/UNVERIFIED
					//account locked or verified, do not increase login attempts
					return "lockedlogin";
				}else if(isEnabled && !isUser){
					loginAttempts = loginService.getLoginAttempts(username);
					
					//if wrong but still within max login threshold, increase attempts
					//and redirect to page
					if(loginAttempts < MAX_LOGIN_ATTEMPTS - 1){
						//FRONT END TO PRINT USERNAME/PW IS WRONG
						loginService.increaseLoginAttempts(username);
						return "login1";
					}else{
						//FRONT END TO PRINT USERNAME/PW IS WRONG, ACCOUNT IS LOCKED BECAUSE EXCEED 5 ATTEMPTS
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
	
	
	//forget my password
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
	public String showForgotPasswordPage(ModelMap model) {
		return "forgotpassword";
	}
	
	@RequestMapping(value = "/errorgeneric", method = RequestMethod.GET)
	public String showErrorPage(ModelMap model) {
		return "error.jsp";
	}
	
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
	public String resetPassword(@RequestParam String usernameemail, ModelMap model) {
		boolean userExists = loginService.userExists(usernameemail);
		if(userExists){
			
			String email = loginService.returnEmailFromUsername(usernameemail);
			String username = loginService.returnUsernameFromEmail(usernameemail);
			
			//reset login attempts and lock the account if the account has been reported to be forgotten
			loginService.lockAccount(username);
			loginService.resetLoginAttempts(username);
			rtService.regenerateResetCode(username, email);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "emailsent";
		}
		//FRONT END TO PRINT AN ACCOUNT WITH THAT EMAIL DOESN NOT EXIST
		//else error at current page
		return "forgotpassword";
		
	}
	
	@RequestMapping(value = "/verifyreset", method = RequestMethod.POST)
	public String verifyResetCode(@RequestParam String resetcode,@RequestParam String username,
			@RequestParam String email, ModelMap model) {
		boolean isResetCode = rtService.verifyToken(resetcode, username);
		if(isResetCode){
			model.addAttribute("username",username);
			model.addAttribute("email",email);
			rtService.unlock(username);
			return "resetpassword";
		}
		//FRONT END TO PRINT PIN IS WRONG
		return "forgotpassword";
	}
	
	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	public String setNewPassword(@RequestParam String password1,@RequestParam String password2,
			@RequestParam String username,ModelMap model) {
		if(password1.equals(password2)){
			loginService.unlockAccount(username);
			rtService.setNewPassword(password1, username);
			model.addAttribute("username",username);
			return "loginsuccessful";
		}
		//FRONT END TO PRINT THE 2 PASSWORDS ENTERED DONT MATCH
		return "forgotpassword";
	}
	
	
	@ExceptionHandler(value = Exception.class)
	public String handleError(HttpServletRequest req, Exception exception) {
		logger.error("Request: " + req.getRequestURL() + " raised " + exception);
		return "error-login-specific";
	}

	//Logout Functionality
	@RequestMapping(value ="/logout", method= RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response){
		//terminate authentication
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/login1";
	}
	
	private String getPrincipal() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails)
			return ((UserDetails) principal).getUsername();

		return principal.toString();
	}

}