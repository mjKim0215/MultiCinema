package com.mc.multicinema.user.service;

import java.util.List;

import com.mc.multicinema.user.dto.UserDTO;

public interface UserService {

	UserDTO loginProcess(String user_id, String user_pw);

	List<UserDTO> memberCheckProcess(String user_id, String user_email);

	int memberJoinProcess(UserDTO dto);

	List<UserDTO> selectUserAll();
		
	UserDTO selectUserOne(int user_key);
}