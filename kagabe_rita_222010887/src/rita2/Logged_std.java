 package rita2;
/*import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Logged_std extends JFrame implements ActionListener {

	private static final long serialVersionUID = 1L;
	private JTable claimsTable;
    private DefaultTableModel tableModel;
    private JButton refreshButton;

    private static final String JDBC_URL = "jdbc:mysql:/localhost:3306/e_claiming_project_management_system";
    private static final String USERNAME = "Rita";
    private static final String PASSWORD = "222010887";

    public Logged_std() {
        setTitle("claims Form");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Table
        tableModel = new DefaultTableModel();
        tableModel.addColumn("claim_type");
        tableModel.addColumn("student_id");

        claimsTable = new JTable(tableModel);
        JScrollPane scrollPane = new JScrollPane(claimsTable);
        scrollPane.setBounds(20, 20, 300, 200);

        // Refresh Button
        refreshButton = new JButton("Refresh");
        refreshButton.setBounds(20, 240, 100, 30);
        refreshButton.addActionListener(this);

        // Layout
        setLayout(null);
        add(scrollPane);
        add(refreshButton);

        setSize(350, 350);
        setLocationRelativeTo(null); // Center the frame on the screen
        setVisible(true);
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
    }

    private void refreshTable() {
        // Clear existing rows
        tableModel.setRowCount(0);

        try (Connection connection = getConnection()) {
            String query = "SELECT * FROM staff";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int claim_type = resultSet.getInt("claim_type");
                        String student_id = resultSet.getString("student_id");

                        // Add a row to the table
                        tableModel.addRow(new Object[]{claim_type, student_id});
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading claims.");
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == refreshButton) {
            refreshTable();
        }
    }

    public static void main(String[] args) {
    	 SwingUtilities.invokeLater(() -> new Logged_std());
        	
    }
}
*/

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class Logged_std implements ActionListener {
    JFrame frame;
    JTable table;
    JButton respond = new JButton("Responses");

    public Logged_std() {
        initializeUI();
        loadDataFromDatabase();
        setLayout();
        addActionListeners();
    }

    private void initializeUI() {
        frame = new JFrame();
        frame.setTitle("Claims Table");
        frame.setSize(600, 400);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new BorderLayout());
        frame.setVisible(true);

        table = new JTable();
        JScrollPane scrollPane = new JScrollPane(table);
        frame.add(scrollPane, BorderLayout.CENTER);
    }

    private void setLayout() {
        JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout(FlowLayout.CENTER));
        panel.add(respond);
        frame.add(panel, BorderLayout.SOUTH);
    }

    private void addActionListeners() {
        respond.addActionListener(this);
    }

    private void loadDataFromDatabase() {
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/kagabe_rita_epms", "222010887", "222010887");
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT claim_type, student_id, claim_id from claims");

            DefaultTableModel tableModel = new DefaultTableModel();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            for (int i = 1; i <= columnCount; i++) {
                tableModel.addColumn(metaData.getColumnName(i));
            }

            while (resultSet.next()) {
                Object[] rowData = new Object[columnCount];
                for (int i = 1; i <= columnCount; i++) {
                    rowData[i - 1] = resultSet.getObject(i);
                }
                tableModel.addRow(rowData);
            }

            table.setModel(tableModel);

            resultSet.close();
            statement.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new Logged_std());
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        // Handle button click action
        if (e.getSource() == respond) {
        	frame.dispose();
        	new FeedbackForm();
        }
    }
}
