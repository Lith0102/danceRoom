package cn;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.DispatcherType;
import javax.servlet.MultipartConfigElement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import cn.Setting.Setting;
import cn.Setting.Model.AdminPreFixSetting;
import cn.core.AuthorizeInterceptor;
import cn.core.SignInterceptor;
import cn.core.UploadServlet;
import cn.core.UserSecurityInterceptor;
import cn.util.StringHelper;

@Configuration
@EnableAutoConfiguration
@EnableScheduling // 定时任务
@ServletComponentScan
@SpringBootApplication
public class DanceRoomApplication extends WebMvcConfigurerAdapter {
	
	private final static  String securityKey="qfsdfsdfasd";
	
	@Autowired
	Setting setting;
	@Autowired
	WebApplicationContext webApplicationContext;
	
	public static void main(String args[]) throws InterruptedException {
		SpringApplication.run(DanceRoomApplication.class);
	}

	@Bean
	public FilterRegistrationBean filterRegistrationBean() {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		AdminRewriteFilter adminRewriteFilter = new AdminRewriteFilter();
		registrationBean.setFilter(adminRewriteFilter);
		List<String> urlPatterns = new ArrayList<String>();
		urlPatterns.add("/*");
		registrationBean.setUrlPatterns(urlPatterns);
		registrationBean.setDispatcherTypes(DispatcherType.REQUEST);
		return registrationBean;
	}
	
	/**
	 * 跨域请求配置
	 * @return
	 */
	private CorsConfiguration buildConfig(){
		CorsConfiguration corsConfiguration = new CorsConfiguration();
		corsConfiguration.addAllowedHeader("*");
		corsConfiguration.addAllowedOrigin("*");
		corsConfiguration.addAllowedMethod("*");
		return corsConfiguration;
	}

	@Bean
	public ServletRegistrationBean servletRegistrationBean() {
		ServletRegistrationBean bean = new ServletRegistrationBean(new UploadServlet(), "/uploader");
		bean.setMultipartConfig(new MultipartConfigElement(""));
		return bean;
	}

//	@Override
//	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
//		super.addArgumentResolvers(argumentResolvers);
//		argumentResolvers.add(new ModelTraceProcessor());
//	}

	@Bean
	MappingJackson2HttpMessageConverter converter() {
		// Set HTTP Message converter using a JSON implementation.
		MappingJackson2HttpMessageConverter jsonMessageConverter = new MappingJackson2HttpMessageConverter();

		// Add supported media type returned by BI API.
		List<MediaType> supportedMediaTypes = new ArrayList<MediaType>();
		supportedMediaTypes.add(new MediaType("text", "json"));
		supportedMediaTypes.add(new MediaType("application", "json"));
		jsonMessageConverter.setSupportedMediaTypes(supportedMediaTypes);

		return jsonMessageConverter;
	}

	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		String root = System.getProperty("user.dir");
		registry.addResourceHandler("/upload/**").addResourceLocations("file:" + root + "\\upload\\");
		super.addResourceHandlers(registry);
	}

	/**
	 * 配置安全拦截器
	 * 
	 * @param registry
	 */
	public void addInterceptors(InterceptorRegistry registry) {
		AdminPreFixSetting adminPreFix = setting.getSetting(AdminPreFixSetting.class);
		if (adminPreFix != null) {
			AdminRewriteFilter.adminPrefix = adminPreFix.getAdminUrl();
			webApplicationContext.getServletContext().setAttribute("adminprefix", adminPreFix.getAdminUrl());
		}
		
		// 后台管理端拦劫器
		registry.addInterceptor(new UserSecurityInterceptor("admin","loginUser")).addPathPatterns("/admin/**").excludePathPatterns("/admin/login/**");
		
		// 后台权限验证
		registry.addInterceptor(new AuthorizeInterceptor()).excludePathPatterns("/admin/login/**,/").excludePathPatterns("/error/**");
		
		//接口验证
		registry.addInterceptor(new SignInterceptor(securityKey)).addPathPatterns("/api/**");
		
		
	}

	/**
	 * 视图解析器
	 */
	public void addViewControllers(ViewControllerRegistry registry) {
		AdminPreFixSetting adminPreFix = setting.getSetting(AdminPreFixSetting.class);
		if(!StringHelper.IsNullOrEmpty(adminPreFix.getAdminUrl())){
			
			String loginUrl="/"+adminPreFix.getAdminUrl()+"/login";
		
			registry.addRedirectViewController("/login",loginUrl);
			registry.addRedirectViewController("/admin",loginUrl);
			registry.addRedirectViewController("/"+adminPreFix.getAdminUrl(), loginUrl);
		}
		registry.addRedirectViewController("/web","/web/home/index");
		registry.addRedirectViewController("/phone","/phone/home/index");
		super.addViewControllers(registry);
	}
}
