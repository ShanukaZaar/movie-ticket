# 🎬 Online Movie Ticket Reservation System

A Java web application for online movie ticket booking, built as a group project using **Servlets, JSP, JDBC, and MySQL** following the **MVC architecture pattern**.

---

## 📋 Tech Stack

| Layer      | Technology               |
|------------|--------------------------|
| Backend    | Java Servlets            |
| Frontend   | JSP + Bootstrap 5 (CDN)  |
| Database   | MySQL (JDBC)             |
| Build Tool | Apache Maven             |
| Server     | Apache Tomcat 9+         |
| Pattern    | MVC (Model-View-Controller) |

---

## 📁 Project Structure

```
movie-ticket-reservation/
├── pom.xml
├── README.md
├── .gitignore
├── database/
│   └── movie_db.sql
└── src/
    └── main/
        ├── java/
        │   └── com/movieticket/
        │       ├── model/          ← Data classes (POJOs)
        │       │   └── User.java
        │       ├── dao/            ← Database operations
        │       │   └── UserDAO.java
        │       ├── servlet/        ← Controllers (Servlets)
        │       │   └── TestServlet.java
        │       └── util/           ← Utility classes
        │           └── DBConnection.java
        └── webapp/
            ├── css/
            │   └── style.css
            ├── js/
            │   └── script.js
            ├── views/
            │   ├── login.jsp
            │   ├── register.jsp
            │   └── dashboard.jsp
            └── WEB-INF/
                └── web.xml
```

### Package Descriptions

| Package                       | Purpose                                  |
|-------------------------------|------------------------------------------|
| `com.movieticket.model`       | Java classes representing database tables |
| `com.movieticket.dao`         | Data Access Objects for DB operations     |
| `com.movieticket.servlet`     | Servlet controllers handling requests     |
| `com.movieticket.util`        | Utility classes (DB connection, etc.)     |

---

## 🚀 Setup Instructions

### Prerequisites
- Java JDK 17
- Apache Tomcat 9+
- MySQL Server 8.0+
- Apache Maven 3.6+
- IntelliJ IDEA (recommended)

### Step-by-Step Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/ShanukaZaar/movie-ticket.git
cd movie-ticket
```

#### 2. Create the MySQL Database
Open MySQL command line or MySQL Workbench and run:
```sql
SOURCE database/movie_db.sql;
```
Or manually create the database:
```sql
CREATE DATABASE movie_db;
```

#### 3. Update Database Credentials
Open `src/main/java/com/movieticket/util/DBConnection.java` and update:
```java
private static final String URL = "jdbc:mysql://localhost:3306/movie_db";
private static final String USER = "root";
private static final String PASSWORD = "your_password_here";
```

#### 4. Open in IntelliJ IDEA
1. Open IntelliJ IDEA
2. Click **File → Open** and select the project folder
3. IntelliJ will detect it as a Maven project and import dependencies automatically
4. Wait for Maven to download all dependencies

#### 5. Configure Tomcat in IntelliJ
1. Go to **Run → Edit Configurations**
2. Click **+** → **Tomcat Server → Local**
3. Set the Tomcat home directory
4. Go to the **Deployment** tab
5. Click **+** → **Artifact** → Select `movie-ticket-reservation:war exploded`
6. Set Application Context to `/movie-ticket-reservation`
7. Click **Apply → OK**

#### 6. Run the Project
1. Click the **Run** button (green play icon)
2. Open browser and go to: `http://localhost:8080/movie-ticket-reservation/test`
3. You should see: **"✅ Project is working!"**

---

## 🧩 Team Responsibilities (6 Members)

### Member 1: User Management
**Features:**
- User registration & login
- Password hashing
- Session management
- User profile management
- Role-based access (Admin / Customer)

**Suggested Classes:**
- `model/User.java` (already created as sample)
- `dao/UserDAO.java` (already created as sample)
- `servlet/LoginServlet.java`
- `servlet/RegisterServlet.java`
- `servlet/ProfileServlet.java`

**Suggested Database Tables:**
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'customer') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

### Member 2: Movie Management
**Features:**
- Add / Edit / Delete movies (Admin)
- View movie listings (All users)
- Search and filter movies
- Movie details page

**Suggested Classes:**
- `model/Movie.java`
- `dao/MovieDAO.java`
- `servlet/MovieServlet.java`

**Suggested Database Tables:**
```sql
CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    genre VARCHAR(100),
    duration INT,
    language VARCHAR(50),
    release_date DATE,
    description TEXT,
    poster_url VARCHAR(500),
    status ENUM('now_showing', 'coming_soon', 'ended') DEFAULT 'now_showing'
);
```

