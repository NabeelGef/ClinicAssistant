/*
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter some text',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _inputValue = value!;
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Send data to server or do something with input value
                      if (_inputValue == 'hello') {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Success'),
                            content: Text('Data sent successfully'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Invalid data entered'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Enter some text',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value != 'hello') {
                      return 'Invalid data entered';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _inputValue = value!;
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Send data to server or do something with input value
                      if (!_inputValue.isEmpty || _inputValue!= null) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Success'),
                            content: Text('Data sent successfully'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Invalid data entered'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;
   File _image = File("");

  Future _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundImage: _image == null ? null : FileImage(_image),
                  child: _image == null ? Icon(Icons.add_a_photo, size: 75.0) : null,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Sign Up'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Implement sign up logic
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Check OTP Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/lock.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOTPTextField(0),
                SizedBox(width: 20),
                _buildOTPTextField(1),
                SizedBox(width: 20),
                _buildOTPTextField(2),
                SizedBox(width: 20),
                _buildOTPTextField(3),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOTP,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPTextField(int index) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counter: Offstage(),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(),
        ),
        focusNode: _focusNodes[index],
        onChanged: (value) {
          if (value.isNotEmpty) {
            _focusNodes[index].unfocus();
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            }
          } else {
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
        },
      ),
    );
  }

  void _submitOTP() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      // TODO: Validate OTP and Sign Up User
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('خطأ أثناء الإدخال'),
          content: Text('Validating OTP...'),
        ),
      );
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('خطأ أثناء الإدخال'),
          content: Text('Please enter 4-digit OTP'),
        ),
      );
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop();
      });
    }
  }
}
