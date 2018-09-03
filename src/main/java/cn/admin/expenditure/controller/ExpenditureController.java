package cn.admin.expenditure.controller;

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

import cn.admin.expenditure.service.ExpenditureService;
import cn.util.Page;

/**
 * @author 李彤辉
 *
 * @data 2018年8月31日 上午9:57:18
 * 
 * @Title: 购买支出记录列表
 *
 */
@Controller
@RequestMapping(value="admin/expenditure")
public class ExpenditureController {

	@Autowired
	ExpenditureService expenditureService;
	
	
	//购买支出页面
	@RequestMapping(value="/expenditureList")
	public ModelAndView expenditureFace() {
		return new ModelAndView("admin/expenditure/list");
	}
	
	//购买支出数据
	@RequestMapping(value="/expenditureLiatData")
	@ResponseBody
	public Map<String,Object> expenditureLiatData(HttpServletRequest request,@RequestParam Map search,int page, int limit){
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		long totalCount = expenditureService.selTotalCount(search);//总条数
		Page page2 = new Page(totalCount, page, limit);
		search.put("start", page2.getStartPos());
		search.put("pageSize", limit);
		
		String zhichuTime = search.get("zhichuTime")+"";
		String startTime = "";
		String endTime = "";
		if(!StringUtils.isEmpty(zhichuTime) && !zhichuTime.equals("null")) {
			String[] time = zhichuTime.split("~");
			startTime = time[0];
			endTime = time[1].trim();
			
			search.put("startTime", startTime);
			search.put("endTime", endTime);
		}
		
		List<Map> list = expenditureService.selZhiChuList(search);//学生列表
		map.put("msg", "");
		map.put("code", 0);
		map.put("data", list);
		map.put("count", totalCount);
		
		return map;
	}
	//添加或修改支出记录页面
	@RequestMapping(value="/addORupdZC")
	public ModelAndView addORupdZC(HttpServletRequest request) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		String infoId = request.getParameter("infoId")+"";
		map = expenditureService.selZhiChuInfoById(infoId);
				
		map.put("infoId", infoId);
				
		return new ModelAndView("admin/expenditure/add",map);
		
	}
	//添加或修改支出记录
	@RequestMapping(value="/addORupdZCInfo")
	@ResponseBody
	public Map<String,Object> addORupdZCInfo(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String,Object>();
		String infoId = map.get("infoId")+"";
		int row = 0;
		if(StringUtils.isEmpty(infoId)){//添加
			row = expenditureService.addExpenseInfo(map);
		}else { //修改
			row = expenditureService.updExpenseInfo(map);
		}
		if(row>0){
			result.put("result", true);
			result.put("msg", "保存成功！");
		}else {
			result.put("result", false);
			result.put("msg", "保存失败！");
		}
		return result;
	}
	
	//假删除支出记录
	@RequestMapping(value="/delZhiChuInfo")
	@ResponseBody
	public Map<String,Object> delZhiChuInfo(@RequestParam("infoId") int infoId){
		Map<String,Object> map = new HashMap<String, Object>();
		int row = expenditureService.delZhiChuInfo(infoId);
		if(row>0){
			map.put("result", true);
			map.put("msg", "删除成功！");
		}else {
			map.put("result", false);
			map.put("msg", "删除失败！");
		}
		return map;
	}
	
	
	
}
