CREATE DATABASE dtb_OT;
USE dtb_OT;

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    age_restriction INT DEFAULT 0
);


CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    max_seats INT NOT NULL,
    status ENUM('active', 'maintenance') DEFAULT 'active'
);


CREATE TABLE showtimes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    show_time DATETIME NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    CONSTRAINT chk_ticket_price CHECK (ticket_price >= 0)
);


CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    showtime_id INT NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE
);


INSERT INTO movies (title, duration_minutes, age_restriction) VALUES
('Dune: Part Two', 166, 13),
('Deadpool & Wolverine', 127, 18), -- Phim giới hạn 18 tuổi
('Kung Fu Panda 4', 94, 0),
('Lật Mặt 7: Một Điều Ước', 138, 13);


INSERT INTO rooms (name, max_seats, status) VALUES
('Phòng 1 (IMAX)', 200, 'active'),
('Phòng 2 (3D)', 150, 'active'),
('Phòng 3 (VIP)', 50, 'maintenance'); -- Phòng đang bảo trì


INSERT INTO showtimes (movie_id, room_id, show_time, ticket_price) VALUES
(1, 1, '2026-05-02 18:00:00', 100000), -- Suất 1: Dune chiếu ở Phòng 1
(2, 2, '2026-05-02 20:30:00', 120000), -- Suất 2: Deadpool 18+ chiếu ở Phòng 2
(3, 1, '2026-05-03 09:00:00', 75000),  -- Suất 3: Kung Fu Panda chiếu ở Phòng 1
(4, 2, '2026-05-03 14:00:00', 85000),  -- Suất 4: Lật Mặt 7 chiếu ở Phòng 2
(2, 1, '2026-05-03 22:00:00', 120000); -- Suất 5: Deadpool 18+ chiếu ở Phòng 1


INSERT INTO bookings (showtime_id, customer_name, phone) VALUES
(1, 'Nguyễn Văn Nam', '0912345678'),
(1, 'Trần Thị Hương', '0987654321'),
(2, 'Lê Đình Bảo', '0901112223'),
(2, 'Phạm Thu Trà', '0902223334'),
(3, 'Hoàng Minh Tuấn', '0903334445'),
(3, 'Vũ Thị Thanh', '0904445556'),
(4, 'Đặng Khắc Việt', '0905556667'),
(4, 'Bùi Lan Ngọc', '0906667778'),
(5, 'Đỗ Thái Sơn', '0907778889'),
(5, 'Hồ Tú Anh', '0908889990');