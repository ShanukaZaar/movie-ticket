package com.movieticket.util;

public class EmailUtil {

    public static boolean sendPaymentConfirmation(String toEmail, String transactionId, double amount) {
        try {
            // Simple project-safe confirmation log.
            // Later you can replace this with JavaMail/Gmail SMTP.
            System.out.println("=================================");
            System.out.println("PAYMENT CONFIRMATION EMAIL");
            System.out.println("To: " + toEmail);
            System.out.println("Transaction ID: " + transactionId);
            System.out.println("Amount: LKR " + amount);
            System.out.println("Status: SENT");
            System.out.println("=================================");

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}