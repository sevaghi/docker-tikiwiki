# Tiki Wiki CMS Docker Setup

This project provides a complete and production-ready Docker environment for running **Tiki Wiki CMS Groupware 27.x LTS**, using Apache, PHP 8.4, and MariaDB 10.6.

---

## Features

- Based on the official PHP 8.4 Apache image
- Includes required PHP extensions for Tiki Wiki
- Installs Tiki Wiki 27.2 LTS automatically
- Uses MariaDB 10.6 as backend database
- Configurable via `.env` file
- Optimized for local development and testing

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/your_username/tikiwiki-docker.git
cd tikiwiki-docker
```

### 2. Create your `.env` file

```env
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=tiki
MYSQL_USER=tikiuser
MYSQL_PASSWORD=your_secure_password
```

> Do **not** commit this file. It is ignored via `.gitignore`.

---

### 3. Build and start the containers

```bash
docker-compose up -d --build
```

### 4. Access the web installer

Go to [http://localhost:8080](http://localhost:8080) and complete the Tiki Wiki installation wizard.

- **Database host:** `db`
- **Database name/user/password:** use the values from your `.env`

---

## Project Structure

```
.
├── apache/
│   └── tiki.conf         # Apache virtual host config
├── config/
│   └── php.ini           # Custom PHP configuration
├── docker-compose.yml    # Service definitions
├── Dockerfile            # Web server + PHP + Tiki installation
├── .env                  # Database credentials (not committed)
└── .gitignore            # Ignoring sensitive and local files
```

---

## Environment Variables

These are required in your `.env` file:

| Variable             | Description                        |
|----------------------|------------------------------------|
| `MYSQL_ROOT_PASSWORD`| Root password for MariaDB          |
| `MYSQL_DATABASE`     | Name of the database for Tiki Wiki |
| `MYSQL_USER`         | Tiki Wiki DB username              |
| `MYSQL_PASSWORD`     | Tiki Wiki DB password              |

---

## Notes

- Database and Tiki files are stored in Docker volumes: `db_data`, `tiki_data`
- MariaDB auto-creates the DB and user using the environment variables
- PHP is configured for Tiki's typical needs (memory, upload size, execution time)
- Logs are handled by the containers and viewable via `docker-compose logs`

---

## Security Tips

- Consider using Docker Secrets or an external secret manager (e.g., Vault, AWS Secrets Manager) to store sensitive credentials securely
- Use strong, unique passwords in your `.env`
- Keep your `.env` file and any SQL dumps out of version control
- Use HTTPS (with Nginx, Traefik, or Caddy) if deploying in production
- Do not expose the database container directly to the interneti

---

## Optional: Importing a SQL Dump

If you have an existing Tiki database dump, place the file as `dump.sql` and add this line to the `db` service in `docker-compose.yml`:

```yaml
volumes:
  - ./dump.sql:/docker-entrypoint-initdb.d/dump.sql:ro
```

**Note:** This only works the *first time* the container starts (with an empty DB volume).

---

## Resources

- [Official Tiki Wiki Documentation](https://doc.tiki.org)
- [Tiki Wiki Downloads](https://sourceforge.net/projects/tikiwiki/)
- [Docker PHP Images](https://hub.docker.com/_/php)
- [MariaDB Docker](https://hub.docker.com/_/mariadb)

---
