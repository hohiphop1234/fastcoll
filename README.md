fastcoll
========

MD5 collision generator v1.5
by Marc Stevens (http://www.win.tue.nl/hashclash/)

This is the source to fastcoll-v1.0.0.5-1.zip and a docker container to match.

## Quick Start Demo (Vietnamese)

### Cách chạy nhanh:

**Trên Windows (PowerShell):**
```powershell
.\demo_windows.ps1
```

**Trên Linux/macOS:**
```bash
chmod +x demo.sh
./demo.sh
```

### Hướng dẫn chi tiết:

Xem file [HUONG_DAN_DEMO.md](HUONG_DAN_DEMO.md) để có hướng dẫn đầy đủ bằng tiếng Việt.

## Usage

### Build Docker image:
```bash
docker build -t fastcoll:demo .
```

### Generate collision with prefix file:
```bash
# Linux/macOS
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo --prefixfile input -o msg1.bin msg2.bin

# Windows PowerShell
docker run --rm -v "${PWD}:/work" -w /work fastcoll:demo --prefixfile input -o msg1.bin msg2.bin
```

### Generate collision without prefix:
```bash
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo -o msg1.bin msg2.bin
```

### Show help:
```bash
docker run --rm fastcoll:demo --help
```
