package rita2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class staff implements ActionListener{

    static final String JDBC_DRIVER = "your_jdbc_driver";
	String url = "jdbc:mysql://localhost:3306/ kagabe_rita_222010887";
	String UserN = "222010887";
	String PassD = "222010887";
	JFrame staffF;
	int loggedID;
	JLabel wellb = new JLabel("login form");
	JLabel userName = new JLabel("Username: ");
	JLabel passW = new JLabel("Password: ");
	
	JTextField usertxf = new JTextField();
	JTextField passWtxf = new JTextField();
	
	JButton login = new JButton("LogIn");
	JButton reset = new JButton("Reset");
	public staff () {
		createform();
		setlocationandsize();
		addcomponent();
		setupActionListeners();
	}
	private void createform() {
		staffF = new JFrame();
		staffF.setTitle("login form");
		staffF.setBounds(600,140,500,350);
		staffF.getContentPane().setLayout(null);
		staffF.getContentPane().setBackground(Color.white);
		staffF.setVisible(true);
		staffF.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		staffF.setResizable(false);
		
	}
	private void setlocationandsize() {
		wellb.setBounds(195, 60, 200, 30);
		
		userName.setBounds(50, 110, 80, 30);
		usertxf.setBounds(140, 110, 250, 30);
		
		passW.setBounds(50, 150, 80, 30);
		passWtxf.setBounds(140, 150, 250, 30);
		
		login.setBounds(100, 250, 80, 30);
		reset.setBounds(200, 250, 80, 30);
		
	}
	private void addcomponent() {
		staffF.add(wellb);
		staffF.add(userName);
		staffF.add(login);
		staffF.add(passW);
		staffF.add(reset);
		staffF.add(passWtxf);
		staffF.add(usertxf);
		
	}
	private void setupActionListeners() {
	    login.addActionListener(this);
	
	    reset.addActionListener(this);
	}
	@Override
	public void actionPerformed(ActionEvent e) {
        if (e.getSource() == login) {
            String Username = usertxf.getText();
            String Password = passWtxf.getText();

            // Validate credentials by querying the database
            try{
            	Connection conn = DriverManager.getConnection(url, UserN, PassD);
            
                String sql = "SELECT * FROM staff WHERE names=? AND password=?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, Username);
                    pstmt.setString(2, Password);
                    ResultSet resultSet = pstmt.executeQuery();

                    if (resultSet.next()) {
                    	loggedID = resultSet.getInt("staff_id");
                    	staffF.dispose(); // Close the citizen frame
                        new Logged_std(); // Open loggedForm
                    } else {
                        // Login failed
                        JOptionPane.showMessageDialog(null, "Invalid username or password!");
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        if (e.getSource() == reset) {
            // Code to clear text fields
            usertxf.setText(""); 
            passWtxf.setText(""); 
        }
      
    }
	
	public static void main(String[] args) {
		new staff();
	}
}