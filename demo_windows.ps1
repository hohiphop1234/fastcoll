# MD5 Collision Demo Script for Windows PowerShell
# FastColl Demonstration

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  MD5 Collision Demo - FastColl" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra Docker
Write-Host "Checking Docker installation..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version
    Write-Host "Docker found: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Docker is not installed or not running!" -ForegroundColor Red
    Write-Host "Please install Docker Desktop from https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit 1
}

# Tạo file input demo nếu chưa có
if (-not (Test-Path "demo_input.txt")) {
    Write-Host "Creating demo_input.txt..." -ForegroundColor Yellow
    "Hello, this is a demo file for MD5 collision demonstration.`nThis file will be used as a prefix to generate two different files`nwith the same MD5 hash value, proving that MD5 is vulnerable to collision attacks." | Out-File -FilePath "demo_input.txt" -Encoding ASCII
}

Write-Host ""
Write-Host "Step 1: Building Docker image..." -ForegroundColor Yellow
Write-Host "This may take a few minutes on first run..." -ForegroundColor Gray
docker build -t fastcoll:demo .

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to build Docker image" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Step 2: Generating MD5 collision..." -ForegroundColor Yellow
Write-Host "This will create two different files with the same MD5 hash..." -ForegroundColor Gray
Write-Host ""

# Tạo collision với prefix file
$currentDir = (Get-Location).Path
docker run --rm -v "${currentDir}:/work" -w /work fastcoll:demo --prefixfile demo_input.txt -o demo_msg1.bin demo_msg2.bin

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Step 3: Verifying MD5 hashes..." -ForegroundColor Yellow
    Write-Host ""
    
    if ((Test-Path "demo_msg1.bin") -and (Test-Path "demo_msg2.bin")) {
        Write-Host "MD5 hash of demo_msg1.bin:" -ForegroundColor Cyan
        $hash1 = Get-FileHash demo_msg1.bin -Algorithm MD5
        Write-Host $hash1.Hash -ForegroundColor White
        
        Write-Host "MD5 hash of demo_msg2.bin:" -ForegroundColor Cyan
        $hash2 = Get-FileHash demo_msg2.bin -Algorithm MD5
        Write-Host $hash2.Hash -ForegroundColor White
        
        Write-Host ""
        if ($hash1.Hash -eq $hash2.Hash) {
            Write-Host "SUCCESS! Both files have the same MD5 hash!" -ForegroundColor Green
            Write-Host "Hash: $($hash1.Hash)" -ForegroundColor Green
        } else {
            Write-Host "WARNING: Hashes are different. Something went wrong." -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "Step 4: Comparing file sizes..." -ForegroundColor Yellow
        $size1 = (Get-Item demo_msg1.bin).Length
        $size2 = (Get-Item demo_msg2.bin).Length
        Write-Host "Size of demo_msg1.bin: $size1 bytes" -ForegroundColor White
        Write-Host "Size of demo_msg2.bin: $size2 bytes" -ForegroundColor White
        
        Write-Host ""
        Write-Host "==========================================" -ForegroundColor Cyan
        Write-Host "Demo completed successfully!" -ForegroundColor Green
        Write-Host "==========================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "The two files (demo_msg1.bin and demo_msg2.bin) have the same MD5 hash" -ForegroundColor White
        Write-Host "but contain different data, demonstrating MD5 collision vulnerability." -ForegroundColor White
        Write-Host ""
        Write-Host "You can now use these files in your presentation!" -ForegroundColor Green
    } else {
        Write-Host "Error: Output files were not created" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Error: Failed to generate collision" -ForegroundColor Red
    exit 1
}

