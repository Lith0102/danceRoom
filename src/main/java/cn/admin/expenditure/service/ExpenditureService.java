package cn.admin.expenditure.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExpenditureService {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	//查询支出列表数据总条数
	public long selTotalCount(Map search) {
		return sqlSession.selectOne("expenditureDao.selTotalCount",search);
	}
	//查询支出列表数据
	public List<Map> selZhiChuList(Map search) {
		return sqlSession.selectList("expenditureDao.selZhiChuList", search);
	}
	//添加支出记录信息
	public int addExpenseInfo(Map map) {
		return sqlSession.insert("expenditureDao.addExpenseInfo",map);
	}
	//修改支出记录信息
	public int updExpenseInfo(Map map) {
		return sqlSession.update("expenditureDao.updExpenseInfo",map);
	}
	//根据id查信息
	public Map<String, Object> selZhiChuInfoById(String infoId) {
		return sqlSession.selectOne("expenditureDao.selZhiChuInfoById",infoId);
	}
	//删除支出记录
	public int delZhiChuInfo(int infoId) {
		return sqlSession.update("expenditureDao.delZhiChuInfo",infoId);
	}
	
}
