package rita2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class claimdocument extends JFrame {
    private JTextField claim_letter_idField, student_idField;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/kagabe_rita_epms";
    private static final String JDBC_USER = "222010887";
    private static final String JDBC_PASSWORD = "222010887";

    public claimdocument() {
        setTitle("claims");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(600, 400);
        setLocationRelativeTo(null);

        // Initialize components
        claim_letter_idField = new JTextField(20);
        student_idField = new JTextField(20);
        
        

        JLabel claim_letter_idLabel = new JLabel("claim_letter_id:");
        JLabel student_idLabel = new JLabel("student_id");
        

        JButton addButton = new JButton("Add claim ");
        JButton viewButton = new JButton("View claim");
        JButton updateButton = new JButton("Update claim");
        JButton deleteButton = new JButton("Delete claim");

        // Set up the layout
        setLayout(null);
        claim_letter_idLabel.setBounds(30, 30, 120, 20);
        claim_letter_idField.setBounds(150, 30, 200, 20);

        student_idLabel.setBounds(30, 70, 200, 20);
        student_idField.setBounds(230, 70, 200, 20);



        claim_letter_idField.setBounds(150, 30, 200, 20);
        student_idField.setBounds(150, 70, 200, 20);

        addButton.setBounds(150, 150, 150, 30);
        viewButton.setBounds(310, 150, 150, 30);
        updateButton.setBounds(150, 190, 150, 30);
        deleteButton.setBounds(310, 190, 150, 30);
        
        add(claim_letter_idLabel);
        add(claim_letter_idField);
        add(student_idLabel);
        add(student_idField);
        add(addButton);
        add(viewButton);
        add(updateButton);
        add(deleteButton);

        // Set up action listeners
        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                addclaim();
            }
        });

        viewButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                viewclaim();
            }
        });

        updateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                updateclaim();
            }
        });

        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                deleteclaim();
            }
        });
    }protected void viewclaim() {
		// TODO Auto-generated method stub
		
	}
	protected void addclaim() {
		// TODO Auto-generated method stub
		
	}
	private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    private void addPowerUsage() {
        try (Connection connection = getConnection()) {
            int claim_letter_id = Integer.parseInt(claim_letter_idField.getText().trim());
            String student_idString = student_idField.getText().trim();
            

            String insertQuery = "INSERT INTO powerusage (buildingid, timestamp, usagevalue) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setInt(1, claim_letter_id);
                preparedStatement.setString(2, student_idString);
               

                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    JOptionPane.showMessageDialog(this, "claim added successfully.");
                } else {
                    JOptionPane.showMessageDialog(this, "Failed to add claim.");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error connecting to the database or invalid input.");
        }
    }

    private void viewPowerUsage() {
        try (Connection connection = getConnection()) {
            String selectQuery = "SELECT * FROM powerusage";
            try (Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery(selectQuery)) {

                StringBuilder powerUsageData = new StringBuilder("Power Usage Data:\n");

                while (resultSet.next()) {
                    int buildingId = resultSet.getInt("claim_letterid");
                    int student_id = resultSet.getInt("student_id");
                  
                }

                JTextArea textArea = new JTextArea(powerUsageData.toString());
                textArea.setEditable(false);
                JScrollPane scrollPane = new JScrollPane(textArea);
                scrollPane.setPreferredSize(new Dimension(400, 300));
                JOptionPane.showMessageDialog(this, scrollPane, "Power Usage Data", JOptionPane.PLAIN_MESSAGE);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error connecting to the database.");
        }
    }

    private void updateclaim() {
        // Similar to addPowerUsage but with UPDATE SQL statement
        // Implement as needed
    }

    private void deleteclaim() {
        // Similar to addPowerUsage but with DELETE SQL statement
        // Implement as needed
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new claimdocument().setVisible(true);
            }
        });
    }
}