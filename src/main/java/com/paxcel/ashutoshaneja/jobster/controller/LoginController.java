package com.paxcel.ashutoshaneja.jobster.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.paxcel.ashutoshaneja.jobster.service.LoginManager;

@Controller
@SessionAttributes("user")
public class LoginController 
{	
	@Autowired 
	Logger appLogger;
	
	@Resource
	LoginManager manager;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, SessionStatus status) {

		  ModelAndView model = new ModelAndView();
		  
		  if (error != null) {
			model.addObject("error", "Invalid username and password!");
		  }

		  if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
			status.setComplete();
		  }
		  
		  model.setViewName("login");
		  return model;
		}
	
	@RequestMapping("/sendLoginResponse")
    public String defaultAfterLogin(HttpServletRequest request) {
		 String username="";
		  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();	
			username = userDetail.getUsername();
			
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("userID", manager.getUserID(username));
		  }
		
        if (request.isUserInRole("ROLE_SEEKER")) {
        	appLogger.info("'"+username+"' Login Success - Returning Seeker feed ");
        	return "redirect:/seeker/feed/"+username;
        }
        appLogger.info("'"+username+"' Login Success - Returning Recruiter feed ");
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