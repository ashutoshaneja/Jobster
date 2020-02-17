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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.paxcel.ashutoshaneja.jobster.model.UserVO;
import com.paxcel.ashutoshaneja.jobster.service.LoginManager;

@Controller
//@RequestMapping("/login")
@SessionAttributes("user")
public class LoginController 
{
	@Resource
	LoginManager manager;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		  ModelAndView model = new ModelAndView();
		  
		  if (error != null) {
			model.addObject("error", "Invalid username and password!");
		  }

		  if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		  }
		  model.setViewName("login");

		  return model;

		}

	
//	  @RequestMapping(method = RequestMethod.GET) 
//	  public String setupForm(Model model) { 
//		  UserVO userVO = new UserVO(); 
//		  model.addAttribute("user", userVO);
//	  return "login"; }
	 

	
//	@RequestMapping(value = "/login", method = RequestMethod.GET)
//	public String submitForm(Model model, 
//			@ModelAttribute("userVO") UserVO userVO, BindingResult result, SessionStatus status) {
//
//		//Store the employee information in database
//		if(manager.handleLoginRequest(userVO)) { 
//			status.setComplete();
//			if(manager.sendResponse(userVO).equalsIgnoreCase("Seeker")) { 
//				return "redirect:/seeker/feed/"+userVO.getUsername(); 
//			} 
//			else { 
//				return "redirect:/recruiter/feed/"+userVO.getUsername(); 
//			} 
//		} 
//		else { 
//			String output = "Incorrect Username/Password"; 
//			model.addAttribute("output", output); 
//			return "login"; 
//		} 
//	}
	
	@RequestMapping("/sendLoginResponse")
    public String defaultAfterLogin(HttpServletRequest request) {
		 ModelAndView model = new ModelAndView();
		 String username="";
		  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();	
			username = userDetail.getUsername();
		  }
		
        if (request.isUserInRole("ROLE_SEEKER")) {
        	return "redirect:/seeker/feed/"+username;
        }
        return "redirect:/recruiter/feed/"+username;
    }
	 
	
	
	//for 403 access denied page
		@RequestMapping(value = "/403", method = RequestMethod.GET)
		public ModelAndView accesssDenied() {

		  ModelAndView model = new ModelAndView();
			
		  //check if user is login
		  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();	
			model.addObject("username", userDetail.getUsername());
		  }
			
		  model.setViewName("403");
		  return model;
		}

}