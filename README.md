# ⚙️ AWS CLI Setup for Cloud Infrastructure Projects

This guide walks you through setting up the AWS CLI securely and correctly for infrastructure provisioning with Terraform, CI/CD pipelines, and DevOps automation.

---

## 🔐 Step 1: Create an IAM User (Avoid Root User)

1. Go to the AWS Console: [https://console.aws.amazon.com/iam](https://console.aws.amazon.com/iam)
2. Navigate to **IAM > Users > Add user**
3. Set a username like `terraform-admin`
4. Choose **Programmatic access**
5. Attach policy:  
   - ✅ For learning: `AdministratorAccess`  
   - 🔒 For real use: Custom policy with least privilege
6. Save the **Access Key ID** and **Secret Access Key**

---

## 💻 Step 2: Install AWS CLI

### On Linux/macOS:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install
```

### On Windows:
- Download from: [https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

---

## 🛠️ Step 3: Configure the AWS CLI

Run:
```bash
aws configure
```

Provide your values:

| Prompt                | Example                      |
| --------------------- | ---------------------------- |
| AWS Access Key ID     | `AKIAIOSFODNN7EXAMPLE`       |
| AWS Secret Access Key | `wJalrXUtnFEMI/...`          |
| Default region name   | `us-east-1` (or your choice) |
| Default output format | `json`                       |

This stores your credentials at:
- `~/.aws/credentials`
- `~/.aws/config`

---

## ✅ Step 4: Test Your Setup

```bash
aws sts get-caller-identity
```

Sample Output:
```json
{
  "UserId": "AIDAEXAMPLE",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/terraform-admin"
}
```

If this works, you're ready to provision infrastructure using Terraform or deploy apps with CI/CD tools like GitHub Actions.

---

## 🔐 **Environment Variables for AWS Credentials**

These 3 are the minimum needed:

| Variable Name           | Purpose                    |
| ----------------------- | -------------------------- |
| `AWS_ACCESS_KEY_ID`     | Your AWS access key ID     |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret key        |
| `AWS_DEFAULT_REGION`    | Region (e.g., `us-east-1`) |


## 🛠️ **How to Set These Per OS**

### ✅ **Linux/macOS (bash/zsh)**

#### Temporary (for current shell):

```bash
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1
```

✅ Then run:

```bash
aws s3 ls
```

#### Permanent:

Add to `~/.bashrc`, `~/.zshrc`, or `~/.profile`:

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=us-east-1
```

Then:

```bash
source ~/.bashrc
```

---

### 🫯 **Windows (PowerShell)**

#### Temporary:

```powershell
$env:AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"
$env:AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
$env:AWS_DEFAULT_REGION = "us-east-1"
```

Test:

```powershell
aws ec2 describe-instances
```

#### Permanent:

Set it via **Environment Variables GUI**:

- Search "Environment Variables" in Start
    
- Under "User variables", add:
    
    - `AWS_ACCESS_KEY_ID`
        
    - `AWS_SECRET_ACCESS_KEY`
        
    - `AWS_DEFAULT_REGION`

✅ Then restart your terminal.

---

## 🔧 **Using a Script or `.env` File**

You can load creds from a file (e.g. `.env`) with:

```bash
# .env
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=us-east-1
```

Then load:

```bash
source .env
```

---

## 🧲 Testing If It Works

Try this:

```bash
aws sts get-caller-identity
```

If you get an IAM User or Role back, it’s working 💪

---

## 🔐 Extra Tip: Use `AWS_PROFILE` for Named Profiles

You can define multiple profiles in `~/.aws/credentials`:

```ini
[default]
aws_access_key_id = ABC123
aws_secret_access_key = DEF456

[dev-account]
aws_access_key_id = GHI789
aws_secret_access_key = JKL012
```

Then call:

```bash
aws s3 ls --profile dev-account
```

Or:

```bash
export AWS_PROFILE=dev-account
```

---

## 🔗 Resources

- [AWS CLI Docs](https://docs.aws.amazon.com/cli/latest/userguide/)
- [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)

---
