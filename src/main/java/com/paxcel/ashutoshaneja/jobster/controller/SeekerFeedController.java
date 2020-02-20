package com.paxcel.ashutoshaneja.jobster.controller;

import java.security.Principal;
import java.util.List;

import javax.annotation.Resource;

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

	@Resource
	SeekerInfoManager manager;

	@RequestMapping(value="/seeker/feed/{username}" , method = RequestMethod.GET)
	public String setupVacancyForm(Model model, Principal principal) {
		
		
		SearchVacancy vacancy = new SearchVacancy();
		
		String name = principal.getName(); //get logged in username
	    model.addAttribute("username", name); 
		model.addAttribute("searchVacancy", vacancy);

		return "seekerFeed";
	}
	
	@RequestMapping(value="/seeker/feed/{username}/showVacancyData" , method = RequestMethod.POST)
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
		return(manager.showFilteredVacancy(vacancy));
	}
}
