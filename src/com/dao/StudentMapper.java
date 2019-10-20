package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bean.Student;

public interface StudentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Student record);

    int insertSelective(Student record);

    Student selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);
    
    List<Student> findAll(@Param("limit")Integer limit,@Param("offset") Integer offset,@Param("name")String name,@Param("score")String score);
    
    int selectCount(@Param("name")String name,@Param("score")String score);
}








