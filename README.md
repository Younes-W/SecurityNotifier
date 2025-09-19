# 🔐 SecurityNotifier

SecurityNotifier is a PowerShell toolkit to run security-related checks and send notifications.  
It is designed in a modular way so you can easily add new APIs and functions.

---

## 📦 Available Modules

### 1. PwnedPasswords
Check if a password has been exposed in data breaches using the HaveIBeenPwned API.  
[➡️ See details below](#-pwnedpasswords-module)

### 2. (Planned) AbuseIPDB
Check if an IP address is malicious or blacklisted.

### 3. (Planned) Shodan
Query devices/services exposed on the internet.

### 4. (Planned) VirusTotal
Check files or URLs against multi-AV scan results.

---

## 🔧 Installation
```powershell
git clone https://github.com/<YourUsername>/SecurityNotifier.git
cd SecurityNotifier
Import-Module ./Modules/SecurityNotifier/SecurityNotifier.psd1
```

---

## 🚀 Usage Examples
### Example: Check a password
```powershell
Test-PwnedPassword -Password (Read-Host "Enter password" -AsSecureString)
```

---

## 🔐 PwnedPasswords Module

The **SecurityNotifier** PowerShell module helps you check whether a password has been exposed in known data breaches using the [HaveIBeenPwned PwnedPasswords API](https://haveibeenpwned.com/Passwords).

This is the **first finished module** of the SecurityNotifier project.

---

### ✨ Features
- Secure input with `SecureString`
- Uses the **k-Anonymity model**:  
  Only the first 5 characters of the SHA1 hash are sent to the API.  
  The suffix is compared locally, so the full password is never exposed.
- Clean output as a `PSCustomObject` (easy to pipe into other scripts)

---

### 🚀 Usage

#### Check password interactively
```powershell
Test-PwnedPassword -Password (Read-Host "Enter password" -AsSecureString)
```

#### Check password from plain text (for testing only!)
```powershell
Test-PwnedPassword -Password ("MyPassword123" | ConvertTo-SecureString -AsPlainText -Force)
```

---

### 📋 Output Example
```powershell
Found     : True
Count     : 5321
SHA1      : 12345ABCDE1234567890...
Prefix    : 12345
Suffix    : ABCDE1234567890...
CheckedAt : 2025-09-19T09:59:00.0000000Z
```

---

## 🛠 Roadmap
- [x] Implement `PwnedPasswords` check
- [ ] Add logging to file
- [ ] Add optional email/Discord notifications
- [ ] Extend with more security APIs (AbuseIPDB, Shodan, VirusTotal)

---

## 📜 License
MIT License © 2025 Younes Wimmer