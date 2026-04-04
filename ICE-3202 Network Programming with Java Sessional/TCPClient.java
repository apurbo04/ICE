import java.io.*;
import java.net.*;

public class TCPClient {
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 5000);

            BufferedReader userInput = new BufferedReader(
                    new InputStreamReader(System.in));
            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);
            BufferedReader input = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));

            System.out.print("Enter message: ");
            String message = userInput.readLine();

            output.println(message);

            String response = input.readLine();
            System.out.println("Server replied: " + response);

            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}