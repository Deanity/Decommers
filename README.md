# 🛒 Decommers — Freebies E-Commerce App

A modern, premium **Flutter** mobile e-commerce application branded as **"Freebies"** — a marketplace with free shipping, attractive discounts, and a clean shopping experience.

---

## 📱 Preview Fitur

| Halaman | Deskripsi |
|---|---|
| **Splash Screen** | Layar pembuka bertemakan hijau vibran dengan CTA "Mulai Belanja" |
| **Home (UnLogin)** | Halaman utama untuk pengguna yang belum login, semua aksi diarahkan ke login modal |
| **Home (Login)** | Halaman utama penuh dengan carousel banner, kategori, produk unggulan, dan flash sale |
| **Category Screen** | Daftar produk berdasarkan kategori dengan filter |
| **Detail Produk** | Halaman detail produk lengkap dengan gambar, deskripsi, varian, dan tombol beli |
| **Cart** | Keranjang belanja dengan manajemen item dan ringkasan harga |
| **Search Screen** | Pencarian produk dengan riwayat pencarian dan state animasi |
| **Wishlist** | Daftar produk favorit pengguna |
| **Orders** | Riwayat dan status pesanan pengguna |
| **Profile** | Halaman profil dengan info akun, edit profil, dan pengaturan |
| **Edit Profile** | Form edit data diri pengguna |
| **Sign In** | Login dengan email/nomor HP dan password |
| **Sign Up** | Registrasi 3 langkah: Email → Verifikasi OTP → Nama & Password |
| **Reset Password** | Alur reset sandi via email/HP + verifikasi OTP |

---

## 🗂️ Struktur Proyek

```
decommers/
├── lib/
│   ├── main.dart                                    # Entry point aplikasi
│   ├── splash/
│   │   └── splashScreen.dart                        # Layar splash (landing page)
│   ├── unlogin/
│   │   └── unLogin.dart                             # Home tampilan guest (belum login)
│   ├── home/
│   │   ├── homePage.dart                            # Home tampilan user terautentikasi
│   │   ├── category/
│   │   │   └── categoryScreen.dart                  # Halaman kategori produk
│   │   ├── product/
│   │   │   ├── detailProduct.dart                   # Halaman detail produk
│   │   │   └── cartProduct.dart                     # Halaman keranjang belanja
│   │   ├── search/
│   │   │   └── searchScreen.dart                    # Halaman pencarian produk
│   │   ├── whishlist/
│   │   │   └── whislistScreen.dart                  # Halaman wishlist
│   │   ├── order/
│   │   │   └── orderScreen.dart                     # Halaman riwayat pesanan
│   │   └── profile/
│   │       ├── profileScreen.dart                   # Halaman profil pengguna
│   │       ├── editProfileScreen.dart               # Form edit profil
│   │       └── settingScreen.dart                   # Halaman pengaturan
│   ├── auth/
│   │   ├── SignIn/
│   │   │   ├── signIn.dart                          # Halaman login
│   │   │   ├── resetPassword.dart                   # Reset password (input email/HP)
│   │   │   ├── verificationPassword.dart            # Verifikasi OTP untuk reset sandi
│   │   │   └── confirmPassword.dart                 # Konfirmasi password baru
│   │   └── SignUp/
│   │       ├── registerAccountEmail.dart            # Step 1: Input email/HP
│   │       ├── registerAccountVerification.dart     # Step 2: OTP 4 digit
│   │       └── registerAccountName-Password.dart    # Step 3: Nama, password, referral
│   ├── models/
│   │   └── user_model.dart                          # Model data pengguna (Firestore)
│   ├── services/
│   │   └── auth_service.dart                        # Service Firebase Auth & Firestore
│   └── components/
│       ├── product_card.dart                        # Kartu produk reusable
│       ├── category_item.dart                       # Item kategori (ikon + label)
│       ├── section_header.dart                      # Header seksi dengan "See All"
│       ├── custom_search_bar.dart                   # Search bar dekoratif di home
│       ├── custom_text_field.dart                   # Input field dengan toggle password
│       ├── toast_popup.dart                         # Notifikasi toast custom (success/error/warning/info)
│       └── news_item.dart                           # Item berita/artikel
├── assets/
│   ├── icon/
│   │   └── logo4.png                                # Logo untuk launcher icon
│   └── images/
│       ├── waving_hand_3d.png                       # Ilustrasi di login modal
│       └── success_illustration_3d.png              # Ilustrasi sukses registrasi
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
                                        │                                       ├── Home
                                        │                                       ├── Wishlist
                                        │                                       ├── Orders
                                        │                                       └── Profile
                                        │                                               ├── EditProfile
                                        │                                               └── Settings
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

### `ToastPopup`
Sistem notifikasi toast custom menggantikan SnackBar bawaan:
- 4 tipe: `success` 🟢, `error` 🔴, `warning` 🟡, `info` 🔵
- Muncul dari atas layar dengan animasi slide-in
- Judul dan pesan terkustomisasi
- Digunakan di seluruh alur autentikasi (Sign In, Sign Up, Reset Password)

### `NewsItem`
Widget artikel/berita dengan thumbnail, judul, subtitle, dan tanggal.

---

## 🔐 Backend & Autentikasi

### `AuthService` (`lib/services/auth_service.dart`)
Service layer untuk operasi Firebase:

| Method | Deskripsi |
|---|---|
| `register()` | Daftar akun baru + simpan data ke Firestore |
| `signIn()` | Login dengan email & password |
| `signOut()` | Logout dari sesi aktif |
| `resetPassword()` | Kirim email reset password via Firebase |
| `currentUser` | Getter user yang sedang login |
| `userStream` | Stream perubahan status autentikasi |

### `UserModel` (`lib/models/user_model.dart`)
Model data pengguna yang disimpan di Firestore collection `users`:
- `uid` — Firebase UID
- `fullName` — Nama lengkap
- `email` — Alamat email
- `referralCode` — Kode referral (opsional)
- `createdAt` — Timestamp registrasi

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
  firebase_core: ^3.10.1
  firebase_auth: ^5.4.1
  cloud_firestore: ^5.6.2
  firebase_storage: ^12.4.0
  provider: ^6.1.2

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
- Akun Firebase dengan project yang sudah dikonfigurasi (`google-services.json` / `GoogleService-Info.plist`)

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
- [x] Category screen dengan daftar produk per kategori
- [x] Detail produk (gambar, deskripsi, varian, harga)
- [x] Keranjang belanja (Cart) — UI & manajemen item
- [x] Search screen dengan riwayat pencarian & state kosong
- [x] Wishlist screen (UI)
- [x] Order screen — riwayat pesanan (UI)
- [x] Profile screen dengan info akun
- [x] Edit Profile screen
- [x] Setting screen
- [x] Login modal bottom sheet untuk pengguna guest
- [x] Alur Sign In lengkap dengan Firebase Auth → navigasi ke Home
- [x] Alur Sign Up 3 langkah (Email → OTP → Nama & Password)
- [x] Success modal animasi setelah registrasi (auto-navigate 3 detik)
- [x] Alur Reset Password (Email → OTP Verifikasi → Konfirmasi Password baru)
- [x] Firebase Authentication (email & password)
- [x] Cloud Firestore — penyimpanan data pengguna
- [x] `AuthService` — service layer autentikasi
- [x] `UserModel` — model data pengguna
- [x] State management (Provider)
- [x] `ToastPopup` — sistem notifikasi toast custom (success/error/warning/info)
- [x] Error handling spesifik Firebase (`invalid-credential`, `user-not-found`, dll)
- [x] Loading state di semua tombol aksi autentikasi

## 🔮 Fitur yang Belum Diimplementasi (To-Do)

- [ ] Integrasi Firestore untuk data produk nyata
- [ ] Wishlist fungsional (tambah/hapus dari Firestore)
- [ ] Keranjang belanja terintegrasi backend
- [ ] Checkout & payment flow
- [ ] Notifikasi push (Firebase Cloud Messaging)
- [ ] Pencarian produk nyata dari API/Firestore
- [ ] Upload foto profil (Firebase Storage)
- [ ] Order tracking nyata

---

## 📄 Lisensi

Proyek ini bersifat privat dan tidak dipublikasikan ke pub.dev (`publish_to: 'none'`).
