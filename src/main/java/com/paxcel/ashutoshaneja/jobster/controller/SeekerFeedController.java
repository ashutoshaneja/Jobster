package com.paxcel.ashutoshaneja.jobster.controller;

import java.security.Principal;

import javax.annotation.Resource;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.paxcel.ashutoshaneja.jobster.model.SearchVacancy;
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
		model.addAttribute("vacancies", manager.showVacancy());
		return "seekerFeed";
	}
	 
	
	@RequestMapping(value="/seeker/feed/{username}" , method = RequestMethod.POST)
	public String filterVacancy(Model model, @ModelAttribute("searchVacancy") SearchVacancy vacancy, BindingResult result,
			SessionStatus status) {
		model.addAttribute("vacancies", manager.showFilteredVacancy(vacancy));
		return "seekerFeed";
	}
}
