import 'package:flutter/material.dart';

void main() => runApp(const KitchenFairyApp());

// ---------- Palette (cozy pixel cream/tan/brown) ----------
const cream = Color(0xFFFFF6E6);
const paper = Color(0xFFFFFBF2);
const tan = Color(0xFFD4AF6A);
const brown = Color(0xFF5A3E2B);
const btnColor = Color(0xFFA9742F);
const btnBorder = Color(0xFF7A4F1D);
const rose = Color(0xFFE5555F);
const softPink = Color(0xFFFFE9D6);
const softMint = Color(0xFFE4F6EA);

// ---------- Data ----------
const Map<String, List<String>> ingredientGroups = {
  'เนื้อสัตว์ / โปรตีน': ['หมูสับ', 'ไข่', 'ปลากระป๋อง', 'ไก่', 'เต้าหู้'],
  'เครื่องปรุง / เครื่องหอม': ['น้ำปลา', 'ซีอิ๊ว', 'กระเทียม', 'พริก', 'น้ำมันหอย'],
  'ผัก': ['คะน้า', 'กะหล่ำปลี', 'มะเขือเทศ', 'ต้นหอม', 'แครอท'],
};

const Map<String, String> ingredientEmoji = {
  'หมูสับ': '🥩', 'ไข่': '🥚', 'ปลากระป๋อง': '🐟', 'ไก่': '🍗', 'เต้าหู้': '⬜',
  'น้ำปลา': '🍶', 'ซีอิ๊ว': '🥫', 'กระเทียม': '🧄', 'พริก': '🌶️', 'น้ำมันหอย': '🥫',
  'คะน้า': '🥬', 'กะหล่ำปลี': '🥬', 'มะเขือเทศ': '🍅', 'ต้นหอม': '🌿', 'แครอท': '🥕',
};

class Menu {
  final String name, emoji;
  final List<String> ingredients; // 4 slots, repeats allowed
  final List<String> steps;
  const Menu(this.name, this.emoji, this.ingredients, this.steps);
}

const List<Menu> menus = [
  Menu('หมูสับผัดคะน้าไข่ดาว', '🍳', ['หมูสับ', 'ไข่', 'น้ำปลา', 'คะน้า'], [
    'ตั้งกระทะ ใส่น้ำมันเล็กน้อย ทอดไข่ดาวให้ขอบกรอบ ตักพักไว้',
    'ใส่หมูสับลงผัดจนสุกและเริ่มหอม',
    'ใส่คะน้า ปรุงด้วยน้ำปลา ผัดไฟแรงประมาณ 1-2 นาที',
    'ตักใส่จาน วางไข่ดาวด้านบน เสิร์ฟกับข้าวสวยร้อนๆ',
  ]),
  Menu('ไข่เจียวหมูสับ', '🍳', ['ไข่', 'หมูสับ', 'น้ำปลา', 'ต้นหอม'], [
    'ตอกไข่ใส่ชาม ใส่หมูสับ ต้นหอมซอย และน้ำปลา ตีให้เข้ากัน',
    'ตั้งน้ำมันให้ร้อนจัด เทไข่ลงไป',
    'ทอดจนฟูและเหลืองทั้งสองด้าน ตักขึ้นเสิร์ฟ',
  ]),
  Menu('ผัดกะหล่ำปลีไข่', '🥬', ['กะหล่ำปลี', 'ไข่', 'ซีอิ๊ว', 'กระเทียม'], [
    'ทุบกระเทียม ผัดในน้ำมันจนหอม',
    'ใส่กะหล่ำปลีลงผัดจนเริ่มนิ่ม',
    'ตอกไข่ลงไป ปรุงด้วยซีอิ๊ว ผัดให้เข้ากัน',
    'ตักเสิร์ฟทันที',
  ]),
  Menu('ไก่ผัดพริกกระเทียม', '🍗', ['ไก่', 'กระเทียม', 'พริก', 'น้ำมันหอย'], [
    'โขลกกระเทียมกับพริกพอหยาบ',
    'ผัดในน้ำมันจนหอม ใส่ไก่ผัดจนสุก',
    'ปรุงด้วยน้ำมันหอย ผัดให้เข้ากัน แล้วตักเสิร์ฟ',
  ]),
  Menu('เต้าหู้ซอสมะเขือเทศ', '🍅', ['เต้าหู้', 'มะเขือเทศ', 'ซีอิ๊ว', 'ต้นหอม'], [
    'หั่นเต้าหู้เป็นชิ้น ทอดจนเหลืองเล็กน้อย',
    'ใส่มะเขือเทศหั่นลงผัดจนยุ่ย',
    'ปรุงด้วยซีอิ๊ว ใส่เต้าหู้กลับลงไปคลุกเบาๆ',
    'โรยต้นหอมก่อนเสิร์ฟ',
  ]),
  Menu('ปลากระป๋องผัดพริก', '🐟', ['ปลากระป๋อง', 'พริก', 'กระเทียม', 'ต้นหอม'], [
    'ผัดกระเทียมกับพริกให้หอม',
    'ใส่ปลากระป๋อง ผัดให้ปลาแตกพอประมาณ',
    'โรยต้นหอม ชิมรสแล้วตักเสิร์ฟกับข้าวสวย',
  ]),
  Menu('ผัดผักรวมหมูสับ', '🥕', ['หมูสับ', 'แครอท', 'กะหล่ำปลี', 'น้ำมันหอย'], [
    'ผัดหมูสับจนสุก',
    'ใส่แครอทและกะหล่ำปลี ผัดไฟแรง',
    'ปรุงด้วยน้ำมันหอย ผัดให้เข้ากันแล้วตักเสิร์ฟ',
  ]),
  Menu('ต้มไข่มะเขือเทศ', '🍲', ['ไข่', 'ไข่', 'มะเขือเทศ', 'น้ำปลา'], [
    'ต้มไข่ 2 ฟอง 8 นาที แล้วปอกเปลือก',
    'ใส่มะเขือเทศลงต้มในน้ำ ปรุงด้วยน้ำปลา',
    'ใส่ไข่ต้มลงไป เคี่ยวต่ออีก 2-3 นาที เสิร์ฟร้อนๆ',
  ]),
];

