import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class BillGeneration extends JFrame implements ActionListener {

    JLabel l;
    JCheckBox cb1, cb2, cb3;
    JButton b;

    BillGeneration() {
        l = new JLabel("Cafeteria Billing System");
        l.setBounds(50, 50, 300, 20);

        cb1 = new JCheckBox("Sandwich @ 80");
        cb1.setBounds(100, 100, 150, 20);

        cb2 = new JCheckBox("Coffee @ 50");
        cb2.setBounds(100, 150, 150, 20);

        cb3 = new JCheckBox("Juice @ 60");
        cb3.setBounds(100, 200, 150, 20);

        // ✔ Updated Button
        b = new JButton("Place Order");
        b.setBounds(100, 250, 150, 40);
        b.setFocusable(false);
        b.setBackground(Color.BLACK);
        b.setForeground(Color.WHITE);
        b.addActionListener(this);

        add(l);
        add(cb1);
        add(cb2);
        add(cb3);
        add(b);

        setSize(400, 400);
        setLayout(null);
        setVisible(true);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    public void actionPerformed(ActionEvent e) {
        float amount = 0;
        String msg = "";

        if (cb1.isSelected()) {
            amount += 80;
            msg = "Sandwich: 80\n";
        }

        if (cb2.isSelected()) {
            amount += 50;
            msg += "Coffee: 50\n";
        }

        if (cb3.isSelected()) {
            amount += 60;
            msg += "Juice: 60\n";
        }

        msg += "-----------------\n";
        JOptionPane.showMessageDialog(this, msg + "Total: " + amount);
    }

    public static void main(String[] args) {
        new BillGeneration();
    }
}