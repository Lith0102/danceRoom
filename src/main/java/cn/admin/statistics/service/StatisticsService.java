package cn.admin.statistics.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StatisticsService {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	//查询缴费学生列表，根据时间
	public List<Map> calculationStudentPay(Map<String, Object> map) {
		return sqlSession.selectList("statisticsDao.calculationStudentPay",map);
	}

	//查询课程的价格
	public double selClassPrice(Map<String, Object> info) {
		return sqlSession.selectOne("statisticsDao.selClassPrice", info);
	}
	
	
	
}
