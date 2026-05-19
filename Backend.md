# 🔥 Backend Documentation — Decommers App (Firebase)

Dokumen ini merinci arsitektur backend menggunakan **Firebase** untuk aplikasi Decommers (Freebies), mencakup skema Firestore lengkap, aturan keamanan, dan rencana implementasi.

---

## 1. Firebase Services Mapping

| Service | Kegunaan |
|---|---|
| **Firebase Authentication** | Login/Register email & password, Password Reset |
| **Cloud Firestore** | Database NoSQL — semua data aplikasi |
| **Firebase Storage** | Hosting gambar produk, foto profil, banner |
| **Cloud Functions** | Logika backend: update rating, kurangi stok, validasi kupon |
| **Firebase Cloud Messaging** | Push notification order status & promo |

---

## 2. Firestore Data Structure (NoSQL)

### A. `users` (Collection)
> Dibuat otomatis saat registrasi oleh `AuthService.register()`

```
users/
└── {uid}                          ← Document ID = Firebase Auth UID
    ├── full_name        : String
    ├── email            : String
    ├── phone_number     : String   (opsional)
    ├── avatar_url       : String   (Firebase Storage URL)
    ├── referral_code    : String   (opsional, dari step 3 registrasi)
    ├── is_verified      : Boolean
    ├── country          : String   (default: "Indonesia")
    └── created_at       : Timestamp
```

---

### B. `categories` (Collection)
> Diisi manual oleh admin via Firebase Console

```
categories/
└── {category_id}
    ├── label            : String   → "Fashion", "Electronic", dll
    ├── icon_identifier  : String   → nama ikon material
    ├── color_hex        : String   → "#5BC33C"
    └── order            : Number   → urutan tampil di UI
```

---

### C. `products` (Collection)
> Data produk utama, diquery oleh homePage, categoryScreen, searchScreen

```
products/
└── {product_id}
    ├── category_id      : String   → ref ke categories/{id}
    ├── title            : String
    ├── description      : String
    ├── price            : Number   → harga normal (Rupiah)
    ├── original_price   : Number   → harga sebelum diskon (untuk badge SALE)
    ├── discount_percent : Number   → persentase diskon (0 jika tidak ada)
    ├── stock            : Number
    ├── rating_avg       : Number   → 0.0 – 5.0 (diupdate Cloud Function)
    ├── reviews_count    : Number   → total ulasan (diupdate Cloud Function)
    ├── is_sale          : Boolean  → tampilkan badge SALE di ProductCard
    ├── is_featured      : Boolean  → tampil di section "Featured Product"
    ├── is_best_seller   : Boolean  → tampil di section "Best Sellers"
    ├── images           : Array<String>  → list URL Firebase Storage
    ├── variants         : Array<Map>     → varian produk
    │     ├── type       : String   → "Color" / "Size"
    │     └── options    : Array<String>  → ["Red","Blue"] / ["S","M","L","XL"]
    ├── tags             : Array<String>  → untuk pencarian ["headphone","audio"]
    └── created_at       : Timestamp
```

---

### D. `reviews` (Sub-collection di bawah produk)
> Diakses dari `reviewScreen.dart` — satu produk bisa punya banyak review

```
products/
└── {product_id}/
    └── reviews/              ← Sub-collection
        └── {review_id}
            ├── user_id       : String   → ref ke users/{uid}
            ├── user_name     : String   → denormalized untuk performa
            ├── user_avatar   : String   → denormalized URL foto profil
            ├── rating        : Number   → 1 – 5
            ├── comment       : String
            ├── images        : Array<String>  → foto dari reviewer (opsional)
            └── created_at    : Timestamp
```

> **Catatan:** Saat review baru ditambah, **Cloud Function** otomatis menghitung ulang `rating_avg` dan `reviews_count` di dokumen produknya.

---

### E. `wishlists` (Sub-collection di bawah user)
> Diakses dari `whislistScreen.dart`

```
users/
└── {uid}/
    └── wishlists/            ← Sub-collection
        └── {product_id}      ← Document ID = product_id (mudah cek & hapus)
            ├── product_id    : String
            ├── title         : String   → denormalized
            ├── price         : Number   → denormalized
            ├── image_url     : String   → denormalized (gambar pertama)
            ├── rating_avg    : Number   → denormalized
            └── added_at      : Timestamp
```