class Post {
  final String author, title, emoji;
  bool liked = false, saved = false;
  Post(this.author, this.title, this.emoji);
}

const levelTitles = [
  'เชฟหนูน้อย',
  'เชฟประจำบ้าน',
  'รองหัวหน้าเชฟ',
  'หัวหน้าเชฟ',
  'เชฟระดับตำนาน',
];

// ---------- App state ----------
class AppState extends ChangeNotifier {
  bool registered = false;
  String name = '';
  String gender = 'Girl';
  String avatar = '👧';
  String age = '';
  int xp = 0;
  bool missionDone = false;
  String missionText = '';
  final Set<String> fridge = {};
  final List<Post> posts = [
    Post('น้องมิ้นท์', 'สูตรข้าวผัดแสนอร่อย', '🍛'),
    Post('พี่เบน', 'ไข่เจียวหมูสับ', '🍳'),
    Post('ครัวคุณแม่', 'ต้มไข่มะเขือเทศ', '🍲'),
    Post('เชฟแพร', 'ไก่ผัดพริกกระเทียม', '🍗'),
  ];

  int get level => xp ~/ 100 + 1;
  double get levelProgress => (xp % 100) / 100;
  String get levelTitle =>
      levelTitles[(level - 1).clamp(0, levelTitles.length - 1)];

  void register(String n, String g, String a, String ag) {
    name = n;
    gender = g;
    avatar = a;
    age = ag;
    registered = true;
    notifyListeners();
  }

  void completeMenu(String menuName) {
    xp += 20;
    missionDone = true;
    missionText = 'ทำเมนู $menuName สำเร็จแล้ว!';
    notifyListeners();
  }

  void postPhoto(String title, String emoji) {
    posts.insert(0, Post(name, title, emoji));
    xp += 30;
    notifyListeners();
  }
}

final AppState app = AppState();

// ---------- Shared widgets ----------
Widget pixelCard(Widget child,
        {Color color = paper, EdgeInsets pad = const EdgeInsets.all(14)}) =>
    Container(
      padding: pad,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tan, width: 3),
        boxShadow: const [BoxShadow(color: Color(0x33000000), offset: Offset(0, 3))],
      ),
      child: child,
    );

const titleStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: brown);
const bodyStyle = TextStyle(fontSize: 14, color: brown);

class PixelButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const PixelButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: btnBorder, width: 3),
          ),
          alignment: Alignment.center,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
        ),
      );
}

Widget xpBar(double v) => ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: v,
        minHeight: 14,
        backgroundColor: const Color(0xFFEBD9B4),
        valueColor: const AlwaysStoppedAnimation<Color>(rose),
      ),
    );

class KitchenFairyApp extends StatelessWidget {
  const KitchenFairyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'นางฟ้าก้นครัว',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: btnColor,
          scaffoldBackgroundColor: cream,
        ),
        home: ListenableBuilder(
          listenable: app,
          builder: (context, _) => app.registered ? Shell() : WelcomePage(),
        ),
      );
}

// ============ 1. Welcome & Registration ============
class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final nameCtl = TextEditingController();
  final ageCtl = TextEditingController();
  String gender = 'Girl';
  String avatar = '👧';

  static const avatars = {
    'Boy': ['👦', '🧑'],
    'Girl': ['👧', '👩'],
  };

  @override
  void dispose() {
    nameCtl.dispose();
    ageCtl.dispose();
    super.dispose();
  }

  Widget genderTab(String g) => GestureDetector(
        onTap: () => setState(() {
          gender = g;
          avatar = avatars[g]![0];
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: gender == g ? brown : Colors.transparent, width: 3)),
          ),
          child: Text(g, style: titleStyle),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Center(
                  child: Text('นางฟ้าก้นครัว',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: brown))),
              const SizedBox(height: 12),
              pixelCard(
                const Column(children: [
                  SizedBox(height: 8),
                  Text('🐻', style: TextStyle(fontSize: 90)),
                  Text('🍳 🏠 🍳', style: TextStyle(fontSize: 22)),
                  SizedBox(height: 8),
                ]),
                color: softPink,
                pad: const EdgeInsets.all(8),
              ),
              const SizedBox(height: 14),
              const Center(
                child: Text('ยินดีต้อนรับสู่ KITCHEN FAIRY!\nมาเป็นเชฟน้อยด้วยกันนะ~',
                    textAlign: TextAlign.center, style: titleStyle),
              ),
              const SizedBox(height: 14),
              pixelCard(Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  genderTab('Boy'),
                  const SizedBox(width: 16),
                  genderTab('Girl'),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (final a in avatars[gender]!)
                    GestureDetector(
                      onTap: () => setState(() => avatar = a),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: avatar == a ? softMint : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: avatar == a ? brown : tan, width: 3),
                        ),
                        child: Text(a, style: const TextStyle(fontSize: 34)),
                      ),
                    ),
                ]),
                const SizedBox(height: 14),
                TextField(
                  controller: nameCtl,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อของคุณ', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ageCtl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'อายุโดยประมาณ', border: OutlineInputBorder()),
                ),
              ])),
              const SizedBox(height: 16),
              PixelButton(
                label: 'เริ่มทำอาหารเลย!',
                onTap: () {
                  if (nameCtl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ใส่ชื่อของคุณก่อนนะ')));
                    return;
                  }
                  app.register(
                      nameCtl.text.trim(), gender, avatar, ageCtl.text.trim());
                },
              ),
            ],
          ),
        ),
      );
}

// ============ Shell with bottom nav ============
class Shell extends StatefulWidget {
  Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int tab = 0;

  Widget navItem(int i, String label, IconData icon) => GestureDetector(
        onTap: () => setState(() => tab = i),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: tab == i ? btnColor : brown.withOpacity(0.5)),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: tab == i ? btnColor : brown.withOpacity(0.5))),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final pages = [FeedPage(), FridgePage(), ProfilePage()];
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: paper, border: Border(top: BorderSide(color: tan, width: 3))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              navItem(0, 'Home', Icons.home),
              navItem(1, 'Fridge', Icons.kitchen),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UploadPage())),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: btnBorder, width: 3),
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
              navItem(2, 'Profile', Icons.person),
            ]),
          ),
        ),
      ),
    );
  }
}

