<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

# 🚀 Laravel 12 Admin Platform

A modern Laravel 12 platform combining Docker infrastructure, Filament 3 admin panel, and comprehensive authentication system. Built for rapid development with enterprise-grade security and permissions management.

## ✨ Core Features

### Backend Infrastructure
- Laravel 12.x with PHP 8.4
- PostgreSQL 16 database
- Redis 7.2 for caching
- Node.js 22 + NPM for frontend
- Nginx web server
- Supervisor for queue processing

### Admin & Authentication
- Filament 3 Admin Panel
- Spatie Permissions integration
- AdminLTE 4 theme
- Role-based access control with Spati/permission
- Custom authentication flows

### Development Tools
- Laravel Telescope for debugging
- Laravel Horizon for queue monitoring
- Log Viewer integration
- API documentation with Scramble
- XDebug for development

## 🛠 Setup Instructions

### 1️⃣ Initial Setup
# Clone repository
git clone <repository-url>
cd <project-directory>

# Copy environment file
cp .env.example .env

# Start Docker containers
docker-compose up -d --build

### 2️⃣ Project Configuration
# Install dependencies
make composer install
make npm install

# Generate application key
make artisan key:generate

# Run migrations
make artisan migrate

# Create storage link
make artisan storage:link

## 🐳 Docker Environment

### Available Containers
- **app**: PHP 8.4 FPM (Alpine)
- **nginx**: Web Server
- **postgres**: Database
- **redis**: Caching
- **npm**: Frontend tooling
- **supervisor**: Queue processing

### Common Docker Commands
# Start environment
make up

# Stop all containers
make stop

# Rebuild containers
make build

# View container logs
make logs container-name

# Access container shell
make bash

## 🔑 Authentication & Permissions

### Filament Admin Setup
- Built-in admin panel at `/admin`
- Role-based access control
- Custom resource management
- Dashboard widgets and metrics

### Spatie Permissions
- Role & Permission management
- User-role assignments
- Protected routes and resources
- Policy-based authorization

## 📦 Available Make Commands

### Development
make up              # Start development environment
make build           # Build containers
make stop            # Stop all containers
make restart         # Restart containers

### Laravel Commands
make artisan         # Run artisan commands
make test           # Run PHPUnit tests
make clear          # Clear all caches

### Package Management
make composer        # Run composer commands
make npm            # Run npm commands

## 🌐 Access Points

### Local Development
- **Application**: http://localhost
- **Admin Panel**: http://localhost/admin
- **API Documentation**: http://localhost/api/documentation

### Development Tools
- **Telescope**: http://localhost/telescope
- **Horizon**: http://localhost/horizon
- **Log Viewer**: http://localhost/log-viewer

## 📚 Additional Resources

- [Laravel Documentation](https://laravel.com/docs/12.x)
- [Filament Documentation](https://filamentphp.com/docs)
- [Spatie Permissions](https://spatie.be/docs/laravel-permission)
- [AdminLTE Documentation](https://adminlte.io/docs/3.2/)

## 🤝 Contributing

Please refer to our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.