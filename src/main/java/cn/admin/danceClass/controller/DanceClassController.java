package cn.admin.danceClass.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.admin.danceClass.service.DanceClassService;
import cn.core.Authorize;

/**
 * @author 李彤辉
 *
 * @data 2018年7月31日 下午1:16:08
 * 
 * @Title: 课程表排课
 *
 */
@Controller
@RequestMapping(value="admin/danceClass")
public class DanceClassController {
	
	@Autowired
	DanceClassService danceClassService;
	
	//课表页面
	@RequestMapping(value="/timetable")
	@Authorize(setting="课程-课程表")
	public ModelAndView timetable() {
		return new ModelAndView("admin/class/timetable");
	}
	
	//课表数据
	@RequestMapping(value="/classData")
	@ResponseBody
	public Map<String,Object> classData(){
		Map<String,Object> map = new HashMap<String,Object>();
		//查询所有课程
		List<Map> list = danceClassService.selAllClass();
		map.put("code", 0);
		map.put("msg", "");
		map.put("data", list);
		return map;
	}
	
	//修改课表信息
	@RequestMapping(value="/updClassData")
	@ResponseBody
	public Map<String,Object> updClassData(){
		Map<String,Object> result = new HashMap<String,Object>();
		
		return result;
	}
	
}
