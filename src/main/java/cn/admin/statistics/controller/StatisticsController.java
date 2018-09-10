package cn.admin.statistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value="/calculation")
	@ResponseBody
	public Map<String,Object> calculation(@RequestParam Map search){
		Map<String,Object> map = new HashMap<String, Object>();
		//查询已缴费的学生
		List<Map> stuIsPayList = statisticsService.calculationStudentPay(search);
		double totalStuMoney = 0;//所有学生缴费总额
		for (int i = 0; i < stuIsPayList.size(); i++) {
			Map<String,Object> info = stuIsPayList.get(i);
			double classPrice = statisticsService.selClassPrice(info);
			totalStuMoney += classPrice;
		}
		map.put("totalStuMoney", totalStuMoney);
		
		//查询活动收入
		
		//购买支出
		
		return map;
	}
	
}
