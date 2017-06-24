package com.impactlaunchspace.security;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired 
	DataSource dataSource; 
	
	@Autowired
	public void configureGlobalSecurity(AuthenticationManagerBuilder auth)
			throws Exception {
		
		auth.jdbcAuthentication().dataSource(dataSource)
			.usersByUsernameQuery(
				"select username,password, enabled from users where username = ?")
			.authoritiesByUsernameQuery(
				"select username from users where user_type=admin");
	}
	
	@Override
	//configures specific HTTP Requests
	protected void configure(HttpSecurity http) throws Exception {
		 http.authorizeRequests()
		.antMatchers("/").permitAll()//allows all requests to / pass through 
		.antMatchers("/loggedIn/**").access("hasRole('USER')").and()
		.formLogin().loginPage("/login1") //Sets default login page as login1
		.and().logout().permitAll() //Allows any user to request logout
		.and().csrf()
		.and().exceptionHandling().accessDeniedPage("/403"); //handles errors not authenticated. 
	}
}

