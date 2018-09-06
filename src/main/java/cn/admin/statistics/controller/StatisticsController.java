package cn.admin.statistics.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.admin.statistics.service.StatisticsService;

/**
 * @author 李彤辉
 *
 * @data 2018年9月3日 上午10:51:47
 * 
 * @Title:财务统计计算 
 *
 */
@Controller
@RequestMapping(value="admin/statistics")
public class StatisticsController {
	
	@Autowired
	StatisticsService statisticsService;
	
	@RequestMapping(value="/index")
	public ModelAndView statisticsIndex() {
		Map<String,Object> map = new HashMap<String, Object>();
		return new ModelAndView("admin/statistics/index",map);
	}
	
	
	
}
