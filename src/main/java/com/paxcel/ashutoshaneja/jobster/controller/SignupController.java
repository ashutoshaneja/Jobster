package com.paxcel.ashutoshaneja.jobster.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
//@SessionAttributes("user")
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
	public String submitForm(Model model, @Valid @ModelAttribute("user") UserVO userVO,
			BindingResult result, SessionStatus status, HttpServletRequest request) {
		//Store the employee information in database
		
		if(result.hasErrors()) {
			return "signup";
		}
		
		if("success".equals(manager.createNewUser(userVO))) {
			
			request.getSession().setAttribute("username", userVO.getUsername());
			request.getSession().setAttribute("userID", userVO.getUserID());
			   
			if(userVO.getRole().equalsIgnoreCase("ROLE_SEEKER")) {
				return "redirect:/seeker/"+userVO.getUsername();
			}
			else {
				return "redirect:/recruiter/"+userVO.getUsername();
			}
		}
		else if("duplicateUsername".equalsIgnoreCase(manager.createNewUser(userVO))) {
			model.addAttribute("msg", "Username already exists!! Try something different.");
			return "signup";
		}	
		else {
			model.addAttribute("error", "Couldn't complete Signup Process due to Internal Issues :( \nTry after sometime");
			return "signup";
		}
	}
}