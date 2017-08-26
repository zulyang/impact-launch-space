package com.impactlaunchspace.login;

import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.impactlaunchspace.entity.Country;
import com.impactlaunchspace.entity.JobSectorIndividual;
import com.impactlaunchspace.entity.Skillset;
import com.impactlaunchspace.entity.User;
import com.impactlaunchspace.exception.ExceptionController;
import com.impactlaunchspace.profile.ProfileService;
import com.impactlaunchspace.users.UserService;

@Controller
@Scope("session")
public class LoginController {
	@Autowired
	VerificationTokenService vtService;

	@Autowired
	LoginService loginService;

	@Autowired
	RegisterService registerService;

	@Autowired
	ResetTokenService rtService;

	@Autowired
	UserService userService;

	@Autowired
	ProfileService profileService;

	private Log logger = LogFactory.getLog(ExceptionController.class);
	private final int MAX_LOGIN_ATTEMPTS = 5;

	// Verifying token for locked accounts to unlock them
	@RequestMapping(value = "/unlock-account", method = RequestMethod.GET)
	public String showUnlockPage(ModelMap model) {
		return "login/" + "unlock_account";
	}

	@RequestMapping(value = "/sendresetcodelocked", method = RequestMethod.POST)
	public String sendResetCodeForLockedAccounts(@RequestParam String usernameemail, @RequestParam String password,
			ModelMap model) {
		boolean userExists = loginService.userExists(usernameemail);

		if (userExists) {
			boolean isUser = loginService.authenticate(usernameemail, password);
			if (isUser) {
				String email = loginService.returnEmailFromUsername(usernameemail);
				String username = loginService.returnUsernameFromEmail(usernameemail);
				model.addAttribute("username", username);
				model.addAttribute("email", email);
				model.addAttribute("accountUnlockValidation", "Please check your email for your verification token");
				rtService.regenerateUnlockCode(username, email);
				return "login/" + "unlock_account_pin";
			} else {
				// FRONT END TO PRINT ERROR THAT THE USERNAME/PW IS WRONG
				model.addAttribute("accountUnlockValidation", "Username/password is incorrect.");
				return "login/" + "unlock_account";
			}
		} else {
			// FRONT END TO PRINT ERROR THAT THE ACCOUNT DOES NOT EXIST
			model.addAttribute("accountUnlockValidation", "The account does not exist.");
			return "login/" + "unlock_account";

		}
	}

	// Unlocking locked accounts
	@RequestMapping(value = "/unlock-account-pin", method = RequestMethod.GET)
	public String showUnlockAccountPage(@RequestParam("username") String username,
			@RequestParam("email") String email, ModelMap model) {
		model.addAttribute("username", username);
		model.addAttribute("email", email);
		
		return "login/" + "unlock_account_pin";
	}

	@RequestMapping(value = "/processunlockaccount", method = RequestMethod.POST)
	public String processUnlockAccount(@RequestParam String resetcode, @RequestParam String username,
			@RequestParam String email, ModelMap model) {
		boolean isResetCode = rtService.verifyToken(resetcode, username);
		if (isResetCode) {
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			rtService.unlock(username);
			loginService.resetLoginAttempts(username);
			model.addAttribute("unlockAccountPin", "Your account has been unlocked.");
			// FRONT END TO PRINT THAT ACCOUNT HAS BEEN UNLOCKED
			return "login/" + "login";
		}
		// FRONT END TO PRINT PIN IS WRONG
		model.addAttribute("unlockAccountPin", "You have entered an incorrect verification token.");
		return "login/" + "unlock_account_pin";
	}

	// Register Users
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegisterPage(ModelMap model) {
		return "login/" + "register";
	}

