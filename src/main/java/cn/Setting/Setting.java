package cn.Setting;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import junit.framework.Test;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import cn.util.StringHelper;

@Service
public class Setting {

	@Autowired
	SqlSession sqlSession;
	@Autowired
	HttpSession session;
	
	private static Map<String, Object> map=new HashMap<String, Object>();
 	
	public <TSetting>TSetting getSetting(Class<TSetting>setting){
		return this.getSetting(setting,null);
	}
	
	public <TSetting> TSetting getSetting(Class<TSetting> setting,Integer shopId) {

		String key = getSettingKey(setting,shopId);
		TSetting tSetting = null;
		try {
			tSetting = setting.newInstance();
			if(map.containsKey(key)){
				return  (TSetting)map.get(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		SettingEntity entity = getSettingEntity(key);
		if (entity != null && !StringHelper.IsNullOrEmpty(entity.getSetting())) {
			ObjectMapper objectMapper = new ObjectMapper();
			String v = entity.getSetting();
			try {
				tSetting = (TSetting) objectMapper.readValue(v,tSetting.getClass());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		map.put(key, tSetting);
		
		return tSetting;
	}

	public <TSetting> boolean setSetting(TSetting setting){
		return this.setSetting(setting, null);
	}
	
	public <TSetting> boolean setSetting(TSetting setting,Integer shopId) {
		boolean result = false;

		if (setting == null) {
			return result;
		}

		try {

			Class<?> settingClass = setting.getClass();
			String key = getSettingKey(settingClass, shopId);

			SettingEntity entity = getSettingEntity(key);
			if (entity == null) {
				entity = new SettingEntity(key);
			}

			JSONObject jsonObject = new JSONObject(setting);

			entity.setSetting(jsonObject.toString());

			// 保存
			if (entity.getId() > 0) {
				result = sqlSession.update("SystemSettingDao.updateSetting",entity) > 0;
			} else {
				result = sqlSession.insert("SystemSettingDao.insertSetting",entity) > 0;
			}
			if(result){
				map.put(key, setting);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	/**
	 * 获取entity
	 * 
	 * @param setting
	 * @return
	 */
	public SettingEntity getSettingEntity(String key) {

		SettingEntity entity = new SettingEntity();

		// 根据key获取 settingEntity
		entity = sqlSession.selectOne("SystemSettingDao.selectSettingByKey",key);

		return entity;
	}

	public <TSetting> String getSettingKey(Class<TSetting> setting,Integer shopId) {
		String key = setting.getSimpleName();
		if(shopId!=null&&shopId>0){
			key += "_" + shopId;
		}
		return key;
	}
}
