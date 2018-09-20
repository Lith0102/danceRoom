package cn.admin.show.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.net.FileNameMap;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.admin.show.service.ShowService;
import cn.core.Authorize;
import cn.util.Tools;

@Controller
@RequestMapping(value="admin/show")
public class ShowController {
	
	
	@Autowired
	HttpSession session;
	@Autowired
	ShowService showService;
	
	@RequestMapping(value="/videoIndex")
	@Authorize(setting="风采-教师视频")
	public ModelAndView videoIndex(@RequestParam("roleType") int roleType) {//1教师 2学生
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("roleType", roleType);
		return new ModelAndView("/admin/show/videoIndex",map);
	}
	
	@RequestMapping(value = "/uoloadVideo")
	@ResponseBody
	public Map<String, Object> uoloadVideo(@RequestParam("videoFile") MultipartFile file, HttpServletRequest request,@RequestParam("roleType") int roleType) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		Map<String,Object> result = new HashMap<String, Object>();
		String fileName = file.getOriginalFilename();// 上传文件的名称
		
		String filePath=Tools.getUploadDir();
		File pathFile = new File(filePath);//建文件夹
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		String newFileName = UUID.randomUUID().toString()+Tools.getFileExtension(file.getOriginalFilename());//获取excel名称
		String newFilePath = filePath + newFileName;// 新路径
		File newFile = new File(newFilePath);
		try {
			file.transferTo(newFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String,Object> map = new HashMap<String, Object>();
		//添加数据库
		String fileUrl = "/upload/"+sdf.format(new Date())+"/"+newFileName;
		map.put("fileUrl", fileUrl);
		//判断是否是图片
		FileNameMap fileNameMap = URLConnection.getFileNameMap();
	    String type = fileNameMap.getContentTypeFor(newFilePath);
	    if(type==null || type.equals("null")){
	    	map.put("fileType", 1);
	    }else {
	    	map.put("fileType", 2);
	    }
	    map.put("roleType", roleType);
	    map.put("founder", session.getAttribute("userId"));
	    
	    int row = showService.addShowInfo(map);
		
	    if(row>0){
	    	result.put("result", true);
			result.put("msg", "上传成功！");
	    }else {
	    	result.put("result", false);
			result.put("msg", "上传失败！");
	    }
		
		return result;
	}

}
