package com.paxcel.ashutoshaneja.jobster.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.support.SessionStatus;

import com.paxcel.ashutoshaneja.jobster.model.Vacancy;
import com.paxcel.ashutoshaneja.jobster.service.VacancyManager;

@Controller
public class RecruiterFeedController {

	@Resource
	VacancyManager manager;
	
	@RequestMapping(value="/recruiter/feed/{username}" , method = RequestMethod.GET)
	public String setupVacancyForm(Model model) {
		Vacancy vacancy = new Vacancy();
		  
		model.addAttribute("vacancy", vacancy);
		return "recruiterFeed";
	}
	
	@RequestMapping(value="/recruiter/feed/{username}", method = RequestMethod.POST)
	public String submitVacancyForm(Model model, @ModelAttribute("vacancy") Vacancy vacancy,
			BindingResult result, SessionStatus status, HttpServletRequest request){
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();	
			vacancy.setUsername(userDetail.getUsername());
		  }
		  
		vacancy.setUserID((int)request.getSession().getAttribute("userID"));
	
		if(manager.addVacancy(vacancy).equalsIgnoreCase("vacancyAdded")) {
			String output = "Vacancy Added";
			model.addAttribute("output", output);
			return "recruiterFeed";
		}
		else {
			model.addAttribute("error", "Couldn't Post Specified Vacancy due to 'Internal Issues' :(");
			return "recruiterFeed";
		}
	}
}