// ============ 2. Community Recipe Feed ============
class FeedPage extends StatefulWidget {
  FeedPage({super.key});
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Widget postCard(Post p) => pixelCard(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('🧑‍🍳', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Expanded(
                child: Text(p.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: brown))),
          ]),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: softPink, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Text(p.emoji, style: const TextStyle(fontSize: 50)),
            ),
          ),
          const SizedBox(height: 6),
          Text(p.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w800, color: brown)),
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () => setState(() => p.liked = !p.liked),
              child: Icon(p.liked ? Icons.favorite : Icons.favorite_border,
                  color: rose, size: 22),
            ),
            const Icon(Icons.chat_bubble_outline, color: brown, size: 20),
            GestureDetector(
              onTap: () => setState(() => p.saved = !p.saved),
              child: Icon(p.saved ? Icons.bookmark : Icons.bookmark_border,
                  color: btnColor, size: 22),
            ),
          ]),
        ]),
        pad: const EdgeInsets.all(8),
      );

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: paper,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: tan, width: 2),
                ),
                child: const Row(children: [
                  Icon(Icons.search, color: brown, size: 20),
                  SizedBox(width: 6),
                  Text('Search', style: bodyStyle),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: softPink,
                shape: BoxShape.circle,
                border: Border.all(color: tan, width: 2),
              ),
              child: Text(app.avatar, style: const TextStyle(fontSize: 22)),
            ),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('เมนูแนะนำจากเพื่อนๆ', style: titleStyle)),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: app.posts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (_, i) => postCard(app.posts[i]),
          ),
        ),
      ]);
}

// ============ 3. Fridge Inventory & Recipe Generator ============
class FridgePage extends StatefulWidget {
  FridgePage({super.key});
  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  bool generated = false;

  List<Menu> get matches => menus
      .where((m) => m.ingredients.toSet().every(app.fridge.contains))
      .toList();

  Widget tile(String ing) {
    final on = app.fridge.contains(ing);
    return GestureDetector(
      onTap: () => setState(() {
        on ? app.fridge.remove(ing) : app.fridge.add(ing);
        generated = false;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: on ? softMint : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: on ? brown : tan, width: 3),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(ingredientEmoji[ing] ?? '🍽️', style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 6),
          Text(ing,
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: brown, fontSize: 13)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final found = matches;
    return ListView(padding: const EdgeInsets.all(14), children: [
      const Center(
          child: Text('นางฟ้าก้นครัว',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: brown))),
      const SizedBox(height: 12),
      pixelCard(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('🧊 ตู้เย็นของคุณ แตะเลือกของที่มี', style: titleStyle),
          const SizedBox(height: 10),
          for (final g in ingredientGroups.entries) ...[
            Text(g.key, style: bodyStyle),
            const SizedBox(height: 6),
            Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [for (final i in g.value) tile(i)]),
            const SizedBox(height: 12),
          ],
        ]),
        color: const Color(0xFFEAF2F8),
      ),
      const SizedBox(height: 14),
      PixelButton(
          label: 'Cooking Process: สร้างเมนู',
          onTap: () => setState(() => generated = true)),
      const SizedBox(height: 14),
      if (generated) ...[
        Text(
            app.fridge.isEmpty
                ? 'ยังไม่ได้เลือกวัตถุดิบ'
                : 'กำลังปรุงเมนูง่ายๆ จากวัตถุดิบที่คุณเลือก... ทำได้ ${found.length} เมนู',
            style: bodyStyle),
        const SizedBox(height: 8),
        if (found.isEmpty && app.fridge.isNotEmpty)
          const Text('ยังไม่มีเมนูที่ใช้ของครบ ลองเพิ่มวัตถุดิบดู', style: bodyStyle),
        for (final m in found)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MenuPage(menu: m))),
              child: pixelCard(Row(children: [
                Text(m.emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(child: Text(m.name, style: titleStyle)),
                const Icon(Icons.chevron_right, color: brown),
              ])),
            ),
          ),
      ],
    ]);
  }
}

