package cn.admin.danceClass.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.admin.danceClass.service.DanceClassService;
import cn.core.Authorize;

/**
 * @author 李彤辉
 *
 * @data 2018年7月31日 下午1:16:08
 * 
 * @Title: 课程管理
 *
 */
@Controller
@RequestMapping(value="admin/danceClass")
public class DanceClassController {
	
	@Autowired
	DanceClassService danceClassService;
	
	//------------------课表排课----------------------
	
	//课表页面
	@RequestMapping(value="/timetable")
	@Authorize(setting="课程-课程表")
	public ModelAndView timetable() {
		return new ModelAndView("admin/class/timetable/list");
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
	public Map<String,Object> updClassData(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String,Object>();
		String updvalue = map.get("updvalue")+"";
		if(StringUtils.isEmpty(updvalue)){
			map.put(map.get("updkey")+"", " ");
		}else{
			map.put(map.get("updkey")+"", updvalue);
		}
		
		int row = danceClassService.updClassData(map);
		if(row>0) {
			result.put("result",true);
			result.put("msg", "修改成功！");
		}else {
			result.put("result", false);
			result.put("msg", "修改失败！");
		}
		return result;
	}
	
	//添加课表时间信息
	@RequestMapping(value="/addClassData")
	@ResponseBody
	public Map<String,Object> addClassData(){
		Map<String,Object> map = new HashMap<String,Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		map.put("createTime", sdf.format(new Date()));
		int row = danceClassService.addClassData(map);
		if(row>0){
			map.put("result", true);
			map.put("msg", "添加成功，请完善课程信息！");
		}else {
			map.put("result", false);
			map.put("msg", "添加失败！");
		}
		return map;
	}
	
	//删除课表信息
	@RequestMapping(value="/delClass")
	@ResponseBody
	public Map<String,Object> delClass(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String,Object>();
		int row = danceClassService.delClass(map);
		if(row>0){
			result.put("result", true);
			result.put("msg", "删除成功!");
		}else {
			result.put("result", false);
			result.put("msg", "删除失败!");
		}
		return result;
	}
	
	//--------------------课程计划-------------------
	@RequestMapping(value="/classPlanFace")
	@Authorize(setting="课程-课程计划")
	public ModelAndView classPlan(){
		return new ModelAndView("admin/class/classplan/list");
	}
	
	//--------------------课程费用-------------------
	@RequestMapping(value="/classPrice")
	@Authorize(setting="课程-课程计划")
	public ModelAndView classPrice(){
		Map<String,Object> map = new HashMap<String,Object>();
		map = danceClassService.selPriceInfo(); 
		return new ModelAndView("admin/class/classprice/list",map);
	}
	
	@RequestMapping(value="/addClassPrice")
	@ResponseBody
	public Map addClassPrice(@RequestParam Map map) {
		Map<String,Object> result = new HashMap<String,Object>();
		//先查询是否存在数据
		String priceId = map.get("priceId")+"";
		int countInfo = 0;
		if(StringUtils.isEmpty(priceId)){//当数据不存在时，保存信息
			countInfo = danceClassService.selisHaveInfo(map);
		}else{//当存在时，进行修改
			countInfo = danceClassService.updClassPriceInfo(map);
		}
		if(countInfo>0){
			result.put("result", true);
			result.put("msg", "保存成功！");
		}else {
			result.put("result", false);
			result.put("msg", "保存失败！");
		}
		
		return result;
	}
	
	
	
}
