package rita2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FeedbackForm extends JFrame implements ActionListener {
    private JTextField claimIdField;
    private JTextArea feedbackArea;
    private JButton submitButton;

    public FeedbackForm() {
        super("Staff Feedback Form");

        claimIdField = new JTextField(10);
        feedbackArea = new JTextArea(5, 20);
        submitButton = new JButton("Submit Feedback");

        // Layout
        setLayout(new GridLayout(3, 2));
        add(new JLabel("Claim ID:"));
        add(claimIdField);
        add(new JLabel("Feedback:"));
        add(new JScrollPane(feedbackArea));
        add(submitButton);

        // Button click event
        submitButton.addActionListener(this);

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        pack();
        setLocationRelativeTo(null);
        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == submitButton) {
            submitFeedback();
        }
    }

    private void submitFeedback() {
        int claimId = Integer.parseInt(claimIdField.getText());
        String feedback = feedbackArea.getText();

        // Perform database operation to submit feedback
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/kagabe_rita_epms", "222010887", "222010887")) {
            String sql = "UPDATE claims SET feedback = ? WHERE claim_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, feedback);
                statement.setInt(2, claimId);
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    JOptionPane.showMessageDialog(this, "Feedback submitted successfully");
                } else {
                    JOptionPane.showMessageDialog(this, "Claim ID not found or no rows updated");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error submitting feedback: " + ex.getMessage());
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new FeedbackForm();
            }
        });
    }
}
