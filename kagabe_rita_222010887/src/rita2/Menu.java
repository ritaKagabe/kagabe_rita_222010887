package rita2;

import javax.swing.*;
import java.awt.*;

public class Menu{

	JFrame frame;
	JLabel systemlb = new JLabel("e-claiming"); 
	
	JButton Student = new JButton("student");
	JButton  claims = new JButton("claims");
	JButton staff = new JButton("staff");
	JButton notification = new JButton("notification");
	JButton claim_type = new JButton("claimdocument");
	
	public Menu() {
		createform();
		setlocationandsize();
		addcomponent();
	}

	private void createform() {
		frame = new JFrame();
		frame.setTitle("Menu of all tables in e-claiming");
		frame.setBounds(600,140,480,530);
		frame.getContentPane().setLayout(null);
		frame.getContentPane().setBackground(Color.LIGHT_GRAY);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setResizable(false);
	}
	

	private void addcomponent() {
		frame.add(systemlb);
		frame.add(Student);
		frame.add(claims);
		frame.add(staff);
		frame.add(notification);
		frame.add(claim_type);
				
	}

	private void setlocationandsize() {
		systemlb.setBounds(195, 20, 80, 40);
		Student.setBounds(160, 50, 140, 35);
		claims.setBounds(160, 95, 140, 35);
		staff.setBounds(160, 140, 140, 35);
		notification.setBounds(160, 185, 140, 35);
		claim_type.setBounds(160, 230, 140, 35);
	
		
	}
	public static void main(String[] args) {
		new Menu();

	}

}

