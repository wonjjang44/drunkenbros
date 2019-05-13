package com.drunkenbros.common.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import com.drunkenbros.model.domain.Member;

/***********************************************************
 * SHA (시큐리티 해쉬 알고리즘) 을 이용해 회원가입, 로그인 체크 등에 암호화 사용
 ************************************************************/
public class PassSecurity {

	/***********************************************************
	 * 매개변수로 암호를 전달받으면 해시값 (16진수값) 으로 변환하여 반환하는 메소드
	 ************************************************************/

	public String textToHash(String pass) {
		StringBuilder sb = new StringBuilder();

		try {
			// 사용할 알고리즘 선택하기.
			MessageDigest md = MessageDigest.getInstance("SHA-256");

			// 해시화 시킬 데이터를 바이트화, 즉 쪼개서 넣어줘야함
			md.update(pass.getBytes());

			// 암호화 된 바이트 반환받기. 일반 바이트 배열을 암호화된 데이터로 반환
			byte[] data = md.digest();

			// 배열로 사용하기엔 무리가 있으므로, 스트링화 시키자
			for (int i = 0; i < data.length; i++) {
				// 계획 : 바이트를 16진수화 - 구글링
				sb.append(Integer.toString((data[i] & 0xff) + 0x100, 16).substring(1));
			}

			// db에서 pass 길이 64이상으로 변경해줘야됨
			// System.out.println("암호의 길이는 : " + sb.toString().length());
			// System.out.println("생성된 암호는 : " + sb.toString());

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

	// ================================================================================================
	// 멤버 비밀번호 암호화 메소드 : 넘겨받은 멤버의 Pass를 암호화해서 반환해줌
	// ================================================================================================
	public Member setHashPass(Member member) {
		System.out.println("암호화 전 회원 Pass는 :" + member.getPass());

		String hashPass = textToHash(member.getPass());
		member.setPass(hashPass);
		System.out.println("암호화 후 회원 Pass는 :" + member.getPass());
		return member;
	}
}