	@RequestMapping(value = "/registernewuser", method = RequestMethod.POST)
	public String registerNewUserPost(@RequestParam String username, @RequestParam String password1,
			@RequestParam String password2, @RequestParam String email, @RequestParam String user_type,
			ModelMap model) {
		model.put("email", email);

		int passLength = password1.length();
		boolean hasLetters = false;
		boolean hasDigits = false;
		boolean hasSomethingElse = false;

		for (int i = 0; i < passLength; i++) {
			char c = password1.charAt(i);
			if (Character.isLetter(c))
				hasLetters = true;
			else if (Character.isDigit(c))
				hasDigits = true;
			else
				hasSomethingElse = true;
		}

		if (!hasLetters || !hasDigits || !hasSomethingElse || (passLength < 6)) {
			model.addAttribute("passwordCheck",
					"Your password did not meet all requirements.");
			return "login/" + "register";
		}

		// FRONT END TO PRINT ERROR THAT THE 2 PASSWORDS ENTERED DONT MATCH
		if (!password1.equals(password2)) {
			model.addAttribute("passwordCheck", "Please ensure that both your passwords match.");
			return "login/" + "register";
		}

		boolean usernameExists = loginService.userExists(username);
		boolean emailExists = loginService.userExists(email);
		// FRONT END TO PRINT ERROR THAT USERNAME AND EMAIL HAS ALR BEEN USED
		if (usernameExists && emailExists) {
			model.addAttribute("registerCheck", "The username and email is already in use.");
			return "login/" + "register";
		} else if (usernameExists && !emailExists) {
			// FRONT END TO PRINT ERROR THAT USERNAME HAS ALR BEEN USED
			model.addAttribute("registerCheck", "The username is already in use.");
			return "login/" + "register";
		} else if (!usernameExists && emailExists) {
			// FRONT END TO PRINT ERROR THAT EMAIL HAS ALR BEEN USED
			model.addAttribute("registerCheck", "The email is already in use.");
			return "login/" + "register";
		}

		boolean registerSuccess = registerService.registerNewUser(username, password1, email, user_type);

		if (registerSuccess) {
			String verificationCode = vtService.retrieveVerificationCode(username);
			vtService.sendVerificationEmail(verificationCode, email);
			// below is for resending verification
			model.addAttribute("registerSuccess", "success");
			return "login/" + "register";
		} else {
			// FRONT END TO PRINT GENERIC ERROR, ERROR REGISTERING
			model.addAttribute("registerCheck", "An error has occurred during registration.");
			return "login/" + "register";
		}
	}

	// Verify Account
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String showWelcomePage(ModelMap model) {
		return "index";
	}

	@RequestMapping(value = "/verify-account", method = RequestMethod.GET)
	public String showVerifyAccountPage(ModelMap model) {
		return "login/" + "verify_account";
	}

	@RequestMapping(value = "/tokenexpired", method = RequestMethod.GET)
	public String showExpiredPage(ModelMap model) {
		return "tokenexpired";
	}

	@RequestMapping(value = "/verify-account", method = RequestMethod.POST)
	public String verifyAccount(@RequestParam String usernameemail, @RequestParam String password,
			@RequestParam String verificationcode, ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		boolean isUser = loginService.authenticate(usernameemail, password);
		String username = loginService.returnUsernameFromEmail(usernameemail);
		String email = loginService.returnEmailFromUsername(usernameemail);
		if (isUser) {
			boolean isTokenValid = vtService.verifyToken(verificationcode, usernameemail);
			boolean isTokenExpired = vtService.ifTokenExpired(username);
			if (isTokenValid) {
				if (isTokenExpired) {
					vtService.regenerateVerificationCode(username, email);
					model.addAttribute("verifyNewAccount",
							"Your token has expired. Please check your email for a new token.");
					// FRONT END TO PRINT TOKEN HAS EXPIRED, A NEW ONE HAS BEEN
					// SENT TO UR INBOX
					return "login/" + "verify_account"; // tokenexpired
				}
				vtService.unlock(username);
				// FRONT END TO BRING TO SUCCESS PAGE
				model.addAttribute("verifyNewAccountSuccess", "Your account has been verified.");
				return authenticate(usernameemail, password, model, request, response); // verificationsuccessful
			} else {
				// FRONT END TO PRINT TOKEN IS INVALID
				model.addAttribute("verifyNewAccount", "Your token is incorrect. Please try again.");
				return "login/" + "verify_account"; // verifyaccount
			}
		}
		model.addAttribute("verifyNewAccount", "Your username and/or password is incorrect.");
		return "login/" + "verify_account"; // verifyaccount
	}

