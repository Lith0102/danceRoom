package cn.admin.show.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShowService {

	@Autowired 
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	public int addShowInfo(Map<String, Object> map) {
		return sqlSession.insert("showDao.addShowInfo",map);
	}
}
