// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "already_have_account": MessageLookupByLibrary.simpleMessage(
            "Already have a account? Log In"),
        "appName": MessageLookupByLibrary.simpleMessage("Cosmonaut"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_email": MessageLookupByLibrary.simpleMessage(
            "An email has been sent to your email address. Please confirm."),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "need_register":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account yet?"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "unknown_error": MessageLookupByLibrary.simpleMessage("Unknown error.")
      };
}
