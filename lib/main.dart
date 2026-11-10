import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

// เอา URL ที่ได้จาก Deploy ใน Apps Script มาวางตรงนี้
const String kScriptUrl = 'PASTE_YOUR_WEB_APP_URL_HERE';

void main() => runApp(const GoodMealApp());

class GoodMealApp extends StatelessWidget {
  const GoodMealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Meal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
	textTheme: GoogleFonts.sarabunTextTheme(),
      ),
      home: const SplashPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// หน้า loading: เช็กว่าเคยตั้งค่าครั้งแรกแล้วหรือยัง
// ---------------------------------------------------------------------------
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _go();
  }

  Future<void> _go() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    final done = prefs.getBool('onboarded') ?? false;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => done ? const MealFormPage() : const OnboardingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant, size: 64),
            SizedBox(height: 16),
            Text('Good Meal', style: TextStyle(fontSize: 28)),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// เข้าแอปครั้งแรก: เลือกเพศ > ชื่อ/username > อายุ > อาหารที่แพ้ > ความถี่ทำอาหาร
// ---------------------------------------------------------------------------
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const int _lastStep = 4;

  static const _ages = [
    'ต่ำกว่า 13',
    '13-17',
    '18-24',
    '25-34',
    '35-44',
    '45 ขึ้นไป',
  ];
  static const _allergyOptions = [
    'ไม่มี',
    'ถั่ว',
    'นม',
    'ไข่',
    'อาหารทะเล',
    'กลูเตน',
  ];
  static const _cookingOptions = [
    'แทบไม่เคยทำเลย',
    'นานๆ ครั้ง',
    'สัปดาห์ละ 1-2 ครั้ง',
    'เกือบทุกวัน',
  ];

  final _pc = PageController();
  final _nickCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _otherAllergyCtrl = TextEditingController();

  int _step = 0;
  String? _gender; // 'boy' หรือ 'girl'
  String? _age;
  final Set<String> _allergies = {};
  String? _cooking;

  @override
  void dispose() {
    _pc.dispose();
    _nickCtrl.dispose();
    _userCtrl.dispose();
    _otherAllergyCtrl.dispose();
    super.dispose();
  }

  bool get _usernameOk =>
      RegExp(r'^[A-Za-z0-9_.]{3,20}$').hasMatch(_userCtrl.text.trim());

  bool get _canNext {
    switch (_step) {
      case 0:
        return _gender != null;
      case 1:
        return _nickCtrl.text.trim().isNotEmpty && _usernameOk;
      case 2:
        return _age != null;
      case 3:
        return _allergies.isNotEmpty ||
            _otherAllergyCtrl.text.trim().isNotEmpty;
      case 4:
        return _cooking != null;
    }
    return false;
  }

  Future<void> _next() async {
    if (_step < _lastStep) {
      setState(() => _step++);
      _pc.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      await _finish();
    }
  }

  void _back() {
    if (_step == 0) return;
    setState(() => _step--);
    _pc.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    final allergies = _allergies.toList();
    final other = _otherAllergyCtrl.text.trim();
    if (other.isNotEmpty) allergies.add(other);

    await prefs.setString('gender', _gender!);
    await prefs.setString('nickname', _nickCtrl.text.trim());
    await prefs.setString('username', _userCtrl.text.trim());
    await prefs.setString('age', _age!);
    await prefs.setStringList('allergies', allergies);
    await prefs.setString('cooking', _cooking!);
    await prefs.setBool('onboarded', true);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MealFormPage()),
    );
  }

  Widget _page(String title, Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _genderCard(String value, String label, String asset) {
    final selected = _gender == value;
    final color = Theme.of(context).colorScheme.primary;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? color : Colors.grey.shade300,
              width: selected ? 3 : 1,
            ),
          ),
          child: Column(
            children: [
              Image.asset(asset, height: 130, fit: BoxFit.contain),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(value: (_step + 1) / (_lastStep + 1)),
            Expanded(
              child: PageView(
                controller: _pc,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // 1) เลือกเพศ (ซ้าย = ชาย, ขวา = หญิง)
                  _page(
                    'คุณเป็นใคร?',
                    Row(
                      children: [
                        _genderCard('boy', 'ชาย', 'assets/boy.png'),
                        const SizedBox(width: 16),
                        _genderCard('girl', 'หญิง', 'assets/girl.png'),
                      ],
                    ),
                  ),

                  // 2) ชื่อเล่น + username
                  _page(
                    'ตั้งชื่อของคุณ',
                    Column(
                      children: [
                        TextField(
                          controller: _nickCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            labelText: 'ชื่อเล่น',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _userCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixText: '@',
                            helperText:
                                'ภาษาอังกฤษ ตัวเลข _ หรือ . ความยาว 3-20 ตัว',
                            errorText: _userCtrl.text.isEmpty || _usernameOk
                                ? null
                                : 'รูปแบบไม่ถูกต้อง',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3) อายุ
                  _page(
                    'อายุอยู่ในช่วงไหน?',
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _ages
                          .map(
                            (a) => ChoiceChip(
                              label: Text(a),
                              selected: _age == a,
                              onSelected: (_) => setState(() => _age = a),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  // 4) อาหารที่แพ้
                  _page(
                    'มีอาหารที่แพ้ไหม?',
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _allergyOptions
                              .map(
                                (a) => FilterChip(
                                  label: Text(a),
                                  selected: _allergies.contains(a),
                                  onSelected: (on) => setState(() {
                                    if (a == 'ไม่มี') {
                                      _allergies.clear();
                                      if (on) _allergies.add(a);
                                    } else {
                                      _allergies.remove('ไม่มี');
                                      on
                                          ? _allergies.add(a)
                                          : _allergies.remove(a);
                                    }
                                  }),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _otherAllergyCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            labelText: 'อื่นๆ (พิมพ์เพิ่มได้)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 5) ทำอาหารบ่อยแค่ไหน
                  _page(
                    'ทำอาหารบ่อยแค่ไหน?',
                    Column(
                      children: _cookingOptions
                          .map(
                            (c) => RadioListTile<String>(
                              title: Text(c),
                              value: c,
                              groupValue: _cooking,
                              onChanged: (v) => setState(() => _cooking = v),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_step > 0)
                    OutlinedButton(
                      onPressed: _back,
                      child: const Text('ย้อนกลับ'),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _canNext ? _next : null,
                    child: Text(_step == _lastStep ? 'เสร็จสิ้น' : 'ต่อไป'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// หน้าบันทึกมื้ออาหาร (ส่งข้อมูลเข้า Google Sheets)
// ---------------------------------------------------------------------------
class MealFormPage extends StatefulWidget {
  const MealFormPage({super.key});

  @override
  State<MealFormPage> createState() => _MealFormPageState();
}

class _MealFormPageState extends State<MealFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _foodCtrl = TextEditingController();
  final _calCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _meal = 'เช้า';
  bool _sending = false;

  @override
  void dispose() {
    _foodCtrl.dispose();
    _calCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);

    try {
      final res = await http.post(
        Uri.parse(kScriptUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'food': _foodCtrl.text.trim(),
          'meal': _meal,
          'calories': _calCtrl.text.trim(),
          'note': _noteCtrl.text.trim(),
        }),
      );

      // Apps Script ตอบกลับเป็น 302 (redirect) แต่ข้อมูลถูกบันทึกแล้ว
      final ok = res.statusCode == 200 || res.statusCode == 302;
      if (!mounted) return;

      if (ok) {
        _foodCtrl.clear();
        _calCtrl.clear();
        _noteCtrl.clear();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ok ? 'บันทึกแล้ว' : 'บันทึกไม่สำเร็จ (${res.statusCode})'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ส่งข้อมูลไม่ได้ ตรวจสอบอินเทอร์เน็ต')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกมื้ออาหาร')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _foodCtrl,
                decoration: const InputDecoration(
                  labelText: 'ชื่ออาหาร',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'กรอกชื่ออาหาร' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _meal,
                decoration: const InputDecoration(
                  labelText: 'มื้อ',
                  border: OutlineInputBorder(),
                ),
                items: const ['เช้า', 'กลางวัน', 'เย็น', 'ของว่าง']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _meal = v ?? _meal),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _calCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'แคลอรี่ (ไม่บังคับ)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'หมายเหตุ (ไม่บังคับ)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _sending ? null : _submit,
                  child: _sending
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('บันทึก'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
