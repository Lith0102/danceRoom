package cn.admin.finance.controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
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

import cn.admin.danceClass.service.DanceClassService;
import cn.admin.finance.service.FinanceService;
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
@RequestMapping(value="admin/finance")
public class FinanceController {

	@Autowired
	FinanceService financeService;
	@Autowired
	DanceClassService danceClassService;
	
	//------------------------购买支出模块--------------------------
	
	//购买支出页面
	@RequestMapping(value="/expenditureList")
	public ModelAndView expenditureFace() {
		return new ModelAndView("admin/finance/expenditure/list");
	}
	
	//购买支出数据
	@RequestMapping(value="/expenditureLiatData")
	@ResponseBody
	public Map<String,Object> expenditureLiatData(HttpServletRequest request,@RequestParam Map search,int page, int limit){
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		long totalCount = financeService.selTotalCount(search);//总条数
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
		
		List<Map> list = financeService.selZhiChuList(search);//学生列表
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
		if(!StringUtils.isEmpty(infoId)) {
			map = financeService.selZhiChuInfoById(infoId);
			map.put("infoId", infoId);
		}else{
			map.put("infoId", "");
		}
		
		return new ModelAndView("admin/finance/expenditure/add",map);
		
	}
	//添加或修改支出记录
	@RequestMapping(value="/addORupdZCInfo")
	@ResponseBody
	public Map<String,Object> addORupdZCInfo(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String,Object>();
		String infoId = map.get("infoId")+"";
		int row = 0;
		if(StringUtils.isEmpty(infoId)){//添加
			row = financeService.addExpenseInfo(map);
		}else { //修改
			row = financeService.updExpenseInfo(map);
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
		int row = financeService.delZhiChuInfo(infoId);
		if(row>0){
			map.put("result", true);
			map.put("msg", "删除成功！");
		}else {
			map.put("result", false);
			map.put("msg", "删除失败！");
		}
		return map;
	}
	
	//------------------------------财务统计计算模块--------------------------
	
	@RequestMapping(value="/index")
	public ModelAndView statisticsIndex() {
		Map<String,Object> map = new HashMap<String, Object>();
		return new ModelAndView("admin/finance/statistics/calculation",map);
	}
	
	@RequestMapping(value="/calculation")
	@ResponseBody
	public Map<String,Object> calculation(@RequestParam Map search){
		Map<String,Object> map = new HashMap<String, Object>();
		//查询已缴费的学生
		List<Map> stuIsPayList = financeService.calculationStudentPay(search);
		double totalStuMoney = 0;//所有学生缴费总额
		for (int i = 0; i < stuIsPayList.size(); i++) {
			Map<String,Object> info = stuIsPayList.get(i);
			double classPrice = financeService.selClassPrice(info);
			totalStuMoney += classPrice;
		}
		map.put("totalStuMoney", totalStuMoney);
		
		//查询活动收入
		int jsType = Integer.parseInt(search.get("jsType")+"");//计算类型
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		SimpleDateFormat mm = new SimpleDateFormat("MM");
		Date now = new Date();
		String nowYear = sdf.format(now);//当前年份
		int onlyMonth = Integer.parseInt(mm.format(now));//当前月份
		Map<String,Object> planmap = danceClassService.selPlanInfo(nowYear);
		String planText = planmap.get("plan")+"";//获取计划内容的json串
		List<Map> planList = net.sf.json.JSONArray.fromObject(planText);
		double totalActivityMoney = 0;
		for (int i = 0; i < planList.size(); i++) {
			
			//获取活动的月份
			int activityMonth = Integer.parseInt(planList.get(i).get("activityTime").toString().split("-")[1]);
			//获取活动的收益金额
			double activityIncome = Double.valueOf(planList.get(i).get("profit")+"");
			int result = getQuarter(onlyMonth);
			if(jsType==1) {//按季度查询
				if(result==1 && activityMonth>=1 && activityMonth<=3) {//1季度
					totalActivityMoney += activityIncome;
				}else if(result==2 && activityMonth>=4 && activityMonth<=6) {//2季度
					totalActivityMoney += activityIncome;
				}else if(result==3 && activityMonth>=7 && activityMonth<=9){//3季度
					totalActivityMoney += activityIncome;
				}else if(result==4 && activityMonth>=10 && activityMonth<=12) {//4季度
					totalActivityMoney += activityIncome;
				}
			}else if(jsType==2) {//上半年
				if(activityMonth>=1 && activityMonth<=6){
					totalActivityMoney += activityIncome;
				}
			}else if(jsType==3) {//下半年
				if(activityMonth>=7 && activityMonth<=12){
					totalActivityMoney += activityIncome;
				}
			}else if(jsType==4) {//本年
				totalActivityMoney += activityIncome;
			}
			
		}
		map.put("totalActivityMoney", totalActivityMoney);
		
		//购买支出
		double buyMoney = financeService.selBuyMoney(search);
		map.put("buyMoney", buyMoney);
		
		//最后总盈利
		double profit = totalStuMoney+totalActivityMoney-buyMoney;
		map.put("profit", profit);
		
		SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
		map.put("nowYmd", ymd.format(now));
		return map;
	}
	
	//获取季度
	public int getQuarter(int month){
		
		Integer[] quarterArr1 = new Integer[] { 1, 2, 3};
		List<Integer> quarterList1 = Arrays.asList(quarterArr1);
		Integer[] quarterArr2 = new Integer[] { 4, 5, 6};
		List<Integer> quarterList2 = Arrays.asList(quarterArr2);
		Integer[] quarterArr3 = new Integer[] { 7, 8, 9};
		List<Integer> quarterList3 = Arrays.asList(quarterArr3);
		Integer[] quarterArr4 = new Integer[] { 10, 11, 12};
		List<Integer> quarterList4 = Arrays.asList(quarterArr4);
		
		int result = 0;
		if(quarterList1.contains(month)) {
			result = 1;
		}else if(quarterList2.contains(month)) {
			result = 2;
		}else if(quarterList3.contains(month)) {
			result = 3;
		}else if(quarterList4.contains(month)) {
			result = 4;
		}
		return result;
		
	}
	
	//保存统计结果
	@RequestMapping(value="/addStatisticsInfo")
	@ResponseBody
	public Map<String,Object> addStatisticsInfo(@RequestParam Map map){
		Map<String,Object> result = new HashMap<String, Object>();
		int row = financeService.addStatisticsInfo(map);
		if(row>0) {
			result.put("result", true);
			result.put("msg","保存成功！");
		}else {
			result.put("result", false);
			result.put("msg","保存失败！");
		}
		return result;
	}
	
	//统计结果页面展示
	@RequestMapping(value="/statisticsList")
	public ModelAndView statisticsList(){
		return new ModelAndView("admin/finance/statistics/list");
	}
	
	//统计结果数据
	@RequestMapping(value="/statisticsListData")
	@ResponseBody
	public Map<String,Object> statisticsListData(HttpServletRequest request,@RequestParam Map search,int page, int limit){
		Map<String,Object> map = new HashMap<String,Object>();
		
		long totalCount = financeService.selTJInfoTotalCount(search);//总条数
		Page page2 = new Page(totalCount, page, limit);
		search.put("start", page2.getStartPos());
		search.put("pageSize", limit);
		
		String tjTime = search.get("tjTime")+"";
		String startTime = "";
		String endTime = "";
		if(!StringUtils.isEmpty(tjTime) && !tjTime.equals("null")) {
			String[] time = tjTime.split("~");
			startTime = time[0];
			endTime = time[1].trim();
			
			search.put("startTime", startTime);
			search.put("endTime", endTime);
		}
		
		List<Map> list = financeService.selStatisticsList(search);//统计列表
		map.put("msg", "");
		map.put("code", 0);
		map.put("data", list);
		map.put("count", totalCount);
		
		return map;
	}
	
	//删除统计信息
	@RequestMapping(value="/delStatistics")
	@ResponseBody
	public Map<String,Object> delStatistics(@RequestParam("infoId") int infoId){
		Map<String,Object> result = new HashMap<String, Object>();
		int row = financeService.delStatistics(infoId);
		if(row>0){
			result.put("result", true);
			result.put("msg", "删除成功！");
		}else {
			result.put("result", false);
			result.put("msg", "删除失败！");
		}
		
		return result;
	}
	
	
}
