package cn;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.context.embedded.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Component
public class ServletContainerCustomizer {
	@Bean
	public EmbeddedServletContainerCustomizer containerCustomizer() {
		return new EmbeddedServletContainerCustomizer() {
			@Override
			public void customize(ConfigurableEmbeddedServletContainer container) {
				container.addErrorPages(new ErrorPage(HttpStatus.BAD_REQUEST, "/error/400"));
	            container.addErrorPages(new ErrorPage(HttpStatus.UNAUTHORIZED, "/error/401"));
	            container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/error/404"));        
	            container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/500"));
	            container.addErrorPages(new ErrorPage(Throwable.class, "/error/500"));
			}
		};
	}
}
