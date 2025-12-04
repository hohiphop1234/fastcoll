# Bắt Đầu Nhanh - MD5 Collision Demo

## ⚡ Chạy Demo trong 3 bước

### Bước 1: Kiểm tra Docker
```bash
docker --version
```
Nếu chưa có Docker, tải từ: https://www.docker.com/products/docker-desktop

### Bước 2: Chạy Demo

**Windows (PowerShell):**
```powershell
.\demo_windows.ps1
```

**Linux/macOS:**
```bash
chmod +x demo.sh
./demo.sh
```

### Bước 3: Xem kết quả
Script sẽ tự động:
- Build Docker image
- Tạo 2 file collision: `demo_msg1.bin` và `demo_msg2.bin`
- Hiển thị MD5 hash của cả 2 file (sẽ giống nhau!)

## 📋 Kết quả mong đợi

Sau khi chạy thành công, bạn sẽ thấy:
```
MD5 hash of demo_msg1.bin: [một chuỗi hex]
MD5 hash of demo_msg2.bin: [cùng chuỗi hex]
```

**Điều này chứng minh:** Hai file khác nhau nhưng có cùng MD5 hash!

## 🔍 So sánh chi tiết (tùy chọn)

```bash
python compare_files.py demo_msg1.bin demo_msg2.bin
```

## 📚 Tài liệu đầy đủ

- **Hướng dẫn chi tiết:** [HUONG_DAN_DEMO.md](HUONG_DAN_DEMO.md)
- **Hướng dẫn thuyết trình:** [PRESENTATION_GUIDE.md](PRESENTATION_GUIDE.md)

## ❓ Gặp vấn đề?

1. **Docker không chạy:** Đảm bảo Docker Desktop đang mở
2. **Lỗi permission:** Trên Linux, thử `sudo` hoặc thêm user vào docker group
3. **Build chậm:** Lần đầu sẽ mất thời gian, các lần sau nhanh hơn

## 🎯 Mục đích Demo

Chứng minh rằng **MD5 không còn an toàn** vì có thể tạo collision (hai file khác nhau có cùng hash).

---

**Chúc bạn demo thành công! 🚀**

