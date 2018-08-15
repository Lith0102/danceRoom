package cn.admin.teachers.service;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeachersService {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	
	
}
