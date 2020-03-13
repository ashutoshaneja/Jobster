package com.paxcel.ashutoshaneja;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import javax.validation.constraints.AssertTrue;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Answers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.paxcel.ashutoshaneja.jobster.controller.HomeController;
import com.paxcel.ashutoshaneja.jobster.controller.LoginController;
import com.paxcel.ashutoshaneja.jobster.controller.SignupController;
import com.paxcel.ashutoshaneja.jobster.model.UserVO;
import com.paxcel.ashutoshaneja.jobster.service.SignupManager;
import com.paxcel.ashutoshaneja.jobster.service.SignupManagerImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/servlet-context.xml" })
public class TestController {

	@Mock
	Logger appLogger;
	
	@Rule
	public MockitoRule mockitoRule = MockitoJUnit.rule();

	@InjectMocks
	private HomeController homeController;

	@Mock
	SignupManager manager;
	
	@Mock
	UserVO user;

	@InjectMocks
	private LoginController loginController;

	@InjectMocks
	private SignupController signupController;

	private MockMvc mockMvc;

	private InternalResourceViewResolver viewResolver;

	@BeforeClass
	public static void setUp() {
		System.out.println("-----> SETUP <-----");
	}

	@Before
	public void setupTestCase() {
		viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		MockitoAnnotations.initMocks(this);
	}

	@Test
	public void testHomepage() throws Exception {
		this.mockMvc = MockMvcBuilders.standaloneSetup(homeController).build();

		this.mockMvc.perform(get("/")).andExpect(status().isOk()).andExpect(view().name("home"));
	}

	@Test
	public void testLogin() throws Exception {
		this.mockMvc = MockMvcBuilders.standaloneSetup(loginController).setViewResolvers(viewResolver).build();

		this.mockMvc.perform(get("/login")).andExpect(status().isOk())
				.andExpect(forwardedUrl("/WEB-INF/views/login.jsp"));
	}

	@Test
	public void testSignup() throws Exception {
		this.mockMvc = MockMvcBuilders.standaloneSetup(signupController).setViewResolvers(viewResolver).build();

		this.mockMvc.perform(get("/signup")).andExpect(status().isOk())
				.andExpect(forwardedUrl("/WEB-INF/views/signup.jsp"));
	}

	@Test
	public void testPostSignup() throws Exception {
		this.mockMvc = MockMvcBuilders.standaloneSetup(signupController).setViewResolvers(viewResolver).build();

		UserVO userVO = new UserVO();
		userVO.setPassword("123456");
		userVO.setUsername("abc");
		userVO.setRole("ROLE_SEEKER");

		when(manager.createNewUser(userVO)).thenReturn("success11");
		
		assertEquals("success", manager.createNewUser(userVO));

	}
	
	@Test
	public void testPostSignupforDuplicate() throws Exception {
		this.mockMvc = MockMvcBuilders.standaloneSetup(signupController).setViewResolvers(viewResolver).build();

		UserVO userVO = new UserVO();
		userVO.setPassword("123");
		userVO.setUsername("amar");
		userVO.setRole("ROLE_SEEKER");

		when(manager.createNewUser(userVO)).thenReturn("duplicateUser");
		
		
		assertEquals("duplicateUser",manager.createNewUser(userVO));

//		this.mockMvc.perform(
//				post("/signup").param("username", "abc").param("password", "123456").param("role", "ROLE_SEEKER"))
//				.andExpect(status().isOk());
		
	}
}