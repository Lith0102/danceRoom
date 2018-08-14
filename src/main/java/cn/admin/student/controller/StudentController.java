package cn.admin.student.controller;

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

import cn.util.Page;
import cn.admin.student.service.StudentService;
import cn.core.Authorize;

/**
 * @author 李彤辉
 *
 * @data 2018年8月13日 上午11:48:56
 * 
 * @Title:学生管理模块 
 *
 */
@Controller
@RequestMapping(value="admin/student")
public class StudentController {
	
	@Autowired
	StudentService studentService;
	
	
	//学生列表页面
	@RequestMapping(value="/studentList")
	@Authorize(setting="人员-学生列表")
	public ModelAndView listFace(HttpServletRequest request,@RequestParam("type") int type) {
		//type 0缴费学生  1未交费学生
		Map<String,Object> map = new HashMap<String,Object>();
		List shopList = studentService.selShopList();//店铺列表
		List classList = studentService.selClassList();//班级列表
		map.put("shopList", shopList);
		map.put("classList", classList);
		map.put("type", type);
		return new ModelAndView("/admin/student/list",map);
	}
	
	//学生列表数据
	@RequestMapping(value="/studentListData")
	@ResponseBody
	public Map<String,Object> studentListData(HttpServletRequest request,@RequestParam Map search,int page, int limit){
		Map<String,Object> map = new HashMap<String,Object>();
		
		long totalCount = studentService.selTotalCount(search);//总条数
		Page page2 = new Page(totalCount, page, limit);
		search.put("start", page2.getStartPos());
		search.put("pageSize", limit);
		String ruxueTime = search.get("ruxueTime")+"";
		String startTime = "";
		String endTime = "";
		if(!StringUtils.isEmpty(ruxueTime) && !ruxueTime.equals("null")) {
			String[] time = ruxueTime.split("~");
			startTime = time[0];
			endTime = time[1].trim();
		}
		search.put("startTime", startTime);
		search.put("endTime", endTime);
		
		List<Map> list = studentService.selStudentList(search);//学生列表
		map.put("msg", "");
		map.put("code", 0);
		map.put("data", list);
		map.put("count", totalCount);
		
		return map;
	}
	
	//添加编辑学生页面
	@RequestMapping(value="/addStudentFace")
	public ModelAndView addStudentFace() {
		Map<String,Object> map = new HashMap<String,Object>(); 
		List shopList = studentService.selShopList();//店铺列表
		List classList = studentService.selClassList();//班级列表
		map.put("shopList", shopList);
		map.put("classList", classList);
		return new ModelAndView("admin/student/addStu",map);
	}
	
	
}
