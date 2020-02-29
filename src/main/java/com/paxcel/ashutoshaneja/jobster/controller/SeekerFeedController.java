package com.paxcel.ashutoshaneja.jobster.controller;

import java.security.Principal;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.paxcel.ashutoshaneja.jobster.model.SearchVacancy;
import com.paxcel.ashutoshaneja.jobster.model.Vacancy;
import com.paxcel.ashutoshaneja.jobster.service.SeekerInfoManager;

@Controller
public class SeekerFeedController {

	@Autowired 
	Logger appLogger;

	@Resource
	SeekerInfoManager manager;

	@RequestMapping(value="/seeker/feed/{username}" , method = RequestMethod.GET)
	public String setupVacancyForm(Model model, Principal principal, HttpServletRequest request) {

		Vacancy applyVacancy = new Vacancy();
		SearchVacancy vacancy = new SearchVacancy();

		String name = principal.getName(); //get logged in username

		applyVacancy.setUsername(name);
		
		
		applyVacancy.setUserID((int)request.getSession().getAttribute("userID"));
		applyVacancy.setUsername((String)request.getSession().getAttribute("username"));

		model.addAttribute("applyVacancy", applyVacancy);
		model.addAttribute("searchVacancy", vacancy);

		return "seekerFeed";
	}

	@RequestMapping(value="/seeker/feed/{username}/showVacancyData", method = RequestMethod.POST)
	public @ResponseBody List<Vacancy> showVacancy() {
		return(manager.showVacancy());
	}


	@RequestMapping(value="/seeker/feed/{username}" , method = RequestMethod.POST)
	public @ResponseBody List<Vacancy> filterVacancy(@RequestParam(value = "error", required = false) String error,
			@ModelAttribute("searchVacancy") SearchVacancy vacancy, BindingResult result,
			SessionStatus status) {
		ModelAndView model = new ModelAndView();

		if (error != null) {
			model.addObject("error", "Error Encountered, Connection Issues :(");
		}
		if(manager.showFilteredVacancy(vacancy).isEmpty()) {
			model.addObject("output", "No vacancy found :(");
		}
		return(manager.showFilteredVacancy(vacancy));
	}

	@RequestMapping(value="/seeker/feed/{username}/applyVacancy" , method = RequestMethod.GET)
	public @ResponseBody String applyVacancy(@RequestParam("value") int value, @ModelAttribute("applyVacancy") Vacancy applyVacancyObj, BindingResult result,
			SessionStatus status, HttpServletRequest request) {
		
		String username="";
		  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();	
			username = userDetail.getUsername();
		  }
		
		applyVacancyObj.setVacancyID(value);
		applyVacancyObj.setUserID((int)request.getSession().getAttribute("userID"));
		applyVacancyObj.setUsername(username);

		appLogger.info("Inside Apply Job Controller: -> "+applyVacancyObj.getVacancyID());
		appLogger.info("Inside Apply Job Controller: -> "+applyVacancyObj.getUserID());
		appLogger.info("Inside Apply Job Controller: -> "+applyVacancyObj.getUsername());
		
		
		return(manager.applyVacancy(applyVacancyObj));
	}
}
