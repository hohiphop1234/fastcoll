#!/usr/bin/env python3
"""
Script để so sánh hai file collision và hiển thị sự khác biệt
Sử dụng trong demo để chứng minh hai file khác nhau nhưng có cùng MD5 hash
"""

import sys
import hashlib
import os

def get_md5(filepath):
    """Tính MD5 hash của file"""
    hash_md5 = hashlib.md5()
    with open(filepath, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def compare_files(file1, file2):
    """So sánh hai file và hiển thị thông tin"""
    if not os.path.exists(file1):
        print(f"Error: File '{file1}' not found!")
        return False
    if not os.path.exists(file2):
        print(f"Error: File '{file2}' not found!")
        return False
    
    # Tính MD5
    md5_1 = get_md5(file1)
    md5_2 = get_md5(file2)
    
    # Đọc nội dung
    with open(file1, "rb") as f:
        content1 = f.read()
    with open(file2, "rb") as f:
        content2 = f.read()
    
    print("=" * 60)
    print("MD5 COLLISION COMPARISON")
    print("=" * 60)
    print()
    
    print(f"File 1: {file1}")
    print(f"  Size: {len(content1)} bytes")
    print(f"  MD5:  {md5_1}")
    print()
    
    print(f"File 2: {file2}")
    print(f"  Size: {len(content2)} bytes")
    print(f"  MD5:  {md5_2}")
    print()
    
    # So sánh MD5
    if md5_1 == md5_2:
        print("✓ SUCCESS: Both files have the SAME MD5 hash!")
        print("  This proves MD5 collision vulnerability.")
    else:
        print("✗ WARNING: Files have DIFFERENT MD5 hashes.")
        print("  Collision generation may have failed.")
    print()
    
    # So sánh nội dung
    if content1 == content2:
        print("✗ Files are IDENTICAL (this should not happen in a collision)")
    else:
        print("✓ Files are DIFFERENT (as expected in a collision)")
        
        # Tìm vị trí khác biệt
        differences = []
        min_len = min(len(content1), len(content2))
        for i in range(min_len):
            if content1[i] != content2[i]:
                differences.append(i)
        
        print(f"  Number of different bytes: {len(differences)}")
        if len(differences) > 0 and len(differences) <= 20:
            print("  Different byte positions:")
            for pos in differences[:20]:
                print(f"    Byte {pos}: 0x{content1[pos]:02x} vs 0x{content2[pos]:02x}")
        elif len(differences) > 20:
            print(f"  First 20 different byte positions:")
            for pos in differences[:20]:
                print(f"    Byte {pos}: 0x{content1[pos]:02x} vs 0x{content2[pos]:02x}")
    
    print()
    print("=" * 60)
    
    return md5_1 == md5_2

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python compare_files.py <file1> <file2>")
        print("Example: python compare_files.py demo_msg1.bin demo_msg2.bin")
        sys.exit(1)
    
    file1 = sys.argv[1]
    file2 = sys.argv[2]
    
    success = compare_files(file1, file2)
    sys.exit(0 if success else 1)

