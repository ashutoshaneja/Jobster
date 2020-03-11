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

		appLogger.info("\n-----------------------------------------------------------------------------\n"); 
		appLogger.info(this.getClass().getSimpleName()+": Welcome to Jobster... Application is LIVE!");

		model.setViewName("home");
		return model;
	}
	
	@RequestMapping(value = { "/aboutMe"}, method = RequestMethod.GET)
	public ModelAndView aboutMePage() {

		ModelAndView model = new ModelAndView();
		model.setViewName("aboutMe");
		return model;
	}
}
