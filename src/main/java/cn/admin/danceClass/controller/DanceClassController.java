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
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		Date now = new Date();
		String nowYear = sdf.format(now);//当前年份
		map.put("nowYear", nowYear);
		//查询学生列表
		List<Map> list = danceClassService.selStudentList();
		map.put("stuList", net.sf.json.JSONArray.fromObject(list));
		//查询计划信息
		Map<String,Object> planmap = danceClassService.selPlanInfo(nowYear);
		if(planmap==null){//当不存在该年的信息时，进行新增
			danceClassService.addPlanInfo(nowYear);
		}else {//当该年信息已存在时，进行信息查询回显
			String planText = map.get("plan")+"";//获取计划内容的json串
			if(StringUtils.isEmpty(planText)){
				map.put("planInfo", "");
			}else {
				map.put("planInfo", "解析后的json串");
			}
		}
		
		//查询年份
		List<Map> yearList = danceClassService.selYearList();
		map.put("yearList", yearList);
		
		return new ModelAndView("admin/class/classplan/list",map);
	}
	//添加课程计划
	@RequestMapping(value="/addClassPlan")
	@ResponseBody
	public Map addClassPlan(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> info = new HashMap<String,Object>();
		info.put("years", map.get("planyear")+"");
		//处理所有活动，进行拼接
		int planSize = Integer.parseInt(map.get("planSize")+"");
		for (int i = 1; i <= planSize; i++) {
			
		}
		
		
		System.out.println(map);
		result.put("result", true);
		result.put("msg", "保存成功!");
		return result;
	}
	
	//--------------------教学内容-------------------
	@RequestMapping(value="/classContent")
	@Authorize(setting="课程-教学内容")
	public ModelAndView classContent(){
		Map<String,Object> map = danceClassService.selClassContent();
		return new ModelAndView("admin/class/classcontent/list",map);
	}
	@RequestMapping(value="/addClassContent")
	@ResponseBody
	public Map<String,Object> addClassContent(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String,Object>();
		String contentId = map.get("contentId")+"";
		int row = 0;
		if(StringUtils.isEmpty(contentId)){
			row = danceClassService.addClassContent(map);
		}else {
			row = danceClassService.updClassContent(map);
		}
		if(row>0){
			result.put("result", true);
			result.put("msg", "保存成功！");
		}else{
			result.put("result", false);
			result.put("msg", "保存失败！");
		}
		return result;
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
			countInfo = danceClassService.addClassPriceInfo(map);
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
	
	//-----------------------教学评估-----------------------
	@RequestMapping(value="/classAssessment")
	@Authorize(setting="课程-教学评估")
	public ModelAndView classAssessment(){
		return new ModelAndView("admin/class/classassessment/list");
	}
	
}
