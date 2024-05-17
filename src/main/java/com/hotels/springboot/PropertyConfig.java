package com.hotels.springboot;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

/*
사용자 정의 프로퍼티 파일을 스프링 컨테이너 등록하기 위해 정의한 클래스로 시작시 자동으로 Scan되어
빈을 생성하게 된다. 해당 클래스는 반드시 기본패키지 하위에 위치해야 한다.
 */
@Configuration
public class PropertyConfig {
	/*
	name 속성을 지정하였으므로 myprops라는 이름으로 빈이 생성된다.
	'PropertiesFactoryBean myprops = new PropertiesFactoryBean();'와 동일한 
	결과를 반환한다.
	 */
	@Bean(name="myprops")
	public PropertiesFactoryBean propertiesFactoryBean() {
		//프로퍼티 인스턴스 생성
		PropertiesFactoryBean propertiesFactoryBean = 
				new PropertiesFactoryBean();
		//사용자 정의 프로퍼티 파일의 경로를 지정
		ClassPathResource classPathResource =
				new ClassPathResource("my.properties");
		//경로를 등록한 후 인스턴스를 반환한다.
		propertiesFactoryBean.setLocation(classPathResource);
		return propertiesFactoryBean;
	}
}
