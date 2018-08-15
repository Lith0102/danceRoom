package cn.admin.teachers.service;

import java.util.List;
import java.util.Map;

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
	
	//查询教师数量
	public long selTotalCount(Map search) {
		return sqlSession.selectOne("teachersDao.selTotalCount",search);
	}
	//查询教师数据列表
	public List<Map> selTeacherList(Map search) {
		return sqlSession.selectList("teachersDao.selTeacherList", search);
	}
	
	
	
}
