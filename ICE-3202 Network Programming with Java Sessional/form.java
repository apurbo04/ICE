import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

public class form implements ActionListener {

    private static JLabel success;
    private static JFrame frame;
    private static JLabel label1, label2, label3, title;
    private static JPanel panel;
    private static JButton button;
    private static JTextField userText1, userText2, userText3;

    public static void main(String[] args) {

        frame = new JFrame("Student Form");
        panel = new JPanel();
        frame.setSize(420, 320);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(panel);
        panel.setLayout(null);

        // Title
        title = new JLabel("Student Information Form");
        title.setBounds(90, 10, 250, 25);
        title.setFont(new Font("Arial", Font.BOLD, 14));
        panel.add(title);

        // Labels
        label1 = new JLabel("Name:");
        label1.setBounds(30, 50, 80, 25);
        panel.add(label1);

        label2 = new JLabel("Roll:");
        label2.setBounds(30, 90, 80, 25);
        panel.add(label2);

        label3 = new JLabel("Department:");
        label3.setBounds(30, 130, 100, 25);
        panel.add(label3);

        // TextFields
        userText1 = new JTextField();
        userText1.setBounds(140, 50, 200, 25);
        panel.add(userText1);

        userText2 = new JTextField();
        userText2.setBounds(140, 90, 200, 25);
        panel.add(userText2);

        userText3 = new JTextField();
        userText3.setBounds(140, 130, 200, 25);
        panel.add(userText3);

        // Button (styled)
        button = new JButton("Submit");
        button.setBounds(150, 180, 120, 35);
        button.setBackground(Color.DARK_GRAY);
        button.setForeground(Color.WHITE);
        button.setFocusable(false);
        button.addActionListener(new form());
        panel.add(button);

        // Success label
        success = new JLabel("");
        success.setBounds(100, 230, 300, 25);
        success.setForeground(Color.BLUE);
        panel.add(success);

        frame.setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String name = userText1.getText();
        String roll = userText2.getText();
        String dept = userText3.getText();

        success.setText("Saved: " + name + ", " + roll + ", " + dept);
    }
}