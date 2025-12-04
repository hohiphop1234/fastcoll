# Hướng Dẫn Demo MD5 Collision - FastColl

## Giới thiệu

Đây là công cụ **FastColl** - MD5 collision generator được phát triển bởi Marc Stevens. Công cụ này chứng minh rằng thuật toán MD5 không còn an toàn vì có thể tạo ra hai file khác nhau nhưng có cùng giá trị hash MD5.

## Yêu cầu hệ thống

- **Docker** đã được cài đặt và đang chạy
- Hệ điều hành: Windows, Linux, hoặc macOS
- Ít nhất 500MB dung lượng trống

## Cài đặt Docker (nếu chưa có)

### Windows:
1. Tải Docker Desktop từ: https://www.docker.com/products/docker-desktop
2. Cài đặt và khởi động Docker Desktop
3. Đảm bảo Docker đang chạy (biểu tượng Docker xuất hiện ở system tray)

### Linux:
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Hoặc cài Docker Desktop từ website chính thức
```

### macOS:
1. Tải Docker Desktop từ: https://www.docker.com/products/docker-desktop
2. Cài đặt và khởi động Docker Desktop

## Hướng dẫn chạy Demo

### Cách 1: Sử dụng script tự động (Khuyến nghị)

#### Trên Linux/macOS:
```bash
# Cấp quyền thực thi cho script
chmod +x demo.sh

# Chạy demo
./demo.sh
```

#### Trên Windows (PowerShell):
```powershell
# Chạy script bash (cần Git Bash hoặc WSL)
bash demo.sh
```

### Cách 2: Chạy thủ công từng bước

#### Bước 1: Build Docker image
```bash
docker build -t fastcoll:demo .
```

Lệnh này sẽ:
- Tải base image Debian
- Cài đặt các thư viện cần thiết (build-essential, boost)
- Biên dịch source code thành file thực thi `fastcoll`
- Tạo Docker image nhẹ chỉ chứa file thực thi

#### Bước 2: Tạo file input demo (nếu chưa có)
```bash
# Tạo file input
echo "Hello, this is a demo file for MD5 collision demonstration." > demo_input.txt
```

#### Bước 3: Tạo MD5 collision
```bash
# Trên Linux/macOS
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo \
    --prefixfile demo_input.txt \
    -o demo_msg1.bin demo_msg2.bin

# Trên Windows PowerShell
docker run --rm -v "${PWD}:/work" -w /work fastcoll:demo --prefixfile demo_input.txt -o demo_msg1.bin demo_msg2.bin
```

Lệnh này sẽ:
- Tạo hai file `demo_msg1.bin` và `demo_msg2.bin`
- Hai file này khác nhau về nội dung
- Nhưng có cùng giá trị MD5 hash

#### Bước 4: Kiểm tra MD5 hash
```bash
# Trên Linux
md5sum demo_msg1.bin
md5sum demo_msg2.bin

# Trên macOS
md5 demo_msg1.bin
md5 demo_msg2.bin

# Trên Windows PowerShell
Get-FileHash demo_msg1.bin -Algorithm MD5
Get-FileHash demo_msg2.bin -Algorithm MD5
```

Bạn sẽ thấy hai file có cùng MD5 hash!

### Cách 3: Tạo collision không có prefix file

Nếu muốn tạo collision từ đầu (không dùng prefix file):

```bash
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo \
    -o collision1.bin collision2.bin
```

## Các tùy chọn khác

### Xem help
```bash
docker run --rm fastcoll:demo --help
```

### Tạo collision với initial hash value tùy chỉnh
```bash
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo \
    -i 0123456789abcdeffedcba9876543210 \
    -o output1.bin output2.bin
```

### Chạy ở chế độ quiet (ít thông tin output)
```bash
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo \
    -q --prefixfile demo_input.txt \
    -o msg1.bin msg2.bin
