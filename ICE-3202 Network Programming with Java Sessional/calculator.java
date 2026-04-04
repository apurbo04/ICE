import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;

public class calculator extends JFrame implements ActionListener {

   JButton b10, b11, b12, b13, b14, b15;
   JButton b[] = new JButton[10];
   int i, r, n1, n2;
   JTextField res;
   char op;

   public calculator() {
      setTitle("Calculator");
      setLayout(new BorderLayout(5, 5));

      JPanel p = new JPanel(new GridLayout(4, 4, 8, 8));
      p.setBackground(Color.LIGHT_GRAY);

      Border raised = BorderFactory.createRaisedBevelBorder();

      // number buttons
      for (i = 0; i <= 9; i++) {
         b[i] = new JButton("" + i);
         b[i].setFont(new Font("Arial", Font.BOLD, 16));
         b[i].setBorder(raised);
         b[i].addActionListener(this);
         p.add(b[i]);
      }

      // operator buttons
      b10 = new JButton("+");
      b11 = new JButton("-");
      b12 = new JButton("*");
      b13 = new JButton("/");
      b14 = new JButton("=");
      b15 = new JButton("C");

      JButton ops[] = { b10, b11, b12, b13, b14, b15 };

      for (JButton btn : ops) {
         btn.setFont(new Font("Arial", Font.BOLD, 16));
         btn.setBorder(raised);
         btn.addActionListener(this);
         p.add(btn);
      }

      // display
      res = new JTextField();
      res.setFont(new Font("Arial", Font.BOLD, 26));
      res.setPreferredSize(new Dimension(200, 60));
      res.setHorizontalAlignment(JTextField.RIGHT);

      add(res, BorderLayout.NORTH);
      add(p, BorderLayout.CENTER);

      setSize(300, 400);
      setVisible(true);
      setDefaultCloseOperation(EXIT_ON_CLOSE);
   }

   public void actionPerformed(ActionEvent e) {
      JButton pb = (JButton) e.getSource();

      if (pb == b15) { // clear
         res.setText("");
         n1 = n2 = r = 0;
      }

      else if (pb == b14) { // equals
         n2 = Integer.parseInt(res.getText());
         if (op == '/' && n2 == 0) {
            res.setText("Error");
            return;
         }
         eval();
         res.setText("" + r);
      }

      else if (pb == b10 || pb == b11 || pb == b12 || pb == b13) { // operators
         n1 = Integer.parseInt(res.getText());
         res.setText("");
         op = pb.getText().charAt(0);
      }

      else { // numbers
         if (res.getText().equals("Error"))
            res.setText("");
         res.setText(res.getText() + pb.getText());
      }
   }

   int eval() {
      if (op == '+')
         r = n1 + n2;
      else if (op == '-')
         r = n1 - n2;
      else if (op == '*')
         r = n1 * n2;
      else if (op == '/')
         r = n1 / n2;
      return r;
   }

   public static void main(String[] args) {
      new calculator();
   }
}