# Đặt tên cho script: 

# Xác định đường dẫn đến app.asar trong thư mục StarUML\resources
# $destinationPath = "C:\Program Files\StarUML\resources\app.asar" # Thay đổi đường dẫn nếu cần

# Lấy danh sách tất cả ổ đĩa
$drives = Get-PSDrive -PSProvider 'FileSystem'

# Vòng lặp qua từng ổ đĩa để tìm thư mục StarUML
foreach ($drive in $drives) {
    $starUMLPath = Get-ChildItem -Path $drive.Root -Filter "StarUML" -Recurse -ErrorAction SilentlyContinue -Directory | Where-Object { $_.FullName -like "*\StarUML\resources" }
    if ($starUMLPath) {
        # Nếu tìm thấy, xây dựng đường dẫn đến app.asar
        $destinationPath = Join-Path $starUMLPath.FullName "app.asar"
        break
    }
}

# Kiểm tra nếu đã tìm thấy đường dẫn
if ($destinationPath) {
    # Tiếp tục với các bước tiếp theo
} else {
    Write-Host "Không tìm thấy thư mục StarUML."
}

# URL để tải file app.asar
$url = "https://github.com/harrytien107/StarUML-V6-via-scripts/raw/main/app.asar"

# Tạo thư mục tạm để lưu file tải về nếu chưa tồn tại
$tempFolder = "$env:TEMP\StarUMLUpdate"
if (-not (Test-Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder
}

# Đường dẫn tạm để lưu file app.asar tải về
$tempFile = Join-Path $tempFolder "app.asar"

# Tải file app.asar từ GitHub
Invoke-WebRequest -Uri $url -OutFile $tempFile

# Ghi đè file app.asar tại đích
Copy-Item -Path $tempFile -Destination $destinationPath -Force

# Xóa thư mục tạm sau khi cập nhật
Remove-Item -Path $tempFolder -Recurse -Force

# Thông báo hoàn tất
Write-Host "scripts run successfully."