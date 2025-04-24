## 🧠 Quick Subnetting Refresher (For Cloud Engineers)

### 🔢 Binary Basics:

- **255.0.0.0** = `/8`
    
- `255` = 8 bits
    

---

### 🧭 IP Address Classes

|Class|Range|Default Subnet Mask|
|---|---|---|
|A|1–126|255.0.0.0 (/8)|
|B|128–191|255.255.0.0 (/16)|
|C|192–223|255.255.255.0 (/24)|
|—|Loopback|127.0.0.1|

---

### 🧮 Example – Class A Calculation

- **Mask:** `255.0.0.0` → `/8`
    
- **Binary:** `11111111.00000000.00000000.00000000`
    
- **Formula:** Number of IPs = `(2^number of 0s) - 2`
    
- In this case: `(2^24) - 2 = 16,777,214`
    

---

### 📌 Address Breakdown for Class A (e.g., 10.0.0.0)

- Network ID: `10.0.0.0`
    
- First usable IP: `10.0.0.1`
    
- Last usable IP: `10.255.255.254`
    
- Broadcast address: `10.255.255.255`
    

---

### 🔢 Subnet Mask Chart

| Bit No. | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- |
| Binary  | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |
| Decimal | 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |
| Mask    | 128 | 192 | 224 | 240 | 248 | 252 | 254 | 255 |

---

### ✍️ Subnetting Step-by-Step

#### Example 1:

- IP: `172.16.0.0`
    
- Default subnet: `255.255.0.0` → `/16`
    
- Let's subnet into: `255.255.240.0`
    
- Binary: `11111111.11111111.11110000.00000000`
    
- **Borrowed bits:** 4 (from the third octet)
    
- **New CIDR:** `/20`
    
- **Hosts per subnet:** `(2^12) - 2 = 4094`
    
- **Subnets:** `2^4 = 16`
    
- This is a **Class B** network, so we only count bits beyond the first 16.
    

#### Example 2:

- IP: `172.16.0.0`
    
- New subnet: `255.255.252.0`
    
- Binary: `11111111.11111111.11111100.00000000`
    
- Borrowed bits: 6
    
- Hosts per subnet: `(2^10) - 2 = 1022`
    
- Subnets: `2^6 = 64`
    

---

### 🔍 Class A Example (CIDR /20)

- IP: `10.0.0.0`
    
- Subnet: `255.255.248.0` → `/21`
    
- Default for Class A: `/8`
    
- Borrowed bits: 13
    
- IPs per subnet: `(2^11) - 2 = 2046`
    
- Subnets possible: `2^13 = 8192`
    

---

### 📚 Bringing It All Together (Full Subnet Breakdown)

- Given IP: 172.16.244.0 and subnet 255.255.224.0 get the bellow details 

- IP: `172.16.0.0`
    
- Subnet mask: `255.255.224.0` → `/19`
    
- Default class: **B** → `/16`
    
- Borrowed bits: 3
    
- IPs per subnet: `(2^13) - 2 = 8190`
    
- Subnets: `2^3 = 8`
    

Since the **third octet** starts at `224`, which has a decimal step of **32**, each new subnet starts 32 IPs apart in the third octet.

|Subnet|Network ID|First IP|Last IP|Broadcast|
|---|---|---|---|---|
|1|172.16.0.0|172.16.0.1|172.16.31.254|172.16.31.255|
|2|172.16.32.0|172.16.32.1|172.16.63.254|172.16.63.255|
|3|172.16.64.0|172.16.64.1|172.16.95.254|172.16.95.255|
|4|172.16.96.0|172.16.96.1|172.16.127.254|172.16.127.255|
|5|172.16.128.0|172.16.128.1|172.16.159.254|172.16.159.255|
|6|172.16.160.0|172.16.160.1|172.16.191.254|172.16.191.255|
|7|172.16.192.0|172.16.192.1|172.16.223.254|172.16.223.255|
|8|172.16.224.0|172.16.224.1|172.16.255.254|172.16.255.255|

---

Let me know if you want this saved as a `.md` file for your `docs/` directory.