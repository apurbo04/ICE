import java.net.*;
import java.io.*;

public class UDPProgram {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage:");
            System.out.println("Run as server: java UDPProgram server");
            System.out.println("Run as client: java UDPProgram client");
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
            DatagramSocket socket = new DatagramSocket(5000);
            System.out.println("UDP Server running...");

            byte[] buffer = new byte[1024];

            DatagramPacket request = new DatagramPacket(buffer, buffer.length);
            socket.receive(request);

            String message = new String(request.getData(), 0, request.getLength());
            System.out.println("Received: " + message);

            // wait 6 ms
            Thread.sleep(6);

            String upper = message.toUpperCase();
            byte[] responseData = upper.getBytes();

            InetAddress clientAddress = request.getAddress();
            int clientPort = request.getPort();

            DatagramPacket response = new DatagramPacket(
                    responseData, responseData.length,
                    clientAddress, clientPort);

            socket.send(response);

            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // CLIENT
    public static void runClient() {
        try {
            DatagramSocket socket = new DatagramSocket();

            BufferedReader userInput = new BufferedReader(
                    new InputStreamReader(System.in));

            System.out.print("Enter message: ");
            String message = userInput.readLine();

            byte[] data = message.getBytes();

            InetAddress serverAddress = InetAddress.getByName("localhost");

            DatagramPacket request = new DatagramPacket(
                    data, data.length, serverAddress, 5000);

            socket.send(request);

            byte[] buffer = new byte[1024];
            DatagramPacket response = new DatagramPacket(buffer, buffer.length);

            socket.receive(response);

            String reply = new String(response.getData(), 0, response.getLength());
            System.out.println("Server replied: " + reply);

            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}