package com.drunkenbros.common.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import com.drunkenbros.model.domain.Member;

/***********************************************************
 * SHA (��ť��Ƽ �ؽ� �˰���) �� �̿��� ȸ������, �α��� üũ � ��ȣȭ ���
 ************************************************************/
public class PassSecurity {

	/***********************************************************
	 * �Ű������� ��ȣ�� ���޹����� �ؽð� (16������) ���� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
	 ************************************************************/

	public String textToHash(String pass) {
		StringBuilder sb = new StringBuilder();

		try {
			// ����� �˰��� �����ϱ�.
			MessageDigest md = MessageDigest.getInstance("SHA-256");

			// �ؽ�ȭ ��ų �����͸� ����Ʈȭ, �� �ɰ��� �־������
			md.update(pass.getBytes());

			// ��ȣȭ �� ����Ʈ ��ȯ�ޱ�. �Ϲ� ����Ʈ �迭�� ��ȣȭ�� �����ͷ� ��ȯ
			byte[] data = md.digest();

			// �迭�� ����ϱ⿣ ������ �����Ƿ�, ��Ʈ��ȭ ��Ű��
			for (int i = 0; i < data.length; i++) {
				// ��ȹ : ����Ʈ�� 16����ȭ - ���۸�
				sb.append(Integer.toString((data[i] & 0xff) + 0x100, 16).substring(1));
			}

			// db���� pass ���� 64�̻����� ��������ߵ�
			// System.out.println("��ȣ�� ���̴� : " + sb.toString().length());
			// System.out.println("������ ��ȣ�� : " + sb.toString());

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

	// ================================================================================================
	// ��� ��й�ȣ ��ȣȭ �޼ҵ� : �Ѱܹ��� ����� Pass�� ��ȣȭ�ؼ� ��ȯ����
	// ================================================================================================
	public Member setHashPass(Member member) {
		System.out.println("��ȣȭ �� ȸ�� Pass�� :" + member.getPass());

		String hashPass = textToHash(member.getPass());
		member.setPass(hashPass);
		System.out.println("��ȣȭ �� ȸ�� Pass�� :" + member.getPass());
		return member;
	}
}