---

### F. `carts` (Sub-collection di bawah user)
> Diakses dari `cartProduct.dart`

```
users/
└── {uid}/
    └── cart/                 ← Sub-collection
        └── {product_id}      ← Document ID = product_id (mencegah duplikat)
            ├── product_id    : String
            ├── title         : String   → denormalized
            ├── price         : Number   → denormalized (harga saat ditambah)
            ├── image_url     : String   → denormalized
            ├── selected_variant : Map   → {"Color": "Red", "Size": "M"}
            ├── quantity      : Number
            └── added_at      : Timestamp
```

---

### G. `orders` (Collection)
> Dibuat saat user klik "Pay Now" di `cartPayment.dart`

```
orders/
└── {order_id}
    ├── user_id           : String   → ref ke users/{uid}
    ├── status            : String   → "pending" | "paid" | "processing" | "shipped" | "delivered" | "cancelled"
    ├── payment_method    : String   → "Credit Card" | "E-Wallet" | "Bank Transfer"
    ├── payment_status    : String   → "unpaid" | "paid" | "refunded"
    │
    ├── items             : Array<Map>
    │     ├── product_id  : String
    │     ├── title       : String
    │     ├── image_url   : String
    │     ├── price       : Number   → harga saat checkout (snapshot)
    │     ├── quantity    : Number
    │     └── variant     : Map      → {"Color": "Red", "Size": "M"}
    │
    ├── shipping_detail   : Map      → dari cartDelivery.dart
    │     ├── street      : String
    │     ├── city        : String
    │     ├── province    : String
    │     ├── zip_code    : String
    │     └── country     : String
    │
    ├── delivery_method   : String   → "Standard" | "Express"
    ├── delivery_fee      : Number
    │
    ├── personal_detail   : Map      → dari cartDetail.dart
    │     ├── full_name   : String
    │     ├── email       : String
    │     ├── phone       : String
    │     └── country     : String
    │
    ├── pricing           : Map
    │     ├── subtotal    : Number
    │     ├── discount    : Number
    │     ├── delivery_fee: Number
    │     └── total       : Number
    │
    ├── coupon_code       : String   → opsional
    └── created_at        : Timestamp
```

---

### H. `coupons` (Collection)
> Untuk fitur kupon di `cartDetail.dart`

```
coupons/
└── {coupon_code}             ← Document ID = kode kupon (mis: "FREEBIES50")
    ├── discount_type    : String   → "percent" | "fixed"
    ├── discount_value   : Number   → 50 (%) atau 50000 (Rp)
    ├── min_purchase     : Number   → minimal total belanja
    ├── max_discount     : Number   → batas maksimal potongan
    ├── is_active        : Boolean
    ├── used_count       : Number
    ├── max_usage        : Number
    └── expired_at       : Timestamp
```

---

### I. `banners` (Collection)
> Data carousel banner promo di `homePage.dart`

```
banners/
└── {banner_id}
    ├── title            : String   → "Special Offer"
    ├── subtitle         : String   → "Up to 50% off"
    ├── image_url        : String   → Firebase Storage URL
    ├── color_start      : String   → "#5BC33C" (gradient start)
    ├── color_end        : String   → "#3DA828" (gradient end)
    ├── action_type      : String   → "product" | "category" | "url"
    ├── action_value     : String   → product_id / category_id / URL
    ├── order            : Number   → urutan carousel
    └── is_active        : Boolean
```

---

### J. `news` (Collection)
> Data artikel/berita di `homePage.dart` via `NewsItem` component

```
news/
└── {news_id}
    ├── title            : String
    ├── subtitle         : String
    ├── content          : String
    ├── image_url        : String
    ├── created_at       : Timestamp
    └── is_published     : Boolean
```

---

## 3. Relasi Antar Koleksi

```
users ──────────────┬──► wishlists (sub-collection)
                    ├──► cart      (sub-collection)
                    └──► orders    (via user_id field)

products ───────────┬──► reviews   (sub-collection)
                    └──► categories (via category_id)

orders ─────────────└──► users     (via user_id)
```

---

