package cn.admin.danceClass.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李彤辉
 *
 * @data 2018年7月31日 下午2:51:40
 * 
 * @Title: 课程表
 *
 */
@Service
public class DanceClassService {
	
	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	//查询所有课程
	public List<Map> selAllClass() {
		return sqlSession.selectList("danceClassDao.selAllClass");
	}
	
	
}
