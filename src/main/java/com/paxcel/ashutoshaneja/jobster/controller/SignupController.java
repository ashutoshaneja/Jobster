package com.paxcel.ashutoshaneja.jobster.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;
import com.paxcel.ashutoshaneja.jobster.service.SignupManager;

@Controller
@RequestMapping("/signup")
@SessionAttributes("user")
public class SignupController 
{
	@Resource
	SignupManager manager;

	@RequestMapping(method = RequestMethod.GET)
	public String setupForm(Model model) {
		UserVO userVO = new UserVO();
		model.addAttribute("user", userVO);
		return "signup";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String submitForm(Model model, @ModelAttribute("user") UserVO userVO,
			BindingResult result, SessionStatus status) {
		//Store the employee information in database
		if(manager.createNewUser(userVO).equals("success")) {

			status.setComplete();

			if(userVO.getRole().equalsIgnoreCase("ROLE_SEEKER")) {
				return "redirect:/seeker/"+userVO.getUsername();
			}
			else {
				return "redirect:/recruiter/"+userVO.getUsername();
			}
		}
		else if(manager.createNewUser(userVO).equals("duplicateUsername")) {
			String output = "Username already exists!! Try something different.";
			model.addAttribute("output", output);
			return "failed";
		}	
		else {
			String output = "Couldn't complete Signup Process due to Internal Issues :( \nTry after sometime";
			model.addAttribute("output", output);
			return "failed";
		}
	}
}