```

## Giải thích kỹ thuật

### MD5 Collision là gì?

MD5 collision là khả năng tạo ra hai input khác nhau nhưng có cùng giá trị hash MD5. Điều này chứng minh rằng:

1. **MD5 không còn an toàn**: Thuật toán MD5 đã bị "phá vỡ" về mặt lý thuyết và thực tế
2. **Không thể dùng MD5 để xác thực**: Không thể tin tưởng MD5 để kiểm tra tính toàn vẹn của file
3. **Nguy cơ bảo mật**: Kẻ tấn công có thể tạo file giả mạo có cùng hash với file hợp lệ

### Cách FastColl hoạt động

1. **Block 0**: Tạo block đầu tiên để đạt được một trạng thái trung gian cụ thể
2. **Block 1**: Tạo block thứ hai để đảm bảo cả hai message có cùng hash cuối cùng
3. **Differential path**: Sử dụng kỹ thuật differential cryptanalysis để tìm collision

### Ứng dụng trong thuyết trình

Khi thuyết trình, bạn có thể:

1. **Giải thích lý thuyết**: MD5 là gì, tại sao nó không an toàn
2. **Demo thực tế**: Chạy công cụ và tạo collision
3. **So sánh hash**: Chứng minh hai file khác nhau có cùng hash
4. **Phân tích file**: Dùng hex editor để xem sự khác biệt giữa hai file
5. **Kết luận**: Tại sao cần chuyển sang SHA-256 hoặc SHA-3

## Troubleshooting

### Lỗi: "Cannot connect to Docker daemon"
- Đảm bảo Docker Desktop đang chạy
- Trên Linux, có thể cần chạy với `sudo` hoặc thêm user vào docker group

### Lỗi: "No space left on device"
- Dọn dẹp Docker: `docker system prune -a`
- Xóa các image không dùng: `docker image prune -a`

### Lỗi: "Permission denied"
- Trên Linux: Thêm user vào docker group: `sudo usermod -aG docker $USER`
- Sau đó logout và login lại

### Build image chậm
- Lần đầu build sẽ mất thời gian để tải base image
- Các lần sau sẽ nhanh hơn nhờ Docker cache

## Tài liệu tham khảo

- [MD5 Collision Demo - Marc Stevens](http://www.win.tue.nl/hashclash/)
- [MD5 Wikipedia](https://en.wikipedia.org/wiki/MD5)
- [Hash Collision Attacks](https://en.wikipedia.org/wiki/Collision_attack)

## Lưu ý quan trọng

⚠️ **Công cụ này chỉ dùng cho mục đích giáo dục và nghiên cứu**

- Không sử dụng cho mục đích thương mại
- Không sử dụng để tấn công hệ thống
- Chỉ dùng trong môi trường được phép và có giám sát

## Câu hỏi thường gặp (FAQ)

**Q: Tại sao cần Docker?**
A: Docker đảm bảo môi trường chạy nhất quán trên mọi hệ điều hành, tránh vấn đề về dependencies.

**Q: Có thể chạy không cần Docker không?**
A: Có, nhưng cần cài đặt g++ và Boost libraries. Docker đơn giản hơn.

**Q: Mất bao lâu để tạo collision?**
A: Thường mất vài giây đến vài phút tùy vào cấu hình máy.

**Q: File output có kích thước bao nhiêu?**
A: Mỗi file collision thường có kích thước 128 bytes (2 blocks MD5).

**Q: Có thể tạo collision cho file lớn hơn không?**
A: Có, bằng cách sử dụng prefix file. Phần collision sẽ được thêm vào cuối.

## Liên hệ và hỗ trợ

Nếu gặp vấn đề khi chạy demo, vui lòng:
1. Kiểm tra Docker đã cài đặt và đang chạy
2. Xem lại các bước trong hướng dẫn
3. Kiểm tra log lỗi chi tiết

---

**Chúc bạn thuyết trình thành công! 🎓**

