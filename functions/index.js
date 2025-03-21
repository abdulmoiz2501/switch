/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at
 * https://firebase.google.com/docs/functions
 */


const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendOrderNotification = functions.firestore
    .document("users/{userId}/orders/{orderId}")
    .onCreate(async (snap, context) => {
      const order = snap.data();
      const userId = context.params.userId;

      const userDoc = await admin.firestore()
          .collection("users")
          .doc(userId)
          .get();
      const fcmToken = userDoc.data() && userDoc.data().fcmToken;
      if (!fcmToken) {
        console.log(`No FCM token for user: ${userId}`);
        return null;
      }

      const payload = {
        notification: {
          title: "Order Placed!",
          body: `Your order ${order.orderId} placed!.`,
        },
      };

      try {
        const response = await admin.messaging()
            .sendToDevice(fcmToken, payload);
        console.log("Push notification sent:", response);
        return response;
      } catch (error) {
        console.error("Error sending notification:", error);
        return null;
      }
    });
