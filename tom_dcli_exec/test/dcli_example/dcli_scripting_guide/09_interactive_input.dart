#!/usr/bin/env dcli
// DCli Scripting Guide - Interactive Input Example
// NOTE: This example requires a terminal to run interactively

import 'package:dcli/dcli.dart';

void main() {
  print('DCli Interactive Input Examples');
  print('================================\n');
  
  // Text input with validation
  var name = ask('Enter your name:', 
    required: true, 
    validator: Ask.alpha);
    
  // Numeric input
  var age = ask('Enter your age:', 
    validator: Ask.all([
      Ask.integer,
      Ask.valueRange(1, 150),
    ]));
    
  // Password (hidden)
  var password = ask('Password:', hidden: true);
  
  // Confirmation
  if (confirm('Save profile?', defaultValue: true)) {
    print(green('Profile saved for $name'));
  }
  
  // Menu selection
  var choice = menu('Select option:', options: [
    'View profile',
    'Edit profile', 
    'Delete profile',
  ]);
  print('Selected: $choice');
}
