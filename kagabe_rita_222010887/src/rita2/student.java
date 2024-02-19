package rita2;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.WindowConstants;

public class student implements ActionListener {
    static final String JDBC_DRIVER = "your_jdbc_driver";
    String url = "jdbc:mysql://localhost:3306/kagabe_rita_222010887";
    String UserN = "222010887";
    String PassD = "222010887";
    JFrame std;


    JButton submit = new JButton("Submit");
    JButton enterStudentIdButton = new JButton("Enter Student ID");
    JTextField studentIdTextField = new JTextField();

    JLabel felb = new JLabel("View Responses");
    JLabel feedb = new JLabel("Claim ID");
    JButton feedbacks = new JButton("View");
    JTextField fetxf = new JTextField();
    JLabel stdidlb = new JLabel("enter student id");

    String[] items = {"--none--", "marks Claim", "studying_claim", "registration_claim"};
    JComboBox<String> dropdown = new JComboBox<>(items);
    JLabel label = new JLabel("Selected Option: ");
    JLabel seleT = new JLabel();

    public student() {
        createform();
        setlocationandsize();
        addcomponent();
        setupActionListeners();
    }

    private void createform() {
        std = new JFrame();
        std.setTitle("E-claiming System/ Student Portal");
        std.setBounds(600, 140, 500, 280);
        std.getContentPane().setLayout(null);
        std.getContentPane().setBackground(Color.white);
        std.setVisible(true);
        std.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        std.setResizable(false);
    }

    private void setlocationandsize() {
        //elln.setBounds(190, 20, 120, 30);
        dropdown.setBounds(180, 70, 130, 30);
        label.setBounds(65, 70, 180, 34);
        submit.setBounds(330, 70, 110, 30);
        felb.setBounds(190, 120, 150, 30);
        fetxf.setBounds(180, 150, 130, 30);
        feedbacks.setBounds(330, 150, 100, 30);
        feedb.setBounds(65, 150, 100, 35);
        //enterStudentIdButton.setBounds(330, 20, 140, 30);
        studentIdTextField.setBounds(180, 20, 130, 30);
        stdidlb.setBounds(65, 20, 150, 30);
    }

    private void addcomponent() {

        std.add(submit);
        std.add(dropdown);
        std.add(label);
        std.add(felb);
        std.add(feedbacks);
        std.add(fetxf);
        std.add(feedb);
        //std.add(enterStudentIdButton);
        std.add(studentIdTextField);
        std.add(stdidlb);
    }

    private void setupActionListeners() {
        submit.addActionListener(this);
        dropdown.addActionListener(this);
        feedbacks.addActionListener(this);
        enterStudentIdButton.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == feedbacks) {
            // Get the claim_id from the text field
            String claimId = fetxf.getText();

            // Check if claimId is not empty
            if (!claimId.isEmpty()) {
                // Call method to fetch response from the database
                String response = fetchResponseFromDatabase(claimId);

                // Display the response or a message if none found
                if (response != null) {
                    JOptionPane.showMessageDialog(std, "Response: " + response);
                } else {
                    JOptionPane.showMessageDialog(std, "No response found for claim_id: " + claimId);
                }
            } else {
                JOptionPane.showMessageDialog(std, "Please enter a claim_id.");
            }
        } else if (e.getSource() == submit) {
            // Call method to insert data into the claims table
            insertDataIntoClaimsTable();
        }
    }

    private void insertDataIntoClaimsTable() {
        try {
        	String selectedClaimType = (String) dropdown.getSelectedItem();
            Connection connection = DriverManager.getConnection(url, UserN, PassD);
            String query = "INSERT INTO claims (claim_type, submission_date, resolution_date, student_id) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                // Set values for the prepared statement
            	preparedStatement.setString(1, selectedClaimType); // claim_type
                preparedStatement.setString(2, getCurrentDateTime()); // submission_date
                preparedStatement.setNull(3, java.sql.Types.NULL); // resolution_date (set as null)
                preparedStatement.setString(4, studentIdTextField.getText());

                // Execute the update
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    JOptionPane.showMessageDialog(std, "Data inserted into claims table successfully.");
                } else {
                    JOptionPane.showMessageDialog(std, "Failed to insert data into claims table.");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private String fetchResponseFromDatabase(String claimId) {
        try {
            Connection connection = DriverManager.getConnection(url, UserN, PassD);
            String query = "SELECT response FROM feedback WHERE claim_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, claimId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getString("response");
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    private String getCurrentDateTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return LocalDateTime.now().format(formatter);
    }

    public static void main(String[] args) {
        new student();
    }
}
