/*
 * Powered By cuichen
 * Since 2014 - 2015
 */
package com.seeyoui.kensite.framework.plugin.db.userTables.controller;  
 
import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seeyoui.kensite.common.base.controller.BaseController;
import com.seeyoui.kensite.common.constants.StringConstant;
import com.seeyoui.kensite.common.util.RequestResponseUtil;

import com.seeyoui.kensite.common.constants.StringConstant;
import com.seeyoui.kensite.common.base.domain.EasyUIDataGrid;
import com.seeyoui.kensite.common.base.controller.BaseController;
import com.seeyoui.kensite.common.util.RequestResponseUtil;
import com.seeyoui.kensite.framework.plugin.db.userTables.domain.UserTables;
import com.seeyoui.kensite.framework.plugin.db.userTables.service.UserTablesService;
/**
 * UserTables
 * @author cuichen
 * @version 1.0
 * @since 1.0
 * @date 2015-10-20
 */
@Controller
@RequestMapping(value = "sys/userTables")
public class UserTablesController extends BaseController {
	
	@Autowired
	private UserTablesService userTablesService;
	
	/**
	 * 展示列表页面
	 * @param modelMap
	 * @param module
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sys:userTables:view")
	@RequestMapping(value = "/showPageList")
	public ModelAndView showUserTablesPageList(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		return new ModelAndView("framework/plugin/db/userTables/userTables", modelMap);
	}
	
	/**
	 * 获取列表展示数据
	 * @param modelMap
	 * @param userTables
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sys:userTables:select")
	@RequestMapping(value = "/getListData", method=RequestMethod.POST)
	@ResponseBody
	public String getListData(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap, UserTables userTables) throws Exception{
		List<UserTables> userTablesList = userTablesService.findUserTablesList(userTables);
		EasyUIDataGrid eudg = userTablesService.findUserTablesListTotal(userTables);
		eudg.setRows(userTablesList);
		JSONObject jsonObj = JSONObject.fromObject(eudg);
		RequestResponseUtil.putResponseStr(session, response, request, jsonObj);
		return null;
	}
	
	/**
	 * 获取所有数据
	 * @param modelMap
	 * @param userTables
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sys:userTables:select")
	@RequestMapping(value = "/getAllListData", method=RequestMethod.POST)
	@ResponseBody
	public String getAllListData(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap, UserTables userTables) throws Exception{
		List<UserTables> userTablesList = userTablesService.findAllUserTablesList(userTables);
		JSONArray jsonObj = JSONArray.fromObject(userTablesList);
		RequestResponseUtil.putResponseStr(session, response, request, jsonObj);
		return null;
	}
	
}