import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import 'register_page.dart';
import 'package:lyric_stream/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hitamUtama,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.putihTeks),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.deepPurple.withOpacity(0.1),
              AppColors.hitamUtama,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: AppColors.putihTeks,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login to Lyriya and feel the magic.',
                  style: TextStyle(color: AppColors.lavenderAksen, fontSize: 16),
                ),
                const SizedBox(height: 40),

                _buildTextField(
                  hint: 'Email Address',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController, 
                ),

                const SizedBox(height: 40),

                // --- TOMBOL LOGIN ---
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(colors: [AppColors.deepPurple, Color(0xFF4C1D95)]),
                    boxShadow: [
                      BoxShadow(color: AppColors.deepPurple.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      // LOGIKA YANG BENER: Harus cocok dengan email & sandi kamu
                      if (email == "aliyah@lyriya.com" && password == "lyriya") {
                        // Kalau BENAR, baru boleh masuk
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(userEmail: email),
                          ),
                        );
                      } else if (email.isEmpty || password.isEmpty) {
                        // Kalau KOSONG, kasih tahu
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Email dan Password tidak boleh kosong!")),
                        );
                      } else {
                        // Kalau SALAH (Asal-asalan), TOLAK!
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email atau Sandi salah! Akses ditolak."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('LOGIN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text("Register", style: TextStyle(color: AppColors.lavenderAksen, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _isObscure : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: AppColors.deepPurple),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                onPressed: () => setState(() => _isObscure = !_isObscure),
              )
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}