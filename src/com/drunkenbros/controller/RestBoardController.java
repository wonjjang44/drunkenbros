package com.drunkenbros.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.drunkenbros.model.service.BoardService;

@RestController
public class RestBoardController {
	@Autowired
	private BoardService boardService;
	

}
