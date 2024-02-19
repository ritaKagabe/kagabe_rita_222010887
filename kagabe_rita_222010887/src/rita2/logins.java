package rita2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;

public class logins implements ActionListener {
    
	JFrame logFm;
	JLabel wellb = new JLabel("WELCOME TO E-claiming system");
	
	JButton citbtn = new JButton("Student");
	JButton sbtn = new JButton("Staff");

	public logins() {
		createform();
		setlocationandsize();
		addcomponent();
		ActionEvent();
	}
	
	private void createform() {
		logFm = new JFrame();
		logFm.setTitle("E-claiming System");
		logFm.setBounds(600,140,500,350);
		logFm.getContentPane().setLayout(null);
		logFm.getContentPane().setBackground(Color.white);
		logFm.setVisible(true);
		logFm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		logFm.setResizable(false);
		
	}
	private void setlocationandsize() {
		wellb.setBounds(170, 60, 200, 30);
		citbtn.setBounds(195, 140, 80, 30);
		sbtn.setBounds(195, 190, 80, 30);
	}
	private void addcomponent() {
		logFm.add(wellb);
		logFm.add(citbtn);
		logFm.add(sbtn);
	}
	private void ActionEvent() {
		citbtn.addActionListener(this);
		sbtn.addActionListener(this);
	}
	@Override
	public void actionPerformed(java.awt.event.ActionEvent e) {
		if (e.getSource() == citbtn) {
            // Open CitizenForm when Citizen button is clicked
            logFm.dispose(); // Close the Login_citizen frame
            new student(); // Open CitizenForm
        }
		if (e.getSource() == sbtn) {
            // Open CitizenForm when Citizen button is clicked
            logFm.dispose(); // Close the Login_citizen frame
            new staff(); // open StaffForm
        }
	}

	public static void main(String[] args) {
        new logins();

	}

}
