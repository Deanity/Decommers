# 🛒 Decommers — Freebies E-Commerce App

A modern, premium **Flutter** mobile e-commerce application branded as **"Freebies"** — a marketplace with free shipping, attractive discounts, and a clean shopping experience.

---

## 📱 Preview Fitur

| Halaman | Deskripsi |
|---|---|
| **Splash Screen** | Layar pembuka bertemakan hijau vibran dengan CTA "Mulai Belanja" |
| **Home (UnLogin)** | Halaman utama untuk pengguna yang belum login, semua aksi diarahkan ke login modal |
| **Home (Login)** | Halaman utama penuh dengan carousel banner, kategori, produk unggulan, dan flash sale |
| **Search Screen** | Pencarian produk dengan riwayat pencarian dan state animasi |
| **Sign In** | Login dengan email/nomor HP dan password |
| **Sign Up** | Registrasi 3 langkah: Email → Verifikasi OTP → Nama & Password |
| **Reset Password** | Alur reset sandi via email/HP + verifikasi OTP |

---

## 🗂️ Struktur Proyek

```
decommers/
├── lib/
│   ├── main.dart                          # Entry point aplikasi
│   ├── splash/
│   │   └── splashScreen.dart              # Layar splash (landing page)
│   ├── unlogin/
│   │   └── unLogin.dart                   # Home tampilan guest (belum login)
│   ├── home/
│   │   ├── homePage.dart                  # Home tampilan user terautentikasi
│   │   └── search/
│   │       └── searchScreen.dart          # Halaman pencarian produk
│   ├── auth/
│   │   ├── SignIn/
│   │   │   ├── signIn.dart                # Halaman login
│   │   │   ├── resetPassword.dart         # Reset password (input email/HP)
│   │   │   ├── verificationPassword.dart  # Verifikasi OTP untuk reset sandi
│   │   │   └── confirmPassword.dart       # Konfirmasi password baru
│   │   └── SignUp/
│   │       ├── registerAccountEmail.dart  # Step 1: Input email/HP
│   │       ├── registerAccountVerification.dart  # Step 2: OTP 4 digit
│   │       └── registerAccountName-Password.dart # Step 3: Nama, password, referral
│   └── components/
│       ├── product_card.dart              # Kartu produk reusable
│       ├── category_item.dart             # Item kategori (ikon + label)
│       ├── section_header.dart            # Header seksi dengan "See All"
│       ├── custom_search_bar.dart         # Search bar dekoratif di home
│       ├── custom_text_field.dart         # Input field dengan toggle password
│       └── news_item.dart                 # Item berita/artikel
├── assets/
│   ├── icon/
│   │   ├── logo.png                       # Logo utama
│   │   └── logo4.png                      # Logo untuk launcher icon
│   └── images/
│       ├── waving_hand_3d.png             # Ilustrasi di login modal
│       └── success_illustration_3d.png    # Ilustrasi sukses registrasi
├── pubspec.yaml
└── README.md
```

---

## 🔄 Alur Navigasi

```
SplashScreen
    └── [Mulai Belanja] ──► UnLoginScreen (Guest Home)
                                ├── [Notif / Cart / Search / Produk / Kategori] ──► LoginModal
                                │       ├── [Login Sekarang] ──► SignInScreen
                                │       └── [Daftar Disini]  ──► SignInScreen
                                └── SignInScreen
                                        ├── [Sign In] ──────────────────► HomePage (Authenticated)
                                        ├── [Forgot Password] ──► ResetPasswordScreen
                                        │                              └── VerificationPasswordScreen
                                        │                                      └── ConfirmPasswordScreen
                                        └── [Sign Up] ──► RegisterAccountEmailScreen
                                                              └── RegisterAccountVerificationScreen (OTP)
                                                                    └── RegisterAccountNamePasswordScreen
                                                                              └── [Success Modal 3s] ──► HomePage
```

---

## 🧩 Komponen (`lib/components/`)

### `ProductCard`
Kartu produk reusable dengan:
- Gambar produk (placeholder ikon jika tidak ada asset)
- Badge `SALE` (opsional via `isSale`)
- Nama produk, harga (hijau), rating bintang, jumlah review
- Callback `onTap` untuk mendukung mode guest (modal login) dan mode auth

