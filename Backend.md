# Backend Documentation - Decommers App (Firebase Version)

This document outlines the backend architecture using **Firebase** for the Decommers application.

## 1. Firebase Services Mapping
- **Authentication**: Email/Password login, Google Sign-In, and Password Reset.
- **Cloud Firestore**: NoSQL Database for all application data.
- **Firebase Storage**: Image hosting for products, profile pictures, and news.
- **Cloud Functions**: (Optional) For complex logic like calculating totals, processing payments, or sending notifications.

---

## 2. Firestore Data Structure (NoSQL)

### A. `users` (Collection)
- `{user_id}` (Document ID = Auth UID)
    - `full_name`: String
    - `email`: String
    - `referral_code`: String (Optional)
    - `avatar_url`: String
    - `is_verified`: Boolean
    - `wishlist`: Array<String> (Product IDs)
    - `created_at`: Timestamp

### B. `categories` (Collection)
- `{category_id}` (Document ID)
    - `label`: String
    - `icon_identifier`: String
    - `color_hex`: String
    - `order`: Number (For sorting in UI)

### C. `products` (Collection)
- `{product_id}` (Document ID)
    - `category_id`: String (Reference)
    - `title`: String
    - `description`: String
    - `price`: Number
    - `stock`: Number
    - `rating_avg`: Number
    - `reviews_count`: Number
    - `is_sale`: Boolean
    - `images`: Array<String> (Storage URLs)
    - `created_at`: Timestamp

### D. `reviews` (Collection)
- `{review_id}` (Document ID)
    - `product_id`: String (Index)
    - `user_id`: String
    - `user_name`: String (Denormalized for performance)
    - `rating`: Number (1-5)
    - `comment`: String
    - `created_at`: Timestamp

### E. `news` (Collection)
- `{news_id}` (Document ID)
    - `title`: String
    - `subtitle`: String
    - `content`: String
    - `image_url`: String
    - `created_at`: Timestamp

### F. `carts` (Collection)
- `{user_id}` (Document ID)
    - `items`: Array<Map>
        - `product_id`: String
        - `quantity`: Number
    - `updated_at`: Timestamp

### G. `orders` (Collection)
- `{order_id}` (Document ID)
    - `user_id`: String (Index)
    - `status`: String (Pending, Paid, Shipped, Completed)
    - `total_amount`: Number
    - `items`: Array<Map>
        - `product_id`: String
        - `title`: String
        - `price`: Number
        - `quantity`: Number
    - `shipping_address`: String
    - `created_at`: Timestamp

---

## 3. Implementation Plan (Flutter + Firebase)

### Phase 1: Setup
1. Create Firebase Project in Console.
2. Add Android/iOS app and download `google-services.json` / `GoogleService-Info.plist`.
3. Add `firebase_core`, `cloud_firestore`, `firebase_auth`, and `firebase_storage` to `pubspec.yaml`.

### Phase 2: Authentication
- Use `FirebaseAuth.instance.createUserWithEmailAndPassword` for registration.
- On success, create a document in the `users` collection with additional profile data.

### Phase 3: Data Fetching
- Use `FirebaseFirestore.instance.collection('products').snapshots()` for real-time updates on the home screen.
- Use `where('category_id', '==', selectedCategory)` for category filtering.

### Phase 4: Business Logic
- Use **Cloud Functions** to:
    - Update `rating_avg` on a product when a new review is added.
    - Reduce `stock` when an order is placed.
    - Validate referral codes.

---

## 4. Advantages of Firebase for Decommers
- **Real-time**: Produk dan promo bisa update instan tanpa refresh.
- **Serverless**: Tidak perlu manage server atau database migration.
- **Speed**: Development jauh lebih cepat untuk tahap MVP.
- **Scaling**: Otomatis menangani peningkatan user.