---

### Member 3: Theater & Show Management
**Features:**
- Add / Edit / Delete theaters (Admin)
- Manage screens and seating
- Schedule shows (assign movies to screens with times)
- View available shows

**Suggested Classes:**
- `model/Theater.java`
- `model/Screen.java`
- `model/Show.java`
- `dao/TheaterDAO.java`
- `dao/ShowDAO.java`
- `servlet/TheaterServlet.java`
- `servlet/ShowServlet.java`

**Suggested Database Tables:**
```sql
CREATE TABLE theaters (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    location VARCHAR(300),
    total_screens INT
);

CREATE TABLE screens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    theater_id INT,
    screen_name VARCHAR(50),
    total_seats INT,
    FOREIGN KEY (theater_id) REFERENCES theaters(id)
);

CREATE TABLE shows (
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    screen_id INT,
    show_date DATE,
    show_time TIME,
    price DECIMAL(10,2),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (screen_id) REFERENCES screens(id)
);
```

---

### Member 4: Booking System
**Features:**
- Seat selection interface
- Create / Cancel bookings
- View booking history
- Booking confirmation page

**Suggested Classes:**
- `model/Booking.java`
- `model/Seat.java`
- `dao/BookingDAO.java`
- `dao/SeatDAO.java`
- `servlet/BookingServlet.java`

**Suggested Database Tables:**
```sql
CREATE TABLE seats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    screen_id INT,
    seat_number VARCHAR(10),
    seat_type ENUM('regular', 'premium', 'vip') DEFAULT 'regular',
    FOREIGN KEY (screen_id) REFERENCES screens(id)
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    show_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status ENUM('confirmed', 'cancelled', 'pending') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
);

CREATE TABLE booking_seats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    seat_id INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (seat_id) REFERENCES seats(id)
);
```

---

### Member 5: Payment System
**Features:**
- Payment processing (simulated)
- Payment confirmation
- Payment history
- Refund handling

**Suggested Classes:**
- `model/Payment.java`
- `dao/PaymentDAO.java`
- `servlet/PaymentServlet.java`

**Suggested Database Tables:**
```sql
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_method ENUM('credit_card', 'debit_card', 'online_banking') NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('success', 'failed', 'refunded') DEFAULT 'success',
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);
```

---

### Member 6: Reports & Dashboard
**Features:**
- Admin dashboard with statistics
- Booking reports (daily, weekly, monthly)
- Revenue reports
- Movie popularity reports

**Suggested Classes:**
- `model/Report.java`
- `dao/ReportDAO.java`
- `servlet/ReportServlet.java`
- `servlet/DashboardServlet.java`

**Suggested Database Tables:**
> No additional tables needed. This module queries existing tables to generate reports using aggregate queries (COUNT, SUM, GROUP BY, etc.)

---

## 🔀 Git Workflow

### Branch Strategy
Each team member must work on their **own branch**. Do **NOT** push directly to `main`.

```bash
# Create your branch (do this once)
git checkout -b feature/user-management       # Member 1
git checkout -b feature/movie-management      # Member 2
git checkout -b feature/theater-management    # Member 3
git checkout -b feature/booking-system        # Member 4
git checkout -b feature/payment-system        # Member 5
git checkout -b feature/reports-dashboard     # Member 6
```

### Daily Workflow
```bash
# 1. Pull latest changes from main
git checkout main
git pull origin main

# 2. Switch to your branch and merge main
git checkout feature/your-branch
git merge main

# 3. Do your work, then commit
git add .
git commit -m "Add: description of your changes"

# 4. Push your branch
git push origin feature/your-branch

# 5. Create a Pull Request on GitHub for review
```

### Rules
- ⚠️ **Never push directly to `main`**
- ✅ Always create a **Pull Request** for merging
- ✅ Get at least **1 team member** to review your PR
- ✅ Write **meaningful commit messages**
- ✅ Pull from `main` **before starting new work**

---

## 🧪 Testing the Project

1. Start Tomcat and deploy the project
2. Visit: `http://localhost:8080/movie-ticket-reservation/test`
3. You should see the success message
4. Visit: `http://localhost:8080/movie-ticket-reservation/views/login.jsp`
5. You should see the login page

---

## 📝 Notes

- This is a **starter template only**. Each team member should implement their assigned component.
- Follow the **MVC pattern**: Model → DAO → Servlet → JSP
- Use **PreparedStatement** for all SQL queries (prevents SQL injection)
- Use **HttpSession** for managing logged-in users
- Add your own JSP pages under the `views/` folder
- Add your own CSS/JS files under `css/` and `js/` folders

---
