import java.net.*;
import java.io.*;

public class UDPClient {
    public static void main(String[] args) {
        try {
            DatagramSocket socket = new DatagramSocket();
            InetAddress serverAddress = InetAddress.getByName("localhost");

            BufferedReader userInput = new BufferedReader(
                    new InputStreamReader(System.in));

            System.out.print("Enter message: ");
            String message = userInput.readLine();

            byte[] sendData = message.getBytes();

            DatagramPacket sendPacket = new DatagramPacket(
                    sendData,
                    sendData.length,
                    serverAddress,
                    5000
            );

            socket.send(sendPacket);

            byte[] receiveBuffer = new byte[1024];
            DatagramPacket receivePacket = new DatagramPacket(receiveBuffer, receiveBuffer.length);

            socket.receive(receivePacket);

            String response = new String(receivePacket.getData(), 0, receivePacket.getLength());
            System.out.println("Server replied: " + response);

            socket.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}