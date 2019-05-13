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
	// �Խ��� ������������ ������ ����
	@RequestMapping(value = "/board/board-edit", method = RequestMethod.POST)
	public ModelAndView goEditPage(Board board) {
		System.out.println("BoardController/geEditpage() ������������! ȣ��");
		ModelAndView mav = new ModelAndView("board/board-edit");
		mav.addObject("board", board);
		return mav;
	}

	// �Խ��� ����������� ������ ����
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
	// �Խ��� List ��������
	@RequestMapping(value = "/boards", method = RequestMethod.GET)
	public ModelAndView selectAll(HttpServletRequest request) {
		System.out.println("BoardController/selectAll() ȣ��");
		List<Board> boardList = boardService.selectAll();
		// board�� member ������ ������ ���� �ʾƼ� mapper ������

		Pager pager = new Pager();

		pager.init(request, boardList.size(), 15, 10);

		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.addObject("pager", pager);
		mav.setViewName("board/board");
		return mav;
	}

	// �Խ��� �Ѱ� ��������
	@RequestMapping(value = "/board/detail", method = RequestMethod.GET)
	public ModelAndView select(int board_id,HttpServletRequest request) {
		System.out.println("BoardController/select() ȣ�� : �Խ��� �Ѱ� ��������");
		System.out.println("BoardController/select() �Ѱܹ��� board_id�� : " + board_id);
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
		System.out.println("BoardController/insert() ȣ��!");

		//Member member = (Member) request.getSession().getAttribute("member");
		System.out.println("BoardController �α����� ����� ���̵�� : " + member_id);
		Member loginMember=new Member();
		loginMember.setMember_id(member_id);
		board.setMember(loginMember);
		boardService.insert(board);

		return "redirect:/boards";
	}

	@RequestMapping(value = "/board/edit", method = RequestMethod.POST)
	public String update(Board board) {
		System.out.println("BoardController/update() �Ѿ�� ��: " + board.getBoard_id() + board.getTitle());
		boardService.update(board);;
		return "redirect:/board/detail?board_id=" + board.getBoard_id();// redirect�� ���̸� ViewResolver����
	}

	@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
	public String delete(int board_id) {
		int result = boardService.delete(board_id);
		return "redirect:/boards";
	}

	// ����+�������� �˻�
	@RequestMapping(value = "/board/search_TC", method = RequestMethod.GET)
	public ModelAndView search_TC(String searching) {
		System.out.println("search_TC�Լ� ȣ��");
		List boardList = boardService.search_TC("%" + searching + "%");
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.setViewName("board/board");
		return mav;
	}

	// �������θ� �˻�
	@RequestMapping(value = "/board/search", method = RequestMethod.GET)
	public ModelAndView search(String searching) {
		System.out.println("boardController search() ȣ��!!");
		List boardList = boardService.search("%" + searching + "%");
		System.out.println(searching);
		ModelAndView mav = new ModelAndView();
		System.out.println("�˻��� �Խù� ����" + boardList.size());
		mav.addObject("boardList", boardList);
		mav.setViewName("board/board");
		return mav;
	}

	// ��� ��� ����
	@RequestMapping(value = "/board/comments", method = RequestMethod.GET)
	@ResponseBody
	public String selectAll(@RequestParam("board_id") int board_id) {
		System.out.println("selectAll " + board_id);
		List commentList = boardService.commentsSelectAll(board_id);
		System.out.println("BoardController/selectAll() ��� �ߴ�?" + commentList.size());
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

	// ��� �Ѱ� ���
	@RequestMapping(value = "/board/insertComments", method = RequestMethod.POST)
	@ResponseBody // �갡 ������ ������ ��Ʈ������ ���� �Ѿ
	public String insertComments(Comments comments, HttpServletRequest request) {
		Board board = new Board();
		Member member = new Member();
		board.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		// member.setMember_id(Integer.parseInt(request.getParameter("member_id")));
		member = (Member) request.getSession().getAttribute("member");

		comments.setBoard(board);
		comments.setMember(member);
		System.out.println("�� �Ѱܹ��� comments.msg : " + comments.getMsg());
		System.out.println("�� �Ѱܹ��� comments.member_id : " + comments.getMember().getMember_id());
		System.out.println("�� �Ѱܹ��� comments.board_id : " + comments.getBoard().getBoard_id());
		String json = boardService.insertComments(comments);
		JSONParser jsonParser = new JSONParser();
		JSONObject parseJSON = null;
		try {
			parseJSON = (JSONObject) jsonParser.parse(json);
			System.out.println(parseJSON.get("writer"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println("�� �Ѱܹ��� ��  " + json);
		// if ������ insert �� �����ߴٸ� ===> �������� �츮�� Ŭ���̾�Ʈ���� �������� ������ ��ȸ�� �����
		// ajax�̱� ������,Ŭ���̾�Ʈ���� result�� ������ �ְ� JSON�� ��������!
		// �� json�� ���±����� ��� ����Ʈ , �Խñ� ������ ��� �־����. �߰��� ������ �Խñ۰� ��ۿ� ������ �� �� �ֱ⶧���� ���ο��
		// �޾ƿͼ� �����������.
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"member_id\":\"" + comments.getMember().getMember_id() + "\"");
		sb.append(",\"writer\":\"" + parseJSON.get("writer").toString() + "\"");
		sb.append(",\"msg\":\"" + comments.getMsg() + "\"");
		sb.append(",\"cregdate\":\"" + parseJSON.get("cRegdate").toString().substring(0, 10) + "\"");
		sb.append("}");
		System.out.println("���� �ۼ��� ���̽�ģ���� : " + sb.toString());

		return sb.toString();
	}

	// ��� �Ѱ� ����
	@RequestMapping(value = "/board/oneCommentsDel", method = RequestMethod.GET)
	public String oneCommentsDel(int comments_id) {
		boardService.oneCommenstDel(comments_id);
		return "redirect:board/detail";
	}

//   //���ۼ��� �˻�
//   @RequestMapping(value="",method=RequestMethod.GET)
//   public ModelAndView search_writer() {
//      
//      return null;
//   }
//   
//   //��۳��� �˻�
//   @RequestMapping(value="",method=RequestMethod.GET)
//   public ModelAndView search_comment() {
//      
//      return null;
//   }
//   
//   //����ۼ��� �˻�
//   @RequestMapping(value="",method=RequestMethod.GET)
//   public ModelAndView search_cWriter() {
//      
//      return null;
//   }

}