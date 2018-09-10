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
	
	//-------------------课表-------------
	//查询所有课程
	public List<Map> selAllClass() {
		return sqlSession.selectList("danceClassDao.selAllClass");
	}
	//修改课程表信息
	public int updClassData(Map map) {
		return sqlSession.update("danceClassDao.updClassData",map);
	}
	//添加课程信息
	public int addClassData(Map<String, Object> map) {
		return sqlSession.insert("danceClassDao.addClassData",map);
	}
	//删除课表信息
	public int delClass(Map map) {
		return sqlSession.delete("danceClassDao.delClass",map);
	}
	
	//----------------课程计划---------------
	//查询所有学生
	public List<Map> selStudentList() {
		return sqlSession.selectList("danceClassDao.selStudentList");
	}
	//查询课程计划
	public Map<String, Object> selPlanInfo(String nowYear) {
		return sqlSession.selectOne("danceClassDao.selPlanInfo", nowYear);
	}
	//新增年度计划信息
	public void addPlanInfo(String nowYear) {
		sqlSession.insert("danceClassDao.addPlanInfo",nowYear);
	}
	//查询年份列表
	public List<Map> selYearList() {
		return sqlSession.selectList("danceClassDao.selYearList");
	}
	//保存计划信息
	public int updPlanInfo(Map<String, Object> info) {
		return sqlSession.update("danceClassDao.updPlanInfo",info);
	}
	//根据id查询年份
	public String selYears(String planyearId) {
		return sqlSession.selectOne("danceClassDao.selYears",planyearId);
	}
	
	
	//----------------教学内容---------------
	//查询教学内容
	public Map<String, Object> selClassContent() {
		return sqlSession.selectOne("danceClassDao.selClassContent");
	}
	//添加教学内容
	public int addClassContent(Map map) {
		return sqlSession.insert("danceClassDao.addClassContent",map);
	}
	//修改教学内容
	public int updClassContent(Map map) {
		return sqlSession.update("danceClassDao.updClassContent",map);
	}
	
	
	//---------------课程费用----------------
	//查询价格信息
	public Map<String, Object> selPriceInfo() {
		return sqlSession.selectOne("danceClassDao.selPriceInfo");
	}
	//查询所有门店
	public List<Map> selShopList() {
		return sqlSession.selectList("danceClassDao.selShopList");
	}
	//保存价格信息
	public int addClassPriceInfo(Map map) {
		return sqlSession.insert("danceClassDao.addClassPriceInfo",map);
	}
	//修改价格信息
	public int updClassPriceInfo(Map map) {
		return sqlSession.update("danceClassDao.updClassPriceInfo",map);
	}
	
	//--------------教学评估----------------------
	

}
