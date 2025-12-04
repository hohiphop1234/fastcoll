#!/bin/bash

echo "=========================================="
echo "  MD5 Collision Demo - FastColl"
echo "=========================================="
echo ""

# Tạo file input demo nếu chưa có
if [ ! -f "demo_input.txt" ]; then
    echo "Creating demo_input.txt..."
    echo "Hello, this is a demo file for MD5 collision demonstration." > demo_input.txt
fi

echo "Step 1: Building Docker image..."
docker build -t fastcoll:demo .

echo ""
echo "Step 2: Generating MD5 collision..."
echo "This will create two different files with the same MD5 hash..."
echo ""

# Tạo collision với prefix file
docker run --rm -v "$PWD:/work" -w /work fastcoll:demo \
    --prefixfile demo_input.txt \
    -o demo_msg1.bin demo_msg2.bin

if [ $? -eq 0 ]; then
    echo ""
    echo "Step 3: Verifying MD5 hashes..."
    echo ""
    
    # Kiểm tra MD5 hash (sử dụng md5sum hoặc md5 tùy hệ thống)
    if command -v md5sum &> /dev/null; then
        echo "MD5 hash of demo_msg1.bin:"
        md5sum demo_msg1.bin
        echo "MD5 hash of demo_msg2.bin:"
        md5sum demo_msg2.bin
    elif command -v md5 &> /dev/null; then
        echo "MD5 hash of demo_msg1.bin:"
        md5 demo_msg1.bin
        echo "MD5 hash of demo_msg2.bin:"
        md5 demo_msg2.bin
    else
        echo "MD5 command not found. Please install md5sum or md5 to verify."
    fi
    
    echo ""
    echo "Step 4: Comparing file sizes..."
    echo "Size of demo_msg1.bin: $(stat -f%z demo_msg1.bin 2>/dev/null || stat -c%s demo_msg1.bin 2>/dev/null) bytes"
    echo "Size of demo_msg2.bin: $(stat -f%z demo_msg2.bin 2>/dev/null || stat -c%s demo_msg2.bin 2>/dev/null) bytes"
    
    echo ""
    echo "=========================================="
    echo "Demo completed successfully!"
    echo "=========================================="
    echo ""
    echo "The two files (demo_msg1.bin and demo_msg2.bin) have the same MD5 hash"
    echo "but contain different data, demonstrating MD5 collision vulnerability."
else
    echo "Error: Failed to generate collision"
    exit 1
fi

