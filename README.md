# 🎬 Movie Metadata Organiser

![Ruby](https://img.shields.io/badge/Ruby-3.x-red?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-7.x-cc0000?logo=rubyonrails)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-DB-336791?logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker)
![License](https://img.shields.io/badge/License-MIT-green)

A Ruby on Rails 7 application designed to help you manage, organize, and explore movie metadata efficiently.  
Built with scalability and modularity in mind, this project can be extended for personal collections, streaming platforms, or educational use cases.

---

## 🚀 Features

- **Rails 7 Framework** – Modern, scalable web app foundation.  
- **Movie Metadata Management** – Add, update, and delete movies with structured attributes.  
- **Database Integration** – Uses ActiveRecord ORM for seamless database operations.  
- **Docker Support** – Containerized setup for easy deployment.  
- **RuboCop Integration** – Enforced Ruby style guide for clean, maintainable code.  
- **Procfile.dev** – Ready for development environments with `foreman` or `overmind`.  

---

## 🛠 Tech Stack

- **Backend:** Ruby on Rails 7, ActiveRecord  
- **Database:** PostgreSQL (default)  
- **Frontend:** Rails default views (can be extended with React/Vue)  
- **DevOps:** Docker, Docker Compose  
- **Code Quality:** RuboCop  

---

## 📂 Project Structure
``` text
├── app/ # Core Rails app (models, views, controllers)
├── bin/ # Rails executables
├── config/ # Environment & database configs
├── db/ # Migrations and seeds
├── lib/ # Custom libraries and modules
├── public/ # Public assets
├── test/ # Test suite
├── Dockerfile # Container setup
├── Gemfile # Ruby dependencies
├── Procfile.dev # Foreman/Overmind process definitions
└── README.md # Project documentation
```

---

## ⚡ Getting Started

### Prerequisites
- Ruby `3.x`  
- Rails `7.x`  
- PostgreSQL  
- Docker (optional, for containerized setup)  

### Setup

```bash
# Clone repository
git clone https://github.com/sumit-jr/Movie-Metadata-Organiser.git
cd Movie-Metadata-Organiser

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate

# Run server
rails server
```

Visit [http://localhost:3000](http://localhost:3000) to access the app.

---

## 🐳 Run with Docker

```bash
# Build image
docker build -t movie-metadata-organiser .

# Run container
docker run -p 3000:3000 movie-metadata-organiser
```

## ✅ Testing

Rails comes with a built-in test framework. To run tests:

```bash
rails test
```
---

## 📜 License

This project is licensed under the **MIT License**.


