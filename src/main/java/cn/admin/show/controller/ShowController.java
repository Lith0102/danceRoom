package cn.admin.show.controller;

import java.io.File;
import java.io.IOException;
import java.net.FileNameMap;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//查看教师视频
	@RequestMapping(value="/showIndex")
	@Authorize(setting="风采-教师视频,风采-教师照片,风采-学生视频,风采-学生照片")
	public ModelAndView videoIndex(@RequestParam("roleType") int roleType,@RequestParam("fileType") int fileType){
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("roleType", roleType);
		map.put("fileType", fileType);
		
		List<String> dateList = showService.selTimeList(map);
		List<Map> list = showService.selFileByType(map);
		
		map.put("dateList", dateList);
		map.put("list", list);
		return new ModelAndView("admin/show/videoIndex",map);
		
	}
	
	//上传文件
	@RequestMapping(value = "/uoloadVideo")
	@ResponseBody
	public Map<String, Object> uoloadVideo(@RequestParam("videoFile") MultipartFile file, HttpServletRequest request,@RequestParam("roleType") int roleType) throws IOException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		Map<String,Object> result = new HashMap<String, Object>();
		String fileName = file.getOriginalFilename();// 上传文件的名称
		
		//文件上传
		String filePath=Tools.getUploadDir();
		File pathFile = new File(filePath);//建文件夹
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		String newFileName = UUID.randomUUID().toString()+Tools.getFileExtension(file.getOriginalFilename());//获取excel名称
		String newFilePath = filePath + newFileName;// 新路径
		//System.out.println(newFilePath);
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
		map.put("fileName", fileName);
		//判断是否是图片
		FileNameMap fileNameMap = URLConnection.getFileNameMap();
	    String type = fileNameMap.getContentTypeFor(newFilePath);
	    if(type==null || type.equals("null")){
	    	map.put("fileType", 1);
	    	
	    	//视频生成缩略图
	    	//String videoRealPath = "D:/Object/danceroom/upload/20180921/275335be-2559-4eb6-9fb2-41997ed75cc7.mp4";
			// 截图的路径（输出路径）
			String newJTName = newFileName.substring(0,newFileName.indexOf("."))+".jpg";
			String imageRealPath = filePath + newJTName;
			createJT(newFilePath,newJTName,imageRealPath);
			
			map.put("jtUrl", "/upload/"+sdf.format(new Date())+"/"+newJTName);
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
	
	
	private void createJT(String newFilePath,String newJTName, String imageRealPath) throws IOException {
		Runtime rt = Runtime.getRuntime();
		Process ps = null;

		try {
			// 调用批处理文件
			
			ps = rt.exec("cmd /c start E://ffmpeg.bat " + newFilePath + " " + imageRealPath);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		int i = ps.exitValue();
//		if (i == 0) {
//			rt.exec("cmd.exe /C start wmic process where name='cmd.exe' call terminate");
//			System.out.println("执行完成.");
//		} else {
//			System.out.println("执行失败.");
//		}
//		ps.destroy();
//		ps = null;
 
		// 批处理执行完后，根据cmd.exe进程名称
		// kill掉cmd窗口
		
	}

	
}
