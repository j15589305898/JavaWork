package com.sdut.hotel.pojo;

import lombok.*;

import java.util.Date;

//Create by IntelliJ IDEA.
//Have a good day!
//User: jiruichang
//Date: 2022/12/20
//Time: 11:14
@Data
//@Getter
//@Setter
//@NoArgsConstructor
//@AllArgsConstructor
public class User {
    private Integer id;
    private String name;
    private String password;
    private String loc;
    private String phone;
    private String avatar;
    private Integer status;
    private Integer deleted;        //逻辑删除
    private Date gmtCreate;         //创建时间
    private Date gmtModified;       //更新时间
    //1-超级管理员 2-普通管理员
    private Integer type;
}
