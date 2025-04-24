# [AWS CLI & IAM Setup](https://github.com/OOyaluade/cloud-infra-bootstrapping/tree/main/docs)
> ✉️ See `docs/aws-cli-setup.md` for full config steps.

### 📂 Account Design (Planned Structure)


See the cloudinfra terraform file to on the IAC code for subnetting this address
![[Pasted image 20250424105332.png]]

| Subnet | AZ            | Network ID   | First IP     | Last IP        | Broadcast      |
| ------ | ------------- | ------------ | ------------ | -------------- | -------------- |
| 1      | Communication | 172.16.0.0   | 172.16.0.1   | 172.16.31.254  | 172.16.31.255  |
| 2      | Dev           | 172.16.32.0  | 172.16.32.1  | 172.16.63.254  | 172.16.63.255  |
| 3      | Prod          | 172.16.64.0  | 172.16.64.1  | 172.16.95.254  | 172.16.95.255  |
| 4      |               | 172.16.96.0  | 172.16.96.1  | 172.16.127.254 | 172.16.127.255 |
| 5      |               | 172.16.128.0 | 172.16.128.1 | 172.16.159.254 | 172.16.159.255 |
| 6      |               | 172.16.160.0 | 172.16.160.1 | 172.16.191.254 | 172.16.191.255 |
| 7      |               | 172.16.192.0 | 172.16.192.1 | 172.16.223.254 | 172.16.223.255 |
| 8      |               | 172.16.224.0 | 172.16.224.1 | 172.16.255.254 | 172.16.255.255 |

| Account    | Purpose                           |
| ---------- | --------------------------------- |
| Management | Root account, billing, SCPs       |
| Dev        | All non-prod resources & testing  |
| Prod       | Critical workloads (future setup) |
