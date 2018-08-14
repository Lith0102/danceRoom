package cn.admin.student.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {
	
	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	//查询学生总条数
	public long selTotalCount(Map search) {
		return sqlSession.selectOne("studentDao.selTotalCount",search);
	}
	//学生列表
	public List<Map> selStudentList(Map search) {
		return sqlSession.selectList("studentDao.selStudentList", search);
	}
	//通过id查学生信息
	public Map<String, Object> selStudentById(String stuId) {
		return sqlSession.selectOne("studentDao.selStudentById", stuId);
	}
	//店铺列表
	public List selShopList() {
		return sqlSession.selectList("studentDao.selShopList");
	}
	//班级列表
	public List selClassList() {
		return sqlSession.selectList("studentDao.selClassList");
	}
	//新增学生
	public int addStudent(Map map) {
		return sqlSession.insert("studentDao.addStudent",map);
	}
	//修改学生信息
	public int updStudent(Map map) {
		return sqlSession.update("studentDao.updStudent",map);
	}
	//删除学生信息
	public int delStudentInfo(int stuId) {
		return sqlSession.update("studentDao.delStudentInfo",stuId);
				
	}
	
	
	
}
