# SOFTEM RESTAURANT

A complete **offline** restaurant website for Lagos, built with HTML, CSS and vanilla JavaScript.

The layout, design system and interaction concepts are adapted from the **Tech World Watches** project:

- Sticky dark header with a gold accent, hero visual and quick stats
- A filterable product grid driven by a real **SQLite** database (SQL.js)
- Hidden staff dashboard with a database console
- Masonry gallery, blog cards and a contact form
- Cart drawer, product detail modal and a full checkout flow
- Fully responsive, no frameworks and no build step

---

## 1. How to run it

1. Keep the folder structure intact (see below).
2. **Double-click `index.html`** (or right-click → Open with → your browser).
3. That's it. No server, no installation.

> Works in Chrome, Edge, Firefox, Opera and Brave. It also works completely **offline**: the SQL.js runtime and WebAssembly binary are bundled in `vendor/`, and all photos and fonts are stored in `assets/`.

### File structure

```
Softem/
├── index.html                     # single-page site (all sections)
├── softem.html                    # redirect to index.html (old link)
├── style.css                      # design system + responsive layout
├── script.js                      # SQL.js database logic + UI logic
├── README.md                      # this file
├── database/
│   └── softem_restaurant.sql      # MySQL/MariaDB dump for XAMPP (phpMyAdmin)
├── assets/
│   ├── hero.jpg
│   ├── dish-1.jpg … dish-8.jpg
│   ├── gallery-1.jpg … gallery-6.jpg
│   └── fonts/                     # Poppins woff2 (bundled for offline use)
└── vendor/                        # SQL.js 1.10.3, bundled for offline use
    ├── sql-wasm.js
    ├── sql-wasm.wasm
    └── sql-wasm-base64.js
```

---

## 2. Where is the "real database"?

The site uses **SQL.js**, which is the SQLite C library compiled to WebAssembly. It creates an actual SQLite database in memory, and `script.js` saves a copy of the database file to `localStorage` after every change.

| What | Where |
|---|---|
| Table | `dishes` |
| Saved DB key | `localStorage["softem_db_file"]` (base64 of the whole `.db` file) |
| Cart key | `localStorage["softem_cart"]` |
| Contact messages | `localStorage["softem_contact_messages"]` |
| Orders | `localStorage["softem_orders"]` |
| Admin session (tab only) | `sessionStorage["softem_admin_session"]` |
| Exported SQLite file | `softem_restaurant.db` |
| XAMPP / MySQL import | `database/softem_restaurant.sql` |

### Schema

```sql
CREATE TABLE IF NOT EXISTS dishes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  price INTEGER NOT NULL,
  image TEXT NOT NULL,
  category TEXT DEFAULT 'mains',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Seed data (inserted automatically on first load)

| # | Dish | Price (₦) | Category |
|---|---|---|---|
| 1 | Smoky Jollof Rice | 5,000 | mains |
| 2 | Softem Beef Burger | 5,000 | mains |
| 3 | Pepperoni Pizza | 7,500 | mains |
| 4 | Crispy Fries | 3,000 | sides |
| 5 | Puff Puff (6 pcs) | 2,000 | pastries |
| 6 | Glazed Doughnut | 700 | pastries |
| 7 | Grilled Chicken | 6,500 | mains |
| 8 | Chapman Cooler | 2,500 | drinks |

---

## 3. Admin panel & database

> The database console is **hidden from normal visitors**. Click **Admin** and sign in with **`admin` / `admin123`**.

- **Menu cards come from SQL** — `SELECT * FROM dishes`.
- **Add a dish** in the console (name, price, category, image) → click **INSERT INTO DB**.
- **Refresh the page (F5)** → the new dish is still there because the database file was saved to `localStorage`.
- **Export .db File** downloads a real SQLite file you can open in [DB Browser for SQLite](https://sqlitebrowser.org/).
- **Export MySQL .sql** downloads a fresh phpMyAdmin import file.
- **Show SQL Log** lists every query with row counts and execution time.
- **Reset DB** restores the 8 seed dishes.
- **Lock panel** hides the console until the next sign-in.

The admin login is a client-side gate for demonstration only — it is not real authentication.

---

## 4. Customer flow

1. Browse the menu and filter by **All / Mains / Sides / Pastries / Drinks**.
2. Click **Add to Cart** or **View** a dish.
3. Open the cart, adjust quantities and click **Checkout**.
4. Confirm the delivery details and choose a payment method.
5. Click **Place Order** → receive an order number (`SFT-0001`, `SFT-0002`, …) and a confirmation screen.

Orders are saved to `localStorage["softem_orders"]`; the cart is emptied after checkout. No payment is processed and no data leaves the browser.

---

## 5. Open the database in XAMPP (MySQL / MariaDB)

1. Start **Apache** and **MySQL** in the XAMPP Control Panel.
2. Open **http://localhost/phpmyadmin** (user `root`, blank password by default).
3. Click **Import** → **Choose File** → select `database/softem_restaurant.sql` → **Go**.
4. Browse **Databases → softem_restaurant → dishes**.

To keep MySQL in sync after adding dishes in the admin panel, click **Export MySQL .sql** and import that file again. The browser database and MySQL are separate copies and do not sync automatically.

---

## 6. Feature checklist

- [x] Nav bar: Home / Our Menu / Gallery / Blog / Contact Us / Cart (0) + Admin entry
- [x] Hero with floating dish image, gold glow and live dish count
- [x] Filterable menu grid (3 columns desktop, 1 column mobile) populated from SQL
- [x] Category badges, ₦ prices, Add to Cart, dish detail modal
- [x] Hidden staff dashboard with login (`admin` / `admin123`)
- [x] Database console: insert, delete, SQL log, export `.db`, export MySQL `.sql`, reset
- [x] XAMPP/phpMyAdmin import file with the same 8 dishes
- [x] Cart drawer with quantity controls, persisted in `localStorage`
- [x] Checkout with prefilled customer, saved card, order number and confirmation
- [x] Gallery: 6 image masonry layout
- [x] Blog: 3 kitchen articles
- [x] Contact form (validated, saved to `localStorage`)
- [x] Gold / black / white theme, `border-radius: 12px`, soft shadows
- [x] Works offline, opens by double-clicking `index.html`, no console errors

---

## 7. Notes

- **Clearing site data / localStorage wipes the database.** Export the `.db` first if you need a backup.
- `localStorage` is per-browser and per-origin. Opening the file from a different path or browser gives you a fresh database.
- All photos are stored locally in `assets/`, so the gallery and menu work without internet.
- The project intentionally stays server-free, just like the Tech World Watches reference.
