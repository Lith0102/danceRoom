package cn.admin.login.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Decoder.Text;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.AdminRewriteFilter;
import cn.admin.login.service.InitService;
import cn.admin.login.service.LoginService;
import cn.admin.system.service.RoleService;
import cn.core.Authorize;
import cn.util.GetIPLocation;
import cn.util.Tools;

@Controller
@EnableAutoConfiguration
@RequestMapping("/admin")
public class LoginController {
	@Autowired
	private RoleService roleService;
	@Autowired
	private HttpSession session;
	@Autowired
	private LoginService loginService;
	@Autowired
	private InitService initService;

	
	/**
	 * 跳转登录页面
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping(value = { "", "/login" })
	public ModelAndView goLogin(@RequestParam Map<String, Object> map) {
		if (session.getAttribute("loginUser") != null
				&& !StringUtils.isEmpty(session.getAttribute("loginUser").toString())) {
			return new ModelAndView("redirect:/" + AdminRewriteFilter.adminPrefix + "/index");
		}
		return new ModelAndView("/admin/login/newLogin", map);
	}

	/**
	 * @Description: 登录
	 */
	@RequestMapping(value = "/login/userLogin", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getUserInfo(@RequestParam Map<String, Object> login, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String name = (String) login.get("userName");
		String pwd = (String) login.get("userPwd");
		String code = (String) session.getAttribute("code");// 随机生成验证码
		String valiCode = (String) login.get("code");
		String loginMethod = String.valueOf(login.get("loginMethod"));
		if (StringUtils.isEmpty(name) || StringUtils.isEmpty(pwd)) {
			map.put("isLogin", false);
			map.put("message", "用户名或密码不得为空！");
			return map;

		} 
//		else if (StringUtils.isEmpty(valiCode)) {
//			map.put("isLogin", false);
//			map.put("message", "验证码不得为空！");
//			return map;
//		} 
//		else if (!valiCode.equalsIgnoreCase(code)) {
//			map.put("isLogin", false);
//			map.put("message", "验证码不正确！");
//			return map;
//		}
		else {
			// 密码加密
			String md5pwd = Tools.md5(pwd);
			login.put("userPwd", md5pwd);
			login.put("userType", 0);
			Map<String, Object> userMap = initService.login(login);
			if (userMap != null) {
				if ("0".equals(userMap.get("isFreeze").toString())) {
					map.put("isLogin", false);
					map.put("message", "该账户已被冻结！");
					return map;
				}
				session.setAttribute("userId", userMap.get("userId").toString());
				session.setAttribute("userType", userMap.get("userType").toString());
				session.setAttribute("loginUser", name);
				session.setAttribute("adminRealName", userMap.get("realname").toString());
				// 查询该用户拥有的权限放到session中
				List<String> Alist = roleService.selAuthorityByUserId(userMap.get("userId") + "");
				// 查询该用户的roleId
				List<String> roleId = roleService.selectRoleIdByUserId(userMap.get("userId") + "");
				session.setAttribute("AuthorityID", Alist);
				session.setAttribute("roleId", roleId);
				String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
				String ip = Tools.getIpAddr(request);
				login.put("userId", userMap.get("userId"));
				login.put("loginTime", time);
				login.put("loginIP", ip);
				login.put("ipAttribution", GetIPLocation.getLocation(ip));
				login.put("loginMethod", loginMethod);
				loginService.addLoginIP(login);// 更新最后登录时间、登录IP、登陆次数
				map.put("isLogin", true);
				return map;
			} else {
				map.put("isLogin", false);
				map.put("message", "用户名或密码错误！");
				return map;
			}
		}
	}

	/**
	 * 退出登录
	 */
	@RequestMapping("/login/loginOut")
	public ModelAndView loginOut() {
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			userId = (String) session.getAttribute("indexUserId");
		}
		session.invalidate();
		return new ModelAndView("/admin/login/timeout");
	}

}
