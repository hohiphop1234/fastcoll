# Hướng Dẫn Thuyết Trình - MD5 Collision Attack

## Cấu trúc bài thuyết trình đề xuất

### 1. Phần mở đầu (5 phút)

**Giới thiệu về Hash Functions:**
- Hash function là gì?
- Ứng dụng của hash functions (checksum, digital signatures, password storage)
- Tính chất quan trọng: collision resistance

**Vấn đề:**
- MD5 từng được sử dụng rộng rãi
- Nhưng đã bị phát hiện có lỗ hổng collision

### 2. Phần lý thuyết (10 phút)

**MD5 là gì?**
- Message Digest Algorithm 5
- Tạo hash 128-bit (32 ký tự hex)
- Được thiết kế bởi Ronald Rivest năm 1991

**MD5 Collision là gì?**
- Khả năng tạo hai input khác nhau có cùng hash
- Phát hiện lần đầu: 2004 (Wang et al.)
- FastColl: công cụ tạo collision nhanh (vài giây)

**Tại sao nguy hiểm?**
- Không thể tin tưởng MD5 để xác thực file
- Có thể tạo file giả mạo với cùng hash
- Ứng dụng trong tấn công: fake certificates, malware distribution

### 3. Phần Demo (10 phút)

#### Bước 1: Chuẩn bị
```bash
# Đảm bảo Docker đang chạy
# Mở terminal/PowerShell trong thư mục dự án
```

#### Bước 2: Chạy demo
**Windows:**
```powershell
.\demo_windows.ps1
```

**Linux/macOS:**
```bash
./demo.sh
```

#### Bước 3: Giải thích kết quả
- Hiển thị hai file được tạo: `demo_msg1.bin` và `demo_msg2.bin`
- So sánh MD5 hash (sẽ giống nhau!)
- So sánh nội dung file (sẽ khác nhau!)

#### Bước 4: So sánh chi tiết (tùy chọn)
```bash
python compare_files.py demo_msg1.bin demo_msg2.bin
```

### 4. Phần phân tích (5 phút)

**Kỹ thuật tạo collision:**
- Differential cryptanalysis
- Tìm differential path
- Tạo hai block với cùng hash output

**Tác động thực tế:**
- Certificate Authority attacks
- File integrity verification không còn đáng tin
- Cần chuyển sang SHA-256 hoặc SHA-3

### 5. Phần kết luận (5 phút)

**Bài học:**
- Không bao giờ dùng MD5 cho mục đích bảo mật
- Luôn cập nhật và sử dụng thuật toán hash mới nhất
- Hiểu rõ giới hạn của các công cụ bảo mật

**Giải pháp:**
- Sử dụng SHA-256 hoặc SHA-3
- Kiểm tra và cập nhật hệ thống thường xuyên
- Hiểu rõ về collision resistance

## Slide đề xuất

1. **Slide 1: Tiêu đề**
   - MD5 Collision Attack
   - Tên sinh viên, lớp, môn học

2. **Slide 2: Giới thiệu Hash Functions**
   - Định nghĩa
   - Ứng dụng
   - Tính chất quan trọng

3. **Slide 3: MD5 Overview**
   - Lịch sử
   - Cách hoạt động (sơ đồ)
   - Đặc điểm kỹ thuật

4. **Slide 4: MD5 Collision**
   - Định nghĩa collision
   - Lịch sử phát hiện
   - Tác động

5. **Slide 5: Demo Setup**
   - Yêu cầu hệ thống
   - Công cụ sử dụng (FastColl)
   - Mục tiêu demo

6. **Slide 6: Kết quả Demo**
   - Screenshot hai file
   - So sánh MD5 hash
   - So sánh nội dung

7. **Slide 7: Phân tích kỹ thuật**
   - Differential cryptanalysis
   - Quy trình tạo collision
   - Độ phức tạp

8. **Slide 8: Tác động thực tế**
   - Case studies
   - Nguy cơ bảo mật
   - Ví dụ tấn công

9. **Slide 9: Giải pháp**
   - SHA-256/SHA-3
   - Best practices
   - Migration guide

10. **Slide 10: Kết luận**
    - Tóm tắt
    - Bài học
    - Q&A

## Tips cho thuyết trình

### Trước khi thuyết trình:
1. **Test demo trước:**
   - Chạy thử script nhiều lần
   - Đảm bảo Docker hoạt động
   - Chuẩn bị backup plan nếu demo fail

2. **Chuẩn bị slides:**
   - Slide đơn giản, dễ đọc
   - Nhiều hình ảnh, ít chữ
   - Màu sắc rõ ràng

3. **Luyện tập:**
   - Nói trước gương
   - Ghi âm và nghe lại
   - Tính thời gian

### Trong khi thuyết trình:
1. **Giữ bình tĩnh:**
   - Nếu demo fail, giải thích lý thuyết
   - Có thể dùng kết quả đã chuẩn bị trước

2. **Tương tác với khán giả:**
   - Đặt câu hỏi
   - Giải thích rõ ràng
   - Kiểm tra xem mọi người có hiểu không

3. **Nhấn mạnh điểm quan trọng:**
   - MD5 không còn an toàn
   - Cần chuyển sang SHA-256
   - Hiểu rõ về collision resistance

### Câu hỏi có thể gặp:

**Q: Tại sao MD5 vẫn được sử dụng?**
A: Một số hệ thống cũ vẫn dùng MD5 vì tương thích ngược. Nhưng không nên dùng cho mục đích bảo mật.

**Q: SHA-256 có an toàn không?**
A: Hiện tại SHA-256 vẫn được coi là an toàn. Nhưng cần theo dõi các nghiên cứu mới.

**Q: Có thể tạo collision cho SHA-256 không?**
A: Về mặt lý thuyết có thể, nhưng cần thời gian và tài nguyên khổng lồ (2^256 operations). Hiện tại không khả thi.

**Q: Làm sao biết một hash function an toàn?**
A: Dựa vào:
- Không có collision được tìm thấy
- Độ phức tạp tính toán để tìm collision
- Được cộng đồng nghiên cứu đánh giá

## Tài liệu tham khảo

- [MD5 Collision Demo - Marc Stevens](http://www.win.tue.nl/hashclash/)
- [MD5 - Wikipedia](https://en.wikipedia.org/wiki/MD5)
- [Collision Attack - Wikipedia](https://en.wikipedia.org/wiki/Collision_attack)
- [NIST Hash Function Standards](https://csrc.nist.gov/projects/hash-functions)

## Checklist trước khi thuyết trình

- [ ] Docker đã cài đặt và chạy được
- [ ] Đã test demo script thành công
- [ ] Đã chuẩn bị slides
- [ ] Đã luyện tập thuyết trình
- [ ] Đã chuẩn bị câu trả lời cho câu hỏi thường gặp
- [ ] Đã backup kết quả demo (screenshot/files)
- [ ] Đã kiểm tra thiết bị trình chiếu
- [ ] Đã có plan B nếu demo fail

---

**Chúc bạn thuyết trình thành công! 🎓**