	// Resending Verification Code at potentially other screens
	@RequestMapping(value = "/resendverification", method = RequestMethod.POST)
	public String unlockAccount(@RequestParam String usernameemail, ModelMap model) {
		model.clear();
		boolean userExists = loginService.userExists(usernameemail);
		if (userExists) {
			String email = loginService.returnEmailFromUsername(usernameemail);
			String username = loginService.returnUsernameFromEmail(usernameemail);
			vtService.regenerateVerificationCode(username, email);
			return "unlocksuccessful";
		} else {
			// FRONT END TO PRINT NO SUCH EMAIL EXIST
			return "resendverification";
		}
	}

	// Resending Verification Code At success screen (after register)
	@RequestMapping(value = "/resendverification", method = RequestMethod.GET)
	public String unlockAccount2(@RequestParam String email, ModelMap model) {
		boolean userExists = loginService.userExists(email);
		if (userExists) {
			String email2 = loginService.returnEmailFromUsername(email);
			String username = loginService.returnUsernameFromEmail(email);
			vtService.regenerateVerificationCode(username, email2);
			return "unlocksuccessful";
		} else {
			// FRONT END TO PRINT NO SUCH EMAIL EXIST
			return "resendverification";
		}
	}

	// Login and authenticate
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLoginPage(ModelMap model) {
		return "login/" + "login";
	}

	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public String authenticate(@RequestParam String usernameemail, @RequestParam String password, ModelMap model,
			HttpServletRequest request, HttpServletResponse response) {

		boolean userExists = loginService.userExists(usernameemail);
		boolean isUser = false;
		boolean isEnabled = false;
		int loginAttempts = 0;
		if (!userExists) {
			// user does not exist
			// FRONT END TO PRINT USERNAME/PW IS WRONG
			model.addAttribute("loginValidation", "Username/password is incorrect.");
			return "login/" + "login";
		} else {
			isUser = loginService.authenticate(usernameemail, password);
			isEnabled = loginService.checkEnabled(usernameemail);
			String username = loginService.returnUsernameFromEmail(usernameemail);
			if (!isEnabled && isUser) {
				// FRONT END TO PRINT THIS ACCOUNT IS LOCKED/UNVERIFIED
				// account locked or verified, do not increase login attempts
				model.addAttribute("loginValidation", "This account is locked or unverified.");
				return "login/" + "login"; // lockedlogin
			} else if(!isEnabled && !isUser){
				loginAttempts = loginService.getLoginAttempts(username);

				// if wrong but still within max login threshold, increase
				// attempts
				// and redirect to page
				if (loginAttempts < MAX_LOGIN_ATTEMPTS - 1) {
					// FRONT END TO PRINT USERNAME/PW IS WRONG
					model.addAttribute("loginValidation", "Username/password is incorrect.");
					loginService.increaseLoginAttempts(username);
					return "login/" + "login";
				} else {
					// FRONT END TO PRINT USERNAME/PW IS WRONG, ACCOUNT IS
					// LOCKED BECAUSE EXCEED 5 ATTEMPTS
					// else lock the account
					model.addAttribute("accountLockedValidation",
							"Your account has been locked. You may unlock it here. ");
					loginService.lockAccount(username);
					return "login/" + "unlock_account";
				}
			}	
			else if (isEnabled && !isUser) {
			
				loginAttempts = loginService.getLoginAttempts(username);

				// if wrong but still within max login threshold, increase
				// attempts
				// and redirect to page
				if (loginAttempts < MAX_LOGIN_ATTEMPTS - 1) {
					// FRONT END TO PRINT USERNAME/PW IS WRONG
					model.addAttribute("loginValidation", "Username/password is incorrect.");
					loginService.increaseLoginAttempts(username);
					return "login/" + "login";
				} else {
					// FRONT END TO PRINT USERNAME/PW IS WRONG, ACCOUNT IS
					// LOCKED BECAUSE EXCEED 5 ATTEMPTS
					// else lock the account
					model.addAttribute("accountLockedValidation",
							"Your account has been locked. You may unlock it here. ");
					loginService.lockAccount(username);
					return "login/" + "unlock_account";
				}

			} else if (isEnabled && isUser) {
				// if successful login reset the login attempts of the user
				// direct user to successful page
				loginService.resetLoginAttempts(username);
				User user = userService.retrieveUser(usernameemail);
				String userType = user.getUser_type();
				// To decide if the user logs in for the first time
				boolean isFirstTimeLogin = loginService.isFirstTimeLogin(usernameemail);

				// inserts information in the model for the view
				request.getSession().setAttribute("username", user.getUsername());
				request.getSession().setAttribute("email", user.getEmail());
				request.getSession().setAttribute("user", user);

				// Remember me cookie
				Cookie c = null;

				// Only if remember me is checked,generate the cookie.
				if (request.getParameter("rememberMe") != null && request.getParameter("rememberMe").equals("true")) {

					/*
					 * Check if there is a record in the database. Same user
					 * might log in from a different machine. If so, need to
					 * update the cookie database.
					 */

					boolean check = loginService.checkCookie(username);
					if (check == false) {
						// No cookie in database
						UUID s = loginService.generateCookieSecret(username);
						c = new Cookie("rememberMeCookie", s.toString());
						c.setMaxAge(365 * 24 * 60 * 60); // one year
					} else {
						// Have cookie in database, update cookie.
						// Remove cookie from browser first.
						Cookie[] cookies = request.getCookies();
						if (cookies != null)
							for (Cookie cookie : cookies) {
								if (cookie.getValue().equals("rememberMe")) {
									cookie.setValue("");
									cookie.setPath("/");
									cookie.setMaxAge(0);
									response.addCookie(cookie);
								}
							}
						String s = UUID.randomUUID().toString();
						c = new Cookie("rememberMeCookie", s);
						loginService.updateCookie(username, s);
					}
				}

				if (isFirstTimeLogin == false) {

					request.getSession().setAttribute("username", username);
					if (userType.equals("organization")) {
						// add a cookie to the response.
						if (c != null) {
							response.addCookie(c);
						}

						request.getSession().setAttribute("organization",
								profileService.getOrganizationAccountDetails(username));
						request.getSession().setAttribute("myacccount-organization",
								profileService.getOrganizationAccountDetails(username));
						request.getSession().setAttribute("countriesOfOperation",
								profileService.retrieveCountriesOfOperations(username));
						request.getSession().setAttribute("jobSectorsOrganization",
								profileService.retrieveOrganizationJobSectors(username));
						return "profile/organization/" + "view_own_organization_profile";
					} else if (userType.equals("individual")) {
						// add a cookie to the response.
						if (c != null) {
							response.addCookie(c);
						}
						request.getSession().setAttribute("individual",
								profileService.getIndividualAccountDetails(username));
						request.getSession().setAttribute("myacccount-individual",
								profileService.getIndividualAccountDetails(username));
						request.getSession().setAttribute("jobSectorsIndividual",
								profileService.retrieveIndividualJobSectors(username));

						request.getSession().setAttribute("preferredCountries",
								profileService.retrievePreferredCountries(username));
						request.getSession().setAttribute("preferredJobSectors",
								profileService.retrievePreferredJobSectors(username));
						request.getSession().setAttribute("preferredProjectArea",
								profileService.retrievePreferredProjectArea(username));
						request.getSession().setAttribute("userSkills",
								profileService.retrieveAllSkillsOfUser(username));
						return "profile/individual/" + "view_own_individual_profile";
					}
				} else {
					// userservice to determine if indiv/organ and redirect to
					// page

					// puts the necessary lists into model for setup pages to
					// obtain
					model.addAttribute("country_list", profileService.retrieveCountryList());
					model.addAttribute("job_sector_list", profileService.retrieveJobSectorList());
					request.getSession().setAttribute("user_list", userService.retrieveUsernameList());
					request.getSession().setAttribute("organization_list", userService.retrieveOrganizationNamelist());

					if (userType.equals("organization")) {
						if (c != null) {
							response.addCookie(c);
						}
						return "profile/organization/" + "setup_organization_profile";
					} else if (userType.equals("individual")) {
						if (c != null) {
							response.addCookie(c);
						}
						model.addAttribute("project_area_list", profileService.retrieveProjectAreaList());
						model.addAttribute("skillset_list", profileService.retrieveSkillsetList());
						return "profile/individual/" + "setup_individual_profile";
					}
				}
			}
		}
		return "login/" + "login";
	}

