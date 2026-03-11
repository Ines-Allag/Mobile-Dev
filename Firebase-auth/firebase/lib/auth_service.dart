import "package:cloud_firestore/cloud_firestore.dart"; // firebase library that handles the database
import "package:firebase_auth/firebase_auth.dart"; // firebase library that handles login/signup/logout

class AuthService {
  final _auth = FirebaseAuth.instance; //_auth is the connection to firebase authentification
  final _db = FirebaseFirestore.instance; //_db is the connection to our database Firestore


// Function to validate the email
bool isValidEmail(String email){
  final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  return regex.hasMatch(email);
}

// Function to verify that the user is at least 13
bool isAtLeast13(DateTime dob){
  final now = DateTime.now();
  return now.year -dob.year >=13;
}

// Function for sign up
Future<void> signup({
  required String firstName,
  required String lastName,
  required DateTime dob,
  required String email,
  required String password,
}) async {
  final cred = await _auth.createUserWithEmailAndPassword(
    email: email,
    password : password,
  );
  await _db.collection('users').doc(cred.user!.uid).set({
    "firstName":firstName,
    "lastName": lastName,
    "dob": dob.toString().split(" ")[0],
    "email": email,
  });
}

  Future<void> resetPassword({
    required String email,
  }) async {
    final cred = await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

// Function for login
Future<void> login (String email, String password) async {
  await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
  );
}

// Function to get the profile
Future<Map<String, dynamic>> getProfile(String uid) async { // The function Takes a uid and fetches that user's profile from Firestore
  final doc = await _db.collection("users").doc(uid).get();
  return doc.data()!;
}

// Function to sign out
Future<void> logout() async {
  await _auth.signOut();
}
}