# Bonnyfuzz

Bonnyfuzz is a simple, user-friendly directory brute-forcing tool written in Bash. Designed for security professionals and ethical hackers, Bonnyfuzz includes features like Intelligent Request Timing, customizable threading, and dynamic delays to help evade WAFs and rate-limiting mechanisms during penetration testing.

---

## 🎯 Features

- **User-Friendly Interface**: Easy-to-use options for all levels of expertise.
- **Intelligent Request Timing**: Dynamically adjusts delays based on server response times to avoid detection and rate-limiting.
- **Recursive Directory Fuzzing**: Automatically fuzz subdirectories for deeper exploration.
- **Threading Support**: Multithreaded fuzzing for faster scans using `parallel`.
- **Dynamic Response Classification**: Highlights successful results with HTTP status codes (200, 301, 302).
- **Customizable Options**: Users can specify delays, maximum response times, and thread counts.

---

## 🛠️ Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/BonnyleSage/bonnyfuzz.git
   cd bonnyfuzz