class MenuPage extends StatelessWidget {
  final Menu menu;
  const MenuPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: paper,
            foregroundColor: brown,
            title: Text(menu.name)),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Center(child: Text(menu.emoji, style: const TextStyle(fontSize: 70))),
          const SizedBox(height: 12),
          const Text('วัตถุดิบ', style: titleStyle),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final i in menu.ingredients)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: softMint,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: brown, width: 2),
                ),
                child: Text('${ingredientEmoji[i] ?? ''} $i',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: brown)),
              ),
          ]),
          const SizedBox(height: 18),
          const Text('วิธีทำ', style: titleStyle),
          const SizedBox(height: 8),
          for (var n = 0; n < menu.steps.length; n++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: pixelCard(Text('${n + 1}. ${menu.steps[n]}', style: bodyStyle)),
            ),
          const SizedBox(height: 8),
          PixelButton(
            label: 'ทำเมนูนี้เสร็จแล้ว (+20 XP)',
            onTap: () {
              app.completeMenu(menu.name);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ได้ +20 XP! ภารกิจวันนี้สำเร็จ')));
              Navigator.pop(context);
            },
          ),
        ]),
      );
}

// ============ 4. Profile & Level System ============
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  Widget badge(int lvl, bool current) => Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: current ? const Color(0xFFFFE08A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: current ? brown : tan, width: 3),
        ),
        child: Text('$lvl', style: titleStyle),
      );

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Center(
              child: Text('นางฟ้าก้นครัว',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900, color: brown))),
          const SizedBox(height: 12),
          pixelCard(Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: softPink,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: tan, width: 3),
              ),
              child: Text(app.avatar, style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${app.levelTitle}: ${app.name}', style: titleStyle),
                const SizedBox(height: 8),
                xpBar(app.levelProgress),
              ]),
            ),
          ])),
          const SizedBox(height: 14),
          pixelCard(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ระดับเลเวลของคุณ: Level ${app.level}', style: titleStyle),
            const SizedBox(height: 8),
            xpBar(app.levelProgress),
            const SizedBox(height: 8),
            Text('XP รวม ${app.xp}  (อีก ${100 - app.xp % 100} XP ขึ้นเลเวลถัดไป)',
                style: bodyStyle),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              badge(app.level, true),
              badge(app.level + 1, false),
              badge(app.level + 2, false),
            ]),
          ])),
          const SizedBox(height: 14),
          pixelCard(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('ภารกิจวันนี้', style: titleStyle),
            const SizedBox(height: 8),
            Row(children: [
              Icon(app.missionDone ? Icons.check_box : Icons.check_box_outline_blank,
                  color: btnColor),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(
                      app.missionDone
                          ? app.missionText
                          : 'ทำเมนูจากตู้เย็น 1 เมนู',
                      style: bodyStyle)),
            ]),
          ])),
          const SizedBox(height: 14),
          PixelButton(
            label: 'ส่งรูปถ่ายอาหาร (+30 XP)',
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => UploadPage())),
          ),
        ],
      );
}

// ============ Upload (share your dish) ============
class UploadPage extends StatefulWidget {
  UploadPage({super.key});
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final titleCtl = TextEditingController();
  String emoji = '🍛';
  static const dishes = ['🍛', '🍳', '🍲', '🍗', '🥗', '🍜', '🍱', '🥘'];

  @override
  void dispose() {
    titleCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: paper,
            foregroundColor: brown,
            title: const Text('ส่งรูปถ่ายอาหาร')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const Text('เลือกหน้าตาจานของคุณ', style: titleStyle),
          const SizedBox(height: 4),
          const Text('(เวอร์ชันถัดไปจะเพิ่มการถ่าย/เลือกรูปจริงจากมือถือ)',
              style: TextStyle(fontSize: 12, color: brown)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final d in dishes)
              GestureDetector(
                onTap: () => setState(() => emoji = d),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: emoji == d ? softMint : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: emoji == d ? brown : tan, width: 3),
                  ),
                  child: Text(d, style: const TextStyle(fontSize: 32)),
                ),
              ),
          ]),
          const SizedBox(height: 16),
          TextField(
            controller: titleCtl,
            decoration: const InputDecoration(
                labelText: 'ชื่อเมนู', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          PixelButton(
            label: 'โพสต์เลย (+30 XP)',
            onTap: () {
              if (titleCtl.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ใส่ชื่อเมนูก่อนนะ')));
                return;
              }
              app.postPhoto(titleCtl.text.trim(), emoji);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('โพสต์แล้ว! ได้ +30 XP')));
              Navigator.pop(context);
            },
          ),
        ]),
      );
}
