# 🤝 Contributing to CareMesh Health Infra Project

First of all, thank you for taking the time to contribute!

This project is building a production-ready, HIPAA-compliant cloud platform for healthcare SaaS and ML workloads. Maintaining high-quality infrastructure and clear processes is key to its success.

## 📋 How to Contribute

- Fork the repository
- Create a new branch (`git checkout -b feature/your-feature-name`)
- Make your changes following the existing folder structure and standards
- Follow clean commit message conventions (using `feat:`, `fix:`, `chore:`, `docs:`, etc.)
- Push your branch (`git push origin feature/your-feature-name`)
- Open a Pull Request (PR) against the `main` branch

## 📦 Commit Message Standards

We use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) style enforced by Commitlint and Husky.

Examples:
- `feat: add new EKS module`
- `fix: correct S3 bucket policy`
- `chore: update gitignore for node_modules`
- `docs: update README with setup instructions`

## ✅ Pull Request Guidelines

- Describe **what you changed** and **why** in your PR description
- Link any related issues if applicable
- Make sure Terraform validates and formats cleanly (`terraform validate`, `terraform fmt`)
- Keep PRs focused on one logical change whenever possible
- Be respectful and collaborative in reviews

---

Thank you for helping build CareMesh Health! 🚀
