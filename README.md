# 🛠 Ethical ARP Sniffer in Assembly (NASM)

This project contains a basic ARP packet sniffer written in x86 Assembly (NASM syntax), designed for educational and ethical hacking purposes. It detects ARP traffic on the local network and prints the source and destination MAC addresses.

> ⚠️ **Use this tool only on networks you own or have explicit permission to test. Unauthorized use is illegal.**

---

## 📁 Files in the repository

* `sniffer.asm` – Basic ARP packet sniffer
* `sniffer_mac.asm` – Extended version with MAC address printing

---

## ⚙️ How to use this on **Windows**

You have two main options:

### ✅ Option 1 – Use WSL (Recommended)

WSL (Windows Subsystem for Linux) allows you to run Linux tools on Windows easily.

### 🔹 Step-by-step:

1. **Install WSL**:
   Open PowerShell as Administrator and run:

   ```bash
   wsl --install
   ```

   Reboot your system when prompted.

2. **Launch Ubuntu (or your chosen distro)** from the Start Menu.

3. **Install NASM**:

   ```bash
   sudo apt update
   sudo apt install nasm
   ```

4. **Access your code**:
   Navigate to your Windows folder (e.g., if your code is in `C:\Users\YourName\assembly`):

   ```bash
   cd /mnt/c/Users/YourName/assembly
   ```

5. **Compile and run the sniffer**:

   ```bash
   nasm -f elf32 sniffer_mac.asm -o sniffer.o
   ld -m elf_i386 sniffer.o -o sniffer
   sudo ./sniffer
   ```

### ✅ Option 2 – Use DOSBox (for 16-bit .COM programs)

1. **Download NASM**: [https://www.nasm.us/pub/nasm/releasebuilds/](https://www.nasm.us/pub/nasm/releasebuilds/)
2. **Download DOSBox**: [https://www.dosbox.com/download.php?main=1](https://www.dosbox.com/download.php?main=1)
3. Save your `.asm` file in a folder (e.g. `C:\ASM`)
4. Open DOSBox and run:

   ```dos
   mount c c:\ASM
   c:
   nasm hello.asm -f bin -o hello.com
   hello
   ```

> Note: This is limited to real-mode 16-bit programs. Not suitable for ARP/network sniffers.

---

## 🧪 Sample Output

```
ARP intercettato
MAC destinazione: 00:1A:2B:3C:4D:5E
MAC sorgente:     52:10:9F:EE:10:88
```

---

## 🧠 Learn More / Extend

You can enhance this project to:

* Extract ARP sender and target IP addresses
* Log packets to a file
* Add timestamping to packets
* Build a basic ARP poisoning detector

---

## 👨‍💻 License

MIT License – Use freely for ethical and educational purposes.

---

## 💬 Need help?

Open an issue or contact the author if you need help setting up NASM or WSL on your system.
