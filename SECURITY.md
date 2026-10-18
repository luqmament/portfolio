# Security Setup

Repository ini dilindungi oleh beberapa layer keamanan untuk mencegah accidental exposure secrets.

## 🛡️ Layer Proteksi

### 1. `.gitignore` — Primary Defense
File `.gitignore` sudah dikonfigurasi untuk mengabaikan file sensitif secara otomatis:

```
.env, *.pem, *.key, credentials/, secrets/, api_key, ...
```

File yangmatch pattern di `.gitignore` **tidak akan pernah** di-track oleh git.

---

### 2. Pre-commit Hook — Local Protection
Hook yang jalan **di mesin kamu** sebelum setiap commit. Install dengan:

```bash
sh setup-hooks.sh
```

Hook ini akan **block commit** kalau mendeteksi:
- Sensitive filenames (.env, .pem, .key, dll.)
- GitHub tokens (format: `ghp_xxxxxxxx...`)
- AWS access keys (format: `AKIA...`)
- Hardcoded API keys / secrets

---

### 3. GitHub Actions — Cloud Protection
Workflow `.github/workflows/security.yml` jalan setiap push/pull request:

- Scan file untuk sensitive filenames
- Scan konten untuk hardcoded secrets
- Verifikasi `.gitignore` ada
- Cek health repository

⚠️ **GitHub Secret Scanning** juga aktif otomatis untuk repo public — GitHub akan auto-block push yang mengandung secrets.

---

## 📋 Files yang Dilarang di-commit

| Kategori | Contoh |
|---|---|
| Environment files | `.env`, `.env.local` |
| Keys & Certificates | `*.pem`, `*.key`, `*.crt` |
| Credentials | `credentials.json`, `secrets/` |
| Tokens | `api_key`, `*_TOKEN` |
| Password files | `passwords.txt`, `passwd` |
| SSH keys | `id_rsa`, `*.ppk` |
| Cloud keys | `*.gcpkey`, `*.azurekey` |

---

## ⚠️ Jika Secrets Ter-push

1. **Immediately rotate the secret** (API key, token, password)
2. **Remove from git history**: `git filter-repo` atau BFG Repo-Cleaner
3. **For GitHub tokens**: revoke di https://github.com/settings/tokens
4. **Audit logs**: cek siapa yang mungkin sudah mengambilnya

---

## ✅ Checklist Sebelum Push

- [ ] Tidak ada `.env` file di staging
- [ ] Tidak ada API key / token di kode
- [ ] Tidak ada credentials di comment
- [ ] `.gitignore` sudah up-to-date
- [ ] Pre-commit hook sudah ter-install (`sh setup-hooks.sh`)
