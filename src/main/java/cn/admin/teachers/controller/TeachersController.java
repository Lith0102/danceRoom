package cn.admin.teachers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cn.core.Authorize;

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
	
	@RequestMapping(value="/teacherListFace")
	@Authorize(setting="人员-教师列表")
	public ModelAndView teacherListFace(@RequestParam("type") int type){//1舞蹈  2美术
		return new ModelAndView("/admin/teachers/list");
	}
	
}
