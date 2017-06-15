package com.in28minutes.databasetest;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.in28minutes.dao.CustomerDAO;
import com.in28minutes.entity.Customer;
import com.in28minutes.exception.ExceptionController;

@Controller
public class TestingController {
	
	private Log logger = LogFactory.getLog(ExceptionController.class);
	
	@RequestMapping(value = "/testing", method = RequestMethod.GET)
	public String showDataPage(ModelMap model) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

	    CustomerDAO customerDAO = (CustomerDAO) context.getBean("customerDAO");
	    Customer customer = new Customer(2, "mkyong",28);
	    customerDAO.insert(customer);
	
	    Customer customer1 = customerDAO.findByCustomerId(1);
	    model.put("customer", customer1);

		
		return "testing";
	}
	
	@ExceptionHandler(value = Exception.class)
	public String handleError(HttpServletRequest req, Exception exception) {
		logger.error("Request: " + req.getRequestURL() + " raised " + exception);
		return "error-specific";
	}
	
}
