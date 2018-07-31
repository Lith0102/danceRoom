package cn.admin.consumer.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import cn.util.DataConvert;

@Service
public class ConsumerService {
	
	@Autowired
	SqlSessionFactory sqlSessionFactory;
	@Autowired
	SqlSession sqlSession;
	
	
	
	
	
	//查询普通用户数量
	public long selConsumerCount(Map<String, Object> reqMap) {
		return sqlSession.selectOne("consumerDao.selConsumerCount", reqMap);
	}
	//查询普通用户列表
	public List<Map<String, Object>> selConsumerList(Map<String, Object> reqMap) {
		return sqlSession.selectList("consumerDao.selConsumerList", reqMap);
	}
	//删除用户
	public int deletes(Map map) {
		return sqlSession.update("consumerDao.deletes", map);
	}
	//查询扩展信息
	public Map<String, Object> selExtends(String userId) {
		return sqlSession.selectOne("consumerDao.selExtends", userId);
	}
	//添加扩展信息
	public int addExtends(Map map) {
		return sqlSession.insert("consumerDao.addExtends", map);
	}
	//修改扩展信息
	public int upExtends(Map map) {
		return sqlSession.update("consumerDao.upExtends", map);
	}
	//批量删除
	public long deleteids(Map<String, Object> map) {
		return sqlSession.delete("consumerDao.deleteids", map);
	}
	//查询用户信息
	public Map<String, Object> selectUserInfoById(String userId) {
		return sqlSession.selectOne("consumerDao.selectUserInfoById", userId);
	}
	//修改用户信息
	@Transactional
	public int editUser(Map map) {
		if(!StringUtils.isEmpty(map.get("approve")) && "1".equals(DataConvert.ToString(map.get("approve")))){
			map.put("userType", 2);
		}
		int row = sqlSession.update("consumerDao.editUser", map);
		int r = 0;
		if(row > 0){
			r = sqlSession.update("consumerDao.updateBalance", map);
		}
		//判断是否是专家
		if("2".equals(map.get("userType")+"")){
			//修改专家扩展信息
			sqlSession.update("consumerDao.updateMsg", map);
		}
		return row+r;
	}
	//查询用户密码
	public String selUserPwd(Map map) {
		return sqlSession.selectOne("consumerDao.selUserPwd", map);
	}
	//查询用户余额
	public Map selBalance(String userId) {
		return sqlSession.selectOne("consumerDao.selBalance", userId);
	}
	//查询消费记录
	public List selAccountLog(String userId) {
		return sqlSession.selectList("consumerDao.selAccountLog", userId);
	}
	//查询用的打赏记录
	public List findByUserRewardLog(String userId) {
		return sqlSession.selectList("consumerDao.findByUserRewardLog", userId);
	}
	//查询该用户共打赏了多少钱
	public double selSumMoney(String userId) {
		return sqlSession.selectOne("consumerDao.selSumMoney", userId);
	}
	//查询用户评论列表
	public List selectCommenUser(String userId) {
		return sqlSession.selectList("consumerDao.selectCommenUser", userId);
	}
	//查询导出数据
	public List selectDownload(Map map) {
		return sqlSession.selectList("consumerDao.selectDownload", map);
	}
	//查询用户订单
	public List selectUserOrderList(String userId) {
		return sqlSession.selectList("consumerDao.selectUserOrderList", userId);
	}
	//查询用户积分
	public Map selectJF(String userId) {
		return sqlSession.selectOne("consumerDao.selectJF", userId);
	}
	//积分记录
	public List selectJFlog(String userId) {
		return sqlSession.selectList("consumerDao.selectJFlog", userId);
	}
	//我的提问记录
	public List selectInterlocutionList(String userId) {
		return sqlSession.selectList("consumerDao.selectInterlocutionList", userId);
	}
	//提问我的
	public List selectQuestionList(String userId) {
		return sqlSession.selectList("consumerDao.selectQuestionList", userId);
	}
	//查询我得旁听
	public List selMyaudit(String userId) {
		return sqlSession.selectList("consumerDao.selMyaudit", userId);
	}
	//查询旁听我得
	public List selAuditMy(String userId) {
		return sqlSession.selectList("consumerDao.selAuditMy", userId);
	}
	//查询用户角色
	public String selectUserType(String userId) {
		return sqlSession.selectOne("consumerDao.selectUserType", userId);
	}
	
	
	

}
