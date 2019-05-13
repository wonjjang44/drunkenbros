package com.drunkenbros.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.drunkenbros.common.Pager;
import com.drunkenbros.model.domain.Board;
import com.drunkenbros.model.domain.Comments;
import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;

	/*******************************************************
	 * Board Page Mapping
	 *******************************************************/
	// 게시판 수정페이지로 가도록 매핑
	@RequestMapping(value = "/board/board-edit", method = RequestMethod.POST)
	public ModelAndView goEditPage(Board board) {
		System.out.println("BoardController/geEditpage() 수정페이지로! 호출");
		ModelAndView mav = new ModelAndView("board/board-edit");
		mav.addObject("board", board);
		return mav;
	}

	// 게시판 등록페이지로 가도록 매핑
	@RequestMapping(value = "/board/board-regist", method = RequestMethod.GET)
	public ModelAndView goRegistPage(HttpSession session) {
		Member loginMember=(Member)session.getAttribute("member");
		ModelAndView mav=new ModelAndView();
		if(loginMember==null) {
			mav.setViewName("redirect:/boards");
			return mav;
		}
		mav.setViewName("board/board-regist");
		return mav;
	}
	

	/*******************************************************
	 * Board
	 *******************************************************/
	// 게시판 List 가져오기
	@RequestMapping(value = "/boards", method = RequestMethod.GET)
	public ModelAndView selectAll(HttpServletRequest request) {
		System.out.println("BoardController/selectAll() 호출");
		List<Board> boardList = boardService.selectAll();
		// board가 member 정보를 가지고 있지 않아서 mapper 수정함

		Pager pager = new Pager();

		pager.init(request, boardList.size(), 15, 10);

		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.addObject("pager", pager);
		mav.setViewName("board/board");
		return mav;
	}

	// 게시판 한건 가져오기
	@RequestMapping(value = "/board/detail", method = RequestMethod.GET)
	public ModelAndView select(int board_id,HttpServletRequest request) {
		System.out.println("BoardController/select() 호출 : 게시판 한건 가져오기");
		System.out.println("BoardController/select() 넘겨받은 board_id는 : " + board_id);
		Board board = boardService.select(board_id);
		int result = boardService.updateHit(board_id);
		List commentsList = boardService.commentsSelectAll(board_id);
		
		Pager pager=new Pager();
		
		pager.init(request, commentsList.size(), 10, 10);

		// System.out.println("commentsList : "+commentsList.get(0));
		System.out.println("BoardController : select() : board : " + board);
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", board);
		mav.addObject("commentsList", commentsList);
		mav.addObject("pager",pager);
		mav.setViewName("board/board-detail");
		return mav;
	}

	@RequestMapping(value = "/board/regist", method = RequestMethod.POST)
	public String insert(Board board, int member_id, HttpServletRequest request) {
		System.out.println("BoardController/insert() 호출!");

		//Member member = (Member) request.getSession().getAttribute("member");
		System.out.println("BoardController 로그인한 멤버의 아이디는 : " + member_id);
		Member loginMember=new Member();
		loginMember.setMember_id(member_id);
		board.setMember(loginMember);
		boardService.insert(board);

		return "redirect:/boards";
	}

	@RequestMapping(value = "/board/edit", method = RequestMethod.POST)
	public String update(Board board) {
		System.out.println("BoardController/update() 넘어온 값: " + board.getBoard_id() + board.getTitle());
		boardService.update(board);;
		return "redirect:/board/detail?board_id=" + board.getBoard_id();// redirect를 붙이면 ViewResolver무시
	}

	@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
	public String delete(int board_id) {
		int result = boardService.delete(board_id);
		return "redirect:/boards";
	}

	// 제목+내용으로 검색
	@RequestMapping(value = "/board/search_TC", method = RequestMethod.GET)
	public ModelAndView search_TC(String searching) {
		System.out.println("search_TC함수 호출");
		List boardList = boardService.search_TC("%" + searching + "%");
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.setViewName("board/board");
		return mav;
	}

	// 제목으로만 검색
	@RequestMapping(value = "/board/search", method = RequestMethod.GET)
	public ModelAndView search(String searching) {
		System.out.println("boardController search() 호출!!");
		List boardList = boardService.search("%" + searching + "%");
		System.out.println(searching);
		ModelAndView mav = new ModelAndView();
		System.out.println("검색한 게시물 갯수" + boardList.size());
		mav.addObject("boardList", boardList);
		mav.setViewName("board/board");
		return mav;
	}

	// 모든 댓글 띄우기
	@RequestMapping(value = "/board/comments", method = RequestMethod.GET)
	@ResponseBody
	public String selectAll(@RequestParam("board_id") int board_id) {
		System.out.println("selectAll " + board_id);
		List commentList = boardService.commentsSelectAll(board_id);
		System.out.println("BoardController/selectAll() 통과 했니?" + commentList.size());
		JSONArray json = new JSONArray();

		for (int i = 0; i < commentList.size(); i++) {
			Comments comments = (Comments) commentList.get(i);
			JSONObject json2 = new JSONObject();
			json2.put("msg", comments.getMsg());
			// json2.put("writer",comments.getMember().getName());
			json2.put("cregdate", comments.getCregdate());
			json.add(json2);
		}
		return json.toString();
	}

	// 댓글 한건 등록
	@RequestMapping(value = "/board/insertComments", method = RequestMethod.POST)
	@ResponseBody // 얘가 붙으면 무조건 스트링으로 값이 넘어가
	public String insertComments(Comments comments, HttpServletRequest request) {
		Board board = new Board();
		Member member = new Member();
		board.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		// member.setMember_id(Integer.parseInt(request.getParameter("member_id")));
		member = (Member) request.getSession().getAttribute("member");

		comments.setBoard(board);
		comments.setMember(member);
		System.out.println("▶ 넘겨받은 comments.msg : " + comments.getMsg());
		System.out.println("▶ 넘겨받은 comments.member_id : " + comments.getMember().getMember_id());
		System.out.println("▶ 넘겨받은 comments.board_id : " + comments.getBoard().getBoard_id());
		String json = boardService.insertComments(comments);
		JSONParser jsonParser = new JSONParser();
		JSONObject parseJSON = null;
		try {
			parseJSON = (JSONObject) jsonParser.parse(json);
			System.out.println(parseJSON.get("writer"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println("▶ 넘겨받은 값  " + json);
		// if 위에서 insert 가 성공했다면 ===> 이제부터 우리는 클라이언트에게 브라우저를 갱신할 기회를 줘야해
		// ajax이기 때문에,클라이언트에서 result로 받을수 있게 JSON을 보내주자!
		// 이 json은 여태까지의 댓글 리스트 , 게시글 정보를 담고 있어야함. 중간에 누군가 게시글과 댓글에 변동을 줄 수 있기때문에 새로운걸
		// 받아와서 제공해줘야함.
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"member_id\":\"" + comments.getMember().getMember_id() + "\"");
		sb.append(",\"writer\":\"" + parseJSON.get("writer").toString() + "\"");
		sb.append(",\"msg\":\"" + comments.getMsg() + "\"");
		sb.append(",\"cregdate\":\"" + parseJSON.get("cRegdate").toString().substring(0, 10) + "\"");
		sb.append("}");
		System.out.println("내가 작성한 제이슨친구들 : " + sb.toString());

		return sb.toString();
	}

	// 댓글 한건 삭제
	@RequestMapping(value = "/board/oneCommentsDel", method = RequestMethod.GET)
	public String oneCommentsDel(int comments_id) {
		boardService.oneCommenstDel(comments_id);
		return "redirect:board/detail";
	}

//   //글작성자 검색
//   @RequestMapping(value="",method=RequestMethod.GET)
//   public ModelAndView search_writer() {
//      
//      return null;
//   }
//   
//   //댓글내용 검색
//   @RequestMapping(value="",method=RequestMethod.GET)
//   public ModelAndView search_comment() {
//      
//      return null;
//   }
//   
//   //댓글작성자 검색
//   @RequestMapping(value="",method=RequestMethod.GET)
//   public ModelAndView search_cWriter() {
//      
//      return null;
//   }

}