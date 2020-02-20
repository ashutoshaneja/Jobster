package com.paxcel.ashutoshaneja.jobster.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */

@Controller
public class ErrorController {
	
	@Autowired 
	Logger appLogger;
 
    @RequestMapping(value = "errors", method = RequestMethod.GET)
    public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {
         
        ModelAndView errorPage = new ModelAndView("errorPage");
        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);
 
        switch (httpErrorCode) {
            case 400: {
                errorMsg = "Bad Request";
                break;
            }
            case 401: {
                errorMsg = "Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "Resource   not   found";
                break;
            }
            case 500: {
                errorMsg = "Internal Server Error";
                break;
            }
        }
        
        appLogger.info(this.getClass().getSimpleName()+": Error Encountered - "+errorMsg);

        errorPage.addObject("errorCode", httpErrorCode);
        errorPage.addObject("errorMsg", errorMsg);
        return errorPage;
    }
     
    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
          .getAttribute("javax.servlet.error.status_code");
    }
}