	// forget my password
	@RequestMapping(value = "/forgot-password", method = RequestMethod.GET)
	public String showForgotPasswordPage(ModelMap model) {
		return "login/" + "forgot_password";
	}

	@RequestMapping(value = "/errorgeneric", method = RequestMethod.GET)
	public String showErrorPage(ModelMap model) {
		return "error.jsp";
	}

	@RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
	public String resetPassword(@RequestParam String usernameemail, ModelMap model) {
		boolean userExists = loginService.userExists(usernameemail);
		if (userExists && usernameemail.length() != 0) {

			String email = loginService.returnEmailFromUsername(usernameemail);
			String username = loginService.returnUsernameFromEmail(usernameemail);

			// reset login attempts and lock the account if the account has been
			// reported to be forgotten
			loginService.lockAccount(username);
			loginService.resetLoginAttempts(username);
			rtService.regenerateResetCode(username, email);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			return "login/" + "forgot_password_token";
		}
		// FRONT END TO PRINT AN ACCOUNT WITH THAT EMAIL DOESN NOT EXIST
		// else error at current page
		model.addAttribute("forgotPasswordCheck", "The email does not exist.");
		return "login/" + "forgot_password";

	}

	@RequestMapping(value = "/forgot-password-token", method = RequestMethod.GET)
	public String showForgotPasswordEnterTokenPage(@RequestParam("username") String username,
			@RequestParam("email") String email, ModelMap model) {
		model.addAttribute("username", username);
		model.addAttribute("email", email);
		return "login/" + "forgot_password_token";
	}

	@RequestMapping(value = "/verifyreset", method = RequestMethod.POST)
	public String verifyResetCode(@RequestParam String resetcode, @RequestParam String username,
			@RequestParam String email, ModelMap model) {
		boolean isResetCode = rtService.verifyToken(resetcode, username);
		if (isResetCode) {
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			model.addAttribute("correctPin", "correctPin");
			rtService.unlock(username);
			return "login/" + "forgot_password_reset";
		}
		// FRONT END TO PRINT PIN IS WRONG
		model.addAttribute("username", username);
		model.addAttribute("email", email);
		model.addAttribute("pinWrongMessage", "You have entered an incorrect PIN.");
		return "login/" + "forgot_password_token";
	}

	@RequestMapping(value = "/forgot-password-reset", method = RequestMethod.GET)
	public String showForgotPasswordResetPasswordPage(ModelMap model) {
		return "login/" + "forgot_password_reset";
	}

	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	public String setNewPassword(@RequestParam String password1, @RequestParam String password2,
			@RequestParam String username, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		int passLength = password1.length();
		boolean hasLetters = false;
		boolean hasDigits = false;
		boolean hasSomethingElse = false;

		for (int i = 0; i < passLength; i++) {
			char c = password1.charAt(i);
			if (Character.isLetter(c))
				hasLetters = true;
			else if (Character.isDigit(c))
				hasDigits = true;
			else
				hasSomethingElse = true;
		}

		if (!hasLetters || !hasDigits || !hasSomethingElse || (passLength < 6)) {
			model.addAttribute("passwordError",
					"Password must contain letters, digits, symbols and have at least 6 characters.");
			return "login/" + "forgot_password_reset";
		}

		if (password1.equals(password2)) {
			loginService.unlockAccount(username);
			rtService.setNewPassword(password1, username);
			model.addAttribute("username", username);
			model.addAttribute("passwordMatch", "passwordMatch");
			model.addAttribute("loginValidation", "You have successfully reset your password.");
			return authenticate(username, password1, model, request, response);// "login1";
		}
		// FRONT END TO PRINT THE 2 PASSWORDS ENTERED DONT MATCH
		model.addAttribute("passwordError", "Your passwords do not match.");
		return "login/" + "forgot_password_reset";
	}

