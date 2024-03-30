import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.imgUrl,
    required this.phoneNumber,
    required this.isAdmin,
  });

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String imgUrl;

  final String phoneNumber;

  final bool isAdmin;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(
    id: '',
    email: '',
    name: '',
    imgUrl: '',
    phoneNumber: '',
    isAdmin: false,
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  // make a frmouserdoc method
  static User fromUserDoc(DocumentSnapshot userDoc) {
    return User(
      id: userDoc.id,
      email: userDoc['email'],
      name: userDoc['name'],
      imgUrl: userDoc['imgUrl'],
      phoneNumber: userDoc['phoneNumber'],
      isAdmin: userDoc['isAdmin'] ?? false,
    );
  }

  // make a copywith method

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? imgUrl,
    String? phoneNumber,
    bool? isAdmin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        imgUrl,
        phoneNumber,
        isAdmin,
      ];
}

// make to map

extension UserX on User {
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'imgUrl': imgUrl,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
    };
  }
}

// make user error class
class UserError extends Equatable {
  final String message;

  const UserError({required this.message});
  // make user does not exist error
  static const userDoesNotExist = UserError(message: 'User does not exist');

  @override
  List<Object?> get props => [message];
}
