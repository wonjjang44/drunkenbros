package com.drunkenbros.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.web.servlet.ModelAndView;

@Aspect
public class AdminSessionAspect {
	//로그인 페이지는 aop한테 간섭당하면 안됨!
	String[] exceptList= {
			"/admin"
	};
	
	//적용할 메서드 이름 검토 조심할 것
	@Pointcut("execution(public * com.drunkenbros.controller.AdminMainController.admin*(..))")
	public void checkAdminMain() {}
	@Pointcut("execution(public * com.drunkenbros.controller.MemberController.admin*(..))")
	public void checkAdminMemberPage() {}
	@Pointcut("execution(public * com.drunkenbros.controller.AlcoholController.admin*(..))")
	public void checkAdminAlcoholPage() {}
	
	
	//=====================================================
	// 관리자 페이지에서 유저가 로그인 했는지 & 로그인한 사람의 권한이 관리자가 맞는지 체크하자.
	//=====================================================
	@Around("checkAdminMemberPage() || checkAdminAlcoholPage()")
	public ModelAndView adminLoginCheck(ProceedingJoinPoint joinPoint)  throws Throwable{
		System.out.println("aop 작동");
		
		Object[] objArray=joinPoint.getArgs();
		HttpServletRequest request=null;
		String requestURL=null;
		ModelAndView mav=new ModelAndView();
			
		int count=0;
		//모든 매개변수를 조사 - 왜? 리퀘스트 객체 꺼내오려고
		for(Object obj : objArray) {
			if(obj instanceof HttpServletRequest) {
				request=(HttpServletRequest)obj;
				requestURL=request.getRequestURI().toString();
				System.out.println("AdminSessionAspect/adminLoginCheck/requestURL : "+requestURL);//여기까진 찍힘
				
				for(int i=0; i<exceptList.length; i++) {
					if(requestURL.endsWith(exceptList[i])) {
						count++;//제외명단 걸리면 카운트
					}
				}
			}
			
			//admin 관련 메서드 호출시마다 로그인 했는지 체크해보자.
			if(request!=null && count <1) {
				//request도 있고 예외 페이지도 아님
				if(request.getSession().getAttribute("loginAdmin")==null) {//로그인을 안했네?
					System.out.println("Aop: admin 로그인을 안하셨네요!");
					mav.setViewName("redirect:/admin");
				}else {
					System.out.println("Aop: 관리자 로그인을 하셨네요!!");
					
					mav=(ModelAndView)joinPoint.proceed();
					String methodName=joinPoint.getSignature().getName();	//호출 메서드 이름 찍어보려고
					//System.out.println("AOP 왈 로그인 필요한 페이지! : "+methodName+", 메서드의 반환 값은 : "+mav);
				}
			}else {
				//request는 있지만 예외처리한 페이지(count가 1이상)니까 그냥 지나가세요
				mav=(ModelAndView)joinPoint.proceed();
				String methodName=joinPoint.getSignature().getName();	//호출 메서드 이름 찍어보려고
				//System.out.println("AOP 왈 예외페이지라 로그인 불필요! : "+methodName+", 메서드의 반환 값은 : "+mav);
			}
		}
		System.out.println("aop가 넘겨주는 ModelAndView 값은 : "+mav);
		return mav;
	}
}
