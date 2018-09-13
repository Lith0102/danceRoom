package cn.admin.finance.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FinanceService {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	//---------------------------购买支出模块---------------------
	
	//查询支出列表数据总条数
	public long selTotalCount(Map search) {
		return sqlSession.selectOne("financeDao.selTotalCount",search);
	}
	//查询支出列表数据
	public List<Map> selZhiChuList(Map search) {
		return sqlSession.selectList("financeDao.selZhiChuList", search);
	}
	//添加支出记录信息
	public int addExpenseInfo(Map map) {
		return sqlSession.insert("financeDao.addExpenseInfo",map);
	}
	//修改支出记录信息
	public int updExpenseInfo(Map map) {
		return sqlSession.update("financeDao.updExpenseInfo",map);
	}
	//根据id查信息
	public Map<String, Object> selZhiChuInfoById(String infoId) {
		return sqlSession.selectOne("financeDao.selZhiChuInfoById",infoId);
	}
	//删除支出记录
	public int delZhiChuInfo(int infoId) {
		return sqlSession.update("financeDao.delZhiChuInfo",infoId);
	}
	
	//-------------------财务统计计算模块--------------------------
	//查询缴费学生列表，根据时间
	public List<Map> calculationStudentPay(Map<String, Object> map) {
		return sqlSession.selectList("financeDao.calculationStudentPay",map);
	}

	//查询课程的价格
	public double selClassPrice(Map<String, Object> info) {
		return sqlSession.selectOne("financeDao.selClassPrice", info);
	}
	//查询购买支出的金额
	public double selBuyMoney(Map search) {
		return sqlSession.selectOne("financeDao.selBuyMoney", search); 
	}
	//添加计算结果
	public int addStatisticsInfo(Map map) {
		return sqlSession.insert("financeDao.addStatisticsInfo", map);
	}
	//查询统计总条数
	public long selTJInfoTotalCount(Map search) {
		return sqlSession.selectOne("financeDao.selTJInfoTotalCount", search);
	}
	//查询统计列表
	public List<Map> selStatisticsList(Map search) {
		return sqlSession.selectList("financeDao.selStatisticsList", search);
	}
	//删除统计信息
	public int delStatistics(int infoId) {
		return sqlSession.update("financeDao.delStatistics",infoId);
	}
	
	
}