### `CategoryItem`
Ikon kategori vertikal dengan label:
- Fashion, Electronic, Furniture, Beauty, Gadget
- Warna ikon customizable

### `SectionHeader`
Header seksi dengan judul bold dan tombol "See All" (opsional via `onSeeAll` callback).

### `CustomSearchBar`
Search bar dekoratif di halaman home — berfungsi sebagai **tombol navigasi** ke `SearchScreen` (dibungkus `AbsorbPointer` + `GestureDetector`). Dilengkapi ikon QR scanner.

### `CustomTextField`
Input field serbaguna:
- Mendukung mode password dengan toggle visibilitas (show/hide)
- Label di atas field
- Background putih susu `#F9F9F9`

### `NewsItem`
Widget artikel/berita dengan thumbnail, judul, subtitle, dan tanggal.

---

## 🎨 Design System

| Token | Nilai |
|---|---|
| **Primary Color** | `#5BC33C` (Vibrant Green) |
| **Dark Text** | `#071221` / `#1A1A1A` |
| **Background** | `#F8F9FA` (home), `#FFFFFF` (auth) |
| **Card Background** | `#FFFFFF` dengan shadow halus |
| **Input Background** | `#F9F9F9` |
| **Font** | `Google Fonts — Outfit` |
| **Border Radius** | 15–24px (kartu, input, button) |

**Palet Banner Promo:**
- 🟢 Special Offer: `#5BC33C` gradient
- 🔵 New Arrival: `#2196F3` → `#00BCD4`
- 🔴 Flash Sale: `#FF5722` → `#FF9800`

---

## ⚙️ Dependensi

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^8.1.0

dev_dependencies:
  flutter_test: sdk: flutter
  flutter_lints: ^6.0.0
  flutter_launcher_icons: ^0.13.1
```

---

## 🚀 Cara Menjalankan

### Prasyarat
- Flutter SDK **≥ 3.11.4**
- Dart SDK **^3.11.4**
- Android Studio / VS Code dengan Flutter extension

### Langkah

```bash
# 1. Clone repositori
git clone <repo-url>
cd decommers

# 2. Install dependensi
flutter pub get

# 3. Jalankan aplikasi
flutter run

# 4. (Opsional) Generate launcher icon
dart run flutter_launcher_icons
```

---

## 📋 Fitur yang Sudah Diimplementasi

- [x] Splash screen dengan branding "Freebies"
- [x] Halaman home **guest** dengan perlindungan login modal di setiap interaksi
- [x] Halaman home **authenticated** dengan semua fitur aktif
- [x] Infinite carousel banner promo (3 tema warna)
- [x] Kategori produk horizontal scroll
- [x] Section Featured Product & Best Sellers
- [x] Flash sale banner dengan countdown timer (UI)
- [x] Bottom navigation bar (Home, Wishlist, Orders, Profile)
- [x] Search screen dengan riwayat pencarian & state kosong
- [x] Login modal bottom sheet untuk pengguna guest
- [x] Alur Sign In lengkap → navigasi ke Home
- [x] Alur Sign Up 3 langkah (Email → OTP → Nama & Password)
- [x] Success modal animasi setelah registrasi (auto-navigate 3 detik)
- [x] Alur Reset Password (Email → OTP Verifikasi → Konfirmasi Password baru)

## 🔮 Fitur yang Belum Diimplementasi (To-Do)

- [ ] Integrasi backend / autentikasi nyata (Firebase / Supabase)
- [ ] State management (Provider / Riverpod / BLoC)
- [ ] Halaman Wishlist, Orders, Profile yang fungsional
- [ ] Detail produk
- [ ] Keranjang belanja (Cart) fungsional
- [ ] Notifikasi push
- [ ] Pembayaran / checkout flow
- [ ] Pencarian produk nyata dari API

---

## 📄 Lisensi

Proyek ini bersifat privat dan tidak dipublikasikan ke pub.dev (`publish_to: 'none'`).
