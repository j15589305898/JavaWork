package com.sdut.hotel.pojo.query;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;

//Create by IntelliJ IDEA.
//Have a good day!
//User: jiruichang
//Date: 2022/12/23
//Time: 10:40
@Data
@AllArgsConstructor
public class UserQuery {
    private Integer  page ;
    private Integer  limit ;
    private String  name ;
    private String  email ;
    private String  phone ;
    private Date beginDate;
    private Date endDate;
}