	@ExceptionHandler(value = Exception.class)
	public String handleError(HttpServletRequest req, Exception exception) {
		logger.error("Request: " + req.getRequestURL() + " raised " + exception);
		return "error-login-specific";
	}

	// Logout Functionality
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		// terminate authentication
		request.getSession().invalidate(); // invalidate session.
		String cookieValue = "";
		Cookie cookies[] = request.getCookies();
		Cookie myCookie = null;
		// Goes through all the cookies and checks if there is the remember me
		// cookie.
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("rememberMeCookie")) {
					cookieValue = cookies[i].getValue();
					// delete this cookie.
					loginService.cookieLogout(cookieValue);
					break;
				}
			}
			return "redirect:" + "/";
		}
		return "false";
	}

	// Register Users
	@RequestMapping(value = "/change-password", method = RequestMethod.GET)
	public String showChangePWPage(ModelMap model) {
		return "login/" + "change_password";
	}

	@RequestMapping(value = "/change-password", method = RequestMethod.POST)
	public String changePassword(@RequestParam String username, @RequestParam String existingPassword,
			@RequestParam String password1, @RequestParam String password2, ModelMap model) {
		boolean isCorrectPW = loginService.authenticate(username, existingPassword);
		int passLength = password1.length();
		boolean hasLetters = false;
		boolean hasDigits = false;
		boolean hasSomethingElse = false;

		if (!isCorrectPW) {
			model.addAttribute("passwordError", "Existing Password is incorrect");
			return "login/" + "change_password";
		}

		for (int i = 0; i < passLength; i++) {
			char c = password1.charAt(i);
			if (Character.isLetter(c))
				hasLetters = true;
			else if (Character.isDigit(c))
				hasDigits = true;
			else
				hasSomethingElse = true;
		}

		if (!hasLetters || !hasDigits || !hasSomethingElse || (passLength < 6)) {
			model.addAttribute("passwordError",
					"Password must contain letters, digits, symbols and have at least 6 characters.");
			return "login/" + "change_password";
		}

		if (password1.equals(password2)) {
			rtService.setNewPassword(password1, username);
			model.addAttribute("username", username);
			model.addAttribute("passwordMatch", "passwordMatch");
			model.addAttribute("passwordValidation", "You have successfully changed your password.");
			return "login/" + "change_password";
		}
		// FRONT END TO PRINT THE 2 PASSWORDS ENTERED DONT MATCH
		model.addAttribute("passwordError", "Your passwords do not match.");
		return "login/" + "change_password";
	}

	@RequestMapping(value = "/search-project", method = RequestMethod.GET)
	public String searchProject(ModelMap model) {
		ArrayList<Country> countries = profileService.retrieveCountryList();
		model.addAttribute("countries", countries);
		return "search/" + "search_project";
	}

	@RequestMapping(value = "/search-resource", method = RequestMethod.GET)
	public String searchResource(ModelMap model) {
		ArrayList<Country> countries = profileService.retrieveCountryList();
		ArrayList<Skillset> skillset = profileService.retrieveSkillsetList();
		model.addAttribute("countries", countries);
		model.addAttribute("skillset", skillset);
		return "search/" + "search_resource";
	}
	
	@RequestMapping(value = "/projmanagement", method = RequestMethod.GET)
	public String projManagement(ModelMap model) {
		return "Kanban";
	}

}