## 4. Firestore Security Rules (Rekomendasi)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Users: hanya bisa baca/tulis data sendiri
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;

      match /wishlists/{productId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /cart/{productId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }

    // Products: semua bisa baca, hanya admin yang bisa tulis
    match /products/{productId} {
      allow read: if true;
      allow write: if request.auth.token.admin == true;

      match /reviews/{reviewId} {
        allow read: if true;
        allow create: if request.auth != null;
        allow update, delete: if request.auth != null
          && request.auth.uid == resource.data.user_id;
      }
    }

    // Categories, Banners, News: publik read
    match /categories/{id} { allow read: if true; }
    match /banners/{id}     { allow read: if true; }
    match /news/{id}        { allow read: if true; }

    // Orders: hanya user pemilik yang bisa baca
    match /orders/{orderId} {
      allow read: if request.auth != null
        && request.auth.uid == resource.data.user_id;
      allow create: if request.auth != null;
    }

    // Coupons: publik read (validasi via Cloud Function)
    match /coupons/{code} { allow read: if true; }
  }
}
```

---

## 5. Cloud Functions (Rekomendasi)

| Function | Trigger | Aksi |
|---|---|---|
| `onReviewCreated` | `onCreate` di `products/{id}/reviews` | Hitung ulang `rating_avg` & `reviews_count` di produk |
| `onOrderCreated` | `onCreate` di `orders` | Kurangi `stock` produk, kosongkan `cart` user |
| `validateCoupon` | HTTP Callable | Validasi kode kupon & hitung diskon |
| `onOrderStatusChanged` | `onUpdate` di `orders` | Kirim FCM push notification ke user |

---

## 6. Firebase Storage Structure

```
storage/
├── products/
│   └── {product_id}/
│       ├── image_1.jpg
│       └── image_2.jpg
├── profiles/
│   └── {uid}/
│       └── avatar.jpg
├── banners/
│   └── banner_1.jpg
└── reviews/
    └── {product_id}/
        └── {review_id}/
            └── photo_1.jpg
```

---

## 7. Implementation Plan

### ✅ Phase 1 — Sudah Selesai
- [x] Firebase Auth — email/password login & register
- [x] Firestore `users` collection — simpan data user saat registrasi
- [x] `AuthService` — sign in, sign up, sign out, reset password

### 🔧 Phase 2 — Data Produk (Prioritas Utama)
1. Buat `categories` di Firestore Console (isi manual 5 kategori)
2. Buat `products` di Firestore Console (isi beberapa produk dummy)
3. Update `homePage.dart` — fetch produk dari Firestore dengan `StreamBuilder`
4. Update `categoryScreen.dart` — filter `where('category_id', '==', id)`
5. Update `searchScreen.dart` — query dengan `where('tags', 'array-contains', keyword)`

### 🔧 Phase 3 — Wishlist & Cart
1. Implementasi add/remove wishlist → `users/{uid}/wishlists/{product_id}`
2. Implementasi add/remove cart → `users/{uid}/cart/{product_id}`
3. Update quantity di cart — update field `quantity`
4. Hitung total harga cart secara realtime

### 🔧 Phase 4 — Checkout & Orders
1. Saat "Pay Now" → create dokumen di `orders` collection
2. Kosongkan `cart` sub-collection user setelah order dibuat
3. Kurangi `stock` produk (via Cloud Function atau langsung)
4. Tampilkan daftar order di `orderScreen.dart` dari Firestore

### 🔧 Phase 5 — Reviews
1. Saat user submit review → tambah doc ke `products/{id}/reviews`
2. Cloud Function otomatis update `rating_avg` di produk
3. `reviewScreen.dart` fetch review dari sub-collection

### 🔧 Phase 6 — Finishing
1. Upload foto profil ke Firebase Storage → update `avatar_url` di Firestore
2. Setup FCM untuk push notification status order
3. Implementasi validasi kupon
4. Deploy Security Rules ke production

---

## 8. Keunggulan Firebase untuk Decommers

| Aspek | Detail |
|---|---|
| **Real-time** | Produk & promo update instan dengan `snapshots()` |
| **Serverless** | Tidak perlu manage server atau migration |
| **Sub-collection** | Cart & wishlist per-user terisolasi dengan baik |
| **Scalable** | Otomatis handle peningkatan user |
| **Offline** | Firestore mendukung cache offline otomatis |
