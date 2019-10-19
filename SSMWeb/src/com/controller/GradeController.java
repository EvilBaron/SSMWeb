package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.dao.GradeMapper;

@Controller
@RequestMapping("/grade")
public class GradeController {
	@Autowired
	GradeMapper gradeMapper;
	
	@RequestMapping("/list")
	@ResponseBody
	public String list(){
		return JSON.toJSONString(gradeMapper.findAll());
	}
	
	
}
