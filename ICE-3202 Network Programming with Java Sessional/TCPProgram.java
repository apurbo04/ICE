import java.io.*;
import java.net.*;

public class TCPProgram {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage:");
            System.out.println("Run as server: java TCPProgram server");
            System.out.println("Run as client: java TCPProgram client");
            return;
        }

        if (args[0].equalsIgnoreCase("server")) {
            runServer();
        } else if (args[0].equalsIgnoreCase("client")) {
            runClient();
        } else {
            System.out.println("Invalid argument. Use 'server' or 'client'");
        }
    }

    // SERVER
    public static void runServer() {
        try {
            ServerSocket serverSocket = new ServerSocket(5000);
            System.out.println("Server running... Waiting for client...");

            Socket socket = serverSocket.accept();
            System.out.println("Client connected!");

            BufferedReader input = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));
            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);

            String message = input.readLine();
            System.out.println("Received: " + message);

            String upper = message.toUpperCase();
            output.println(upper);

            socket.close();
            serverSocket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // CLIENT
    public static void runClient() {
        try {
            Socket socket = new Socket("localhost", 5000);

            BufferedReader userInput = new BufferedReader(
                    new InputStreamReader(System.in));
            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);
            BufferedReader input = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));

            System.out.print("Enter message: ");
            String msg = userInput.readLine();

            output.println(msg);

            String response = input.readLine();
            System.out.println("Server replied: " + response);

            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}