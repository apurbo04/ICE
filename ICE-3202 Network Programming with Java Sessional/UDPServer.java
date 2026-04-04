import java.net.*;

public class UDPServer {
    public static void main(String[] args) {
        try {
            DatagramSocket socket = new DatagramSocket(5000);
            byte[] buffer = new byte[1024];

            System.out.println("UDP Server is running...");

            while (true) {
                DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                socket.receive(packet);

                String message = new String(packet.getData(), 0, packet.getLength());
                System.out.println("Received: " + message);

                String upperMessage = message.toUpperCase();

                // Delay of 6 ms
                Thread.sleep(6);

                byte[] sendData = upperMessage.getBytes();

                DatagramPacket sendPacket = new DatagramPacket(
                        sendData,
                        sendData.length,
                        packet.getAddress(),
                        packet.getPort()
                );

                socket.send(sendPacket);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}