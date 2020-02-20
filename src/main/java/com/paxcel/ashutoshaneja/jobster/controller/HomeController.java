package com.paxcel.ashutoshaneja.jobster.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {

	@Autowired 
	Logger appLogger;

	@RequestMapping(value = { "/", "/home" ,"/welcome**" }, method = RequestMethod.GET)
	public ModelAndView welcomePage(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		  }

		  if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		  }
		  model.setViewName("home");
		
		appLogger.info("-----------------------------------------------------------------------------\n"); 
		appLogger.info(this.getClass().getSimpleName()+": Welcome to Jobster... Application is LIVE!");

		appLogger.info(this.getClass().getSimpleName()+": Returning Default Homepage!");

		return model;
	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title", "Spring Security Hello World");
		model.addObject("message", "This is protected page!");
		model.setViewName("admin");

		return model;

	}
}
