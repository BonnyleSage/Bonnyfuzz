# Bonnyfuzz

Bonnyfuzz is a simple, user-friendly directory brute-forcing tool written in Bash. Designed for security professionals and ethical hackers, Bonnyfuzz includes features like Intelligent Request Timing, customizable threading, and dynamic delays to help evade WAFs and rate-limiting mechanisms during penetration testing.

---

## 🎯 FEATURES

- **User-Friendly Interface**: Easy-to-use options for all levels of expertise.
- **Intelligent Request Timing**: Dynamically adjusts delays based on server response times to avoid detection and rate-limiting.
- **Recursive Directory Fuzzing**: Automatically fuzz subdirectories for deeper exploration.
- **Threading Support**: Multithreaded fuzzing for faster scans using `parallel`.
- **Dynamic Response Classification**: Highlights successful results with HTTP status codes (200, 301, 302).
- **Customizable Options**: Users can specify delays, maximum response times, and thread counts.

---

## 🛠️ INSTALLATION
1. Clone the repository:
   ```bash
   git clone https://github.com/BonnyleSage/bonnyfuzz.git
   cd bonnyfuzz
   
2. Make the script executable(change permissions):
    chmod +x bonnyfuzz.sh

3. (Optional) Install parallel for multithreading support:
   sudo apt install parallel

## 🚀 USAGE
  ./bonnyfuzz.sh -u <url> -w <wordlist> [-t <threads>] [-d <delay>] [-m <max-response>]

## Options


| Option        | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `-u <url>`    | Target URL (e.g., https://example.com).                                      |
| `-w <wordlist>`| Path to wordlist file (e.g., wordlist.txt).                                 |
| `-t <threads>`| Number of threads (default: 1).                                              |
| `-d <delay>`  | Minimum delay between requests in seconds (default: 0.5).                   |
| `-m <max-response>` | Max allowed response time in seconds before increasing delay (default: 2.0). |
| `-h`          | Show help menu.                                                             |

## 📚 EXAMPLES

  ## Basic Usage
    Run a fuzzing operation against https://example.com using wordlist.txt:
       ./bonnyfuzz.sh -u https://example.com -w wordlist.txt
  ## Multithreaded Fuzzing
     Run with 10 threads:
       ./bonnyfuzz.sh -u https://example.com -w wordlist.txt -t 10
  ## Intelligent Request Timing 💥💥
     Use a minimum delay of 1 second and increase delay dynamically if response times exceed 3 seconds:
        ./bonnyfuzz.sh -u https://example.com -w wordlist.txt -d 1 -m 3

## 🌟 FEATURES IN ACTION 

  # Intelligent Request Timing
    Bonnyfuzz automatically adapts to server response times:
      If a response takes longer than the configured threshold (-m), the delay increases dynamically to prevent rate limiting.
    Example output: 
         [200] https://example.com/admin (Response Time: 1.2s)
         [301] https://example.com/login (Response Time: 2.5s)
          Server is slowing down; increasing delay to 1.5s
         [200] https://example.com/dashboard (Response Time: 3.1s)
   # Dynamic Subdirectory Discovery
       Bonnyfuzz discovers and fuzzes subdirectories automatically:
         Example:
               [200] https://example.com/admin
                Recursively fuzzing: /admin
               [200] https://example.com/admin/login
   
   ## 📄 REQUIREMENTS
     💨 Bash: Tested on Bash 5.0+.
     💨 curl: For making HTTP requests.
     💨 parallel (optional): For multithreaded support.
     💨 A wordlist file with directory names.
   
   ## 🚧 LIMITATIONS
     🕳 Bonnyfuzz is not as feature-rich as dedicated tools like Dirsearch or Gobuster but offers a lightweight alternative.
     🕳 Multithreading requires parallel.
   
   ## 🔒 DISCLAIMER
     Bonnyfuzz is intended for authorized penetration testing and educational purposes only. Ensure you have explicit permission before using this tool against any target. The developers are not responsible for misuse or damage caused by the tool.

   ## 👩‍💻 CONTRIBUTING 
    Contributions are welcome! Feel free to submit a pull request or open an issue to suggest new features.
   ##  📫 CONTACT 
      💫GitHub: [Your GitHub Profile](https://github.com/BonnyleSage)
      💫Email:thecybercoach971@gmail.com

   ## 📝 LICENCE
   This project is licensed under the MIT License. See the LICENSE file for details.

  



