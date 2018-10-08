package cn.admin.show.service;

import java.util.List;
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
	
	//新增文件信息
	public int addShowInfo(Map<String, Object> map) {
		return sqlSession.insert("showDao.addShowInfo",map);
	}
	
	//查询时间分组list
	public List<String> selTimeList(Map<String, Object> map) {
		return sqlSession.selectList("showDao.selTimeList",map);
	}
	
	//查询文件信息
	public List<Map> selFileByType(Map<String, Object> map) {
		return sqlSession.selectList("showDao.selFileByType", map);
	}

}
