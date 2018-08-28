package cn.admin.teachers.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.admin.teachers.service.TeachersService;
import cn.core.Authorize;
import cn.util.Page;

/**
 * @author 李彤辉
 *
 * @data 2018年8月14日 下午3:52:30
 * 
 * @Title:教师列表 
 *
 */
@Controller
@RequestMapping(value="admin/teachers")
public class TeachersController {
	
	@Autowired
	TeachersService teachersService;
	
	@RequestMapping(value="/teacherListFace")
	@Authorize(setting="人员-教师列表")
	public ModelAndView teacherListFace(@RequestParam("type") int type){//1舞蹈  2美术
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("type", type);
		return new ModelAndView("/admin/teachers/list",map);
	}
	
	@RequestMapping(value="/teachersListData")
	@ResponseBody
	public Map<String,Object> teachersListData(HttpServletRequest request,@RequestParam Map search,int page,int limit){
		Map<String,Object> map = new HashMap<String,Object>();
		
		long totalCount = teachersService.selTotalCount(search);//总条数
		Page page2 = new Page(totalCount, page, limit);
		search.put("start", page2.getStartPos());
		search.put("pageSize", limit);
		String ruzhiTime = search.get("ruzhiTime")+"";
		String startTime = "";
		String endTime = "";
		if(!StringUtils.isEmpty(ruzhiTime) && !ruzhiTime.equals("null")) {
			String[] time = ruzhiTime.split("~");
			startTime = time[0];
			endTime = time[1].trim();
			
			search.put("startTime", startTime);
			search.put("endTime", endTime);
		}
		
		List<Map> list = teachersService.selTeacherList(search);//教师列表
		map.put("msg", "");
		map.put("code", 0);
		map.put("data", list);
		map.put("count", totalCount);
		
		return map;
	}
	
	//添加或编辑教师信息页面
	@RequestMapping(value="/addTeacherFace")
	public ModelAndView addTeacherFace(){
		Map<String,Object> map = new HashMap<String,Object>();
		return new ModelAndView("admin/teachers/add");
	}
	
	
}
