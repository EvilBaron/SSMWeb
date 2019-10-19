package com.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bean.Student;
import com.dao.GradeMapper;
import com.dao.StudentMapper;

@Controller
@RequestMapping("/stu")
public class StudentController {
	@Autowired	
	StudentMapper studentMapper;
	
	
	@RequestMapping("/selectStus")
	@ResponseBody
	//public List<Student> selectStudens(){
	public String selectStudens(Integer limit, Integer offset,String name,String score){
		//返回的json格式中，必须要包含total和rows两个参数
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", studentMapper.selectCount(name, score));
		map.put("rows", studentMapper.findAll(limit,offset,name,score));
		return JSON.toJSONString(map);
	}
	
	
	@RequestMapping("/del")
	@ResponseBody
	public String delStudent(Integer id){
		Object obj = true;
		try{
			studentMapper.deleteByPrimaryKey(id);
		}catch (Exception e) {
			obj = false;
		}
		return JSON.toJSONString(obj);
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public String save(Student s){
		Object obj = true;
		try{
			if(s.getId()==null){
				studentMapper.insert(s);
			}else {
				studentMapper.updateByPrimaryKey(s);
			}
		}catch (Exception e) {
			obj = false;
		}
		return JSON.toJSONString(obj);
	}
	
	
	
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		// 注意 2012-12-02 和 2012-22-12(将变成 2013-10-12 做进制转换)
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				new SimpleDateFormat("yyyy-MM-dd"), true));
	}
}










