package com.paxcel.ashutoshaneja.jobster.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.paxcel.ashutoshaneja.jobster.model.RecruiterInfo;
import com.paxcel.ashutoshaneja.jobster.model.SeekerInfo;
import com.paxcel.ashutoshaneja.jobster.service.RecruiterInfoManager;
import com.paxcel.ashutoshaneja.jobster.service.SeekerInfoManager;

@Controller
public class AdditionalDetailController {
	
	@Resource
	SeekerInfoManager manager;
	
	@RequestMapping(value="/seeker/{username}" , method = RequestMethod.GET)
	public String setupSeekerForm(Model model, @PathVariable final String username) {
		SeekerInfo seeker = new SeekerInfo();
		model.addAttribute("username", username);
		model.addAttribute("seekerInfo", seeker);
		return "seekerDetail";
	}
	
	@RequestMapping(value="/seeker/{username}", method = RequestMethod.POST)
	public String submitSeekerForm(Model model, @ModelAttribute("seekerInfo") SeekerInfo seeker,
			BindingResult result, SessionStatus status){
		if(manager.addSeekerInfo(seeker).equalsIgnoreCase("seekerInfoAdded")) {
			return "redirect:/seeker/feed/"+seeker.getUsername();
		}
		else
			return "failed";
	}
	
	@Resource
	RecruiterInfoManager recruiterManager;
	
	@RequestMapping(value="/recruiter/{username}" , method = RequestMethod.GET)
	public String setupRecruiterForm(Model model, @PathVariable final String username) {
		RecruiterInfo recruiter = new RecruiterInfo();
		model.addAttribute("username", username);
		model.addAttribute("recruiterInfo", recruiter);
		return "recruiterDetail";
	}
	
	@RequestMapping(value="/recruiter/{username}", method = RequestMethod.POST)
	public String submitRecruiterForm(Model model, @ModelAttribute("recruiterInfo") RecruiterInfo recruiter,
			BindingResult result, SessionStatus status){
		if(recruiterManager.addRecruiterInfo(recruiter).equalsIgnoreCase("recruiterInfoAdded")) {
			return "redirect:/recruiter/feed/"+recruiter.getUsername();
		}
		else
			return "failed";
	}
	
	
}
