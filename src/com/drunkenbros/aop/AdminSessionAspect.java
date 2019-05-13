package com.drunkenbros.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.web.servlet.ModelAndView;

@Aspect
public class AdminSessionAspect {
	//�α��� �������� aop���� �������ϸ� �ȵ�!
	String[] exceptList= {
			"/admin"
	};
	
	//������ �޼��� �̸� ���� ������ ��
	@Pointcut("execution(public * com.drunkenbros.controller.AdminMainController.admin*(..))")
	public void checkAdminMain() {}
	@Pointcut("execution(public * com.drunkenbros.controller.MemberController.admin*(..))")
	public void checkAdminMemberPage() {}
	@Pointcut("execution(public * com.drunkenbros.controller.AlcoholController.admin*(..))")
	public void checkAdminAlcoholPage() {}
	
	
	//=====================================================
	// ������ ���������� ������ �α��� �ߴ��� & �α����� ����� ������ �����ڰ� �´��� üũ����.
	//=====================================================
	@Around("checkAdminMemberPage() || checkAdminAlcoholPage()")
	public ModelAndView adminLoginCheck(ProceedingJoinPoint joinPoint)  throws Throwable{
		System.out.println("aop �۵�");
		
		Object[] objArray=joinPoint.getArgs();
		HttpServletRequest request=null;
		String requestURL=null;
		ModelAndView mav=new ModelAndView();
			
		int count=0;
		//��� �Ű������� ���� - ��? ������Ʈ ��ü ����������
		for(Object obj : objArray) {
			if(obj instanceof HttpServletRequest) {
				request=(HttpServletRequest)obj;
				requestURL=request.getRequestURI().toString();
				System.out.println("AdminSessionAspect/adminLoginCheck/requestURL : "+requestURL);//������� ����
				
				for(int i=0; i<exceptList.length; i++) {
					if(requestURL.endsWith(exceptList[i])) {
						count++;//���ܸ�� �ɸ��� ī��Ʈ
					}
				}
			}
			
			//admin ���� �޼��� ȣ��ø��� �α��� �ߴ��� üũ�غ���.
			if(request!=null && count <1) {
				//request�� �ְ� ���� �������� �ƴ�
				if(request.getSession().getAttribute("loginAdmin")==null) {//�α����� ���߳�?
					System.out.println("Aop: admin �α����� ���ϼ̳׿�!");
					mav.setViewName("redirect:/admin");
				}else {
					System.out.println("Aop: ������ �α����� �ϼ̳׿�!!");
					
					mav=(ModelAndView)joinPoint.proceed();
					String methodName=joinPoint.getSignature().getName();	//ȣ�� �޼��� �̸� ������
					//System.out.println("AOP �� �α��� �ʿ��� ������! : "+methodName+", �޼����� ��ȯ ���� : "+mav);
				}
			}else {
				//request�� ������ ����ó���� ������(count�� 1�̻�)�ϱ� �׳� ����������
				mav=(ModelAndView)joinPoint.proceed();
				String methodName=joinPoint.getSignature().getName();	//ȣ�� �޼��� �̸� ������
				//System.out.println("AOP �� ������������ �α��� ���ʿ�! : "+methodName+", �޼����� ��ȯ ���� : "+mav);
			}
		}
		System.out.println("aop�� �Ѱ��ִ� ModelAndView ���� : "+mav);
		return mav;
	}
}
