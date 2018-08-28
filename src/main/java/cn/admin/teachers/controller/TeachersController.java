package cn.admin.teachers.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.admin.teachers.service.TeachersService;
import cn.core.Authorize;
import cn.util.Page;
import cn.util.Tools;

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
	
	//教师列表页面
	@RequestMapping(value="/teacherListFace")
	@Authorize(setting="人员-教师列表")
	public ModelAndView teacherListFace(@RequestParam("type") int type){//1舞蹈  2美术
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("type", type);
		return new ModelAndView("/admin/teachers/list",map);
	}
	
	//教师列表数据
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
	public ModelAndView addTeacherFace(@RequestParam Map map){
		//根据教师id查询信息
		String type = map.get("type")+"";
		String teaId = map.get("teacherId")+"";
		if(!StringUtils.isEmpty(teaId)) {
			map = teachersService.selTeacherById(teaId);
			map.put("type", type);
			map.put("teacherId", teaId);
		}
		return new ModelAndView("admin/teachers/add",map);
	}
	
	//教师照片上传
	@RequestMapping(value="/photoUpload")
	@ResponseBody
	public Map<String,Object> photoUpload(@RequestParam("photoUpload") MultipartFile file, HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		String savePath=Tools.getUploadDir();
		String newFileName =UUID.randomUUID().toString()+Tools.getFileExtension(file.getOriginalFilename());//文件名
		
		File pathFile = new File(savePath);// 建文件夹
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		String newFilePath = savePath + newFileName;// 新路径
		File newFile = new File(newFilePath);
		if (newFile.exists()) {
			newFilePath = savePath + newFileName;
			newFile = new File(newFilePath);
		}
		try {
			file.transferTo(newFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		map.put("photoUrl", "/upload/"+sdf.format(new Date())+"/"+newFileName);
		return map;
	}
	
	//添加或修改教师信息
	@RequestMapping(value="/addTeachersInfo")
	@ResponseBody
	public Map<String,Object> addTeachersInfo(HttpServletRequest request,@RequestParam Map info){
		Map<String,Object> result = new HashMap<String,Object>();
		int type = Integer.parseInt(info.get("type")+"");
		String teacherId = info.get("teacherId")+"";
		int row = 0;
		if(type==1){//添加
			row = teachersService.addTeacherInfo(info);
		}else {//编辑
			row = teachersService.updTeacherInfo(info);
		}
		
		if(row>0) {
			result.put("result", true);
			result.put("msg", "操作成功！");
		}else {
			result.put("result", false);
			result.put("msg", "操作失败！");
		}
		
		return result;
	}
	
}
