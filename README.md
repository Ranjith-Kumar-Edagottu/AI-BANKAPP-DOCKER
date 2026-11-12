# AI-Powered BankApp (Containerized Deployment)

A full-stack banking web application integrated with an offline, self-hosted AI assistant powered by Ollama and a persistent MySQL database. The entire architecture is containerized and orchestrated using Docker and Docker Compose.

---

## 🏗️ System Architecture

The application runs as a multi-container stack connected over an isolated Docker bridge network (bankapp-net):

* *BankApp Backend (bankapp):* Spring Boot (Java 21) handling core banking workflows, user authentication, account management, transactions, and AI chat integration.
* *Relational Database (bankapp-mysql):* MySQL 8.0 configured with persistent named volumes (mysql-data) and automated mysqladmin ping health checks.
* *AI Inference Engine (bankapp-ollama):* Self-hosted Ollama service running a local Large Language Model (tinyllama) via internal container networking with persistent model storage (ollama-data).
* *Automated Model Init (ollama-pull-model):* Initialization container that automatically pulls the required LLM weights on startup so the AI assistant is ready immediately.

---

## 🛠️ Tech Stack

* *Backend:* Java 21, Spring Boot
* *Database:* MySQL 8.0
* *AI Engine:* Ollama (tinyllama)
* *Containerization & Orchestration:* Docker, Docker Compose
* *Build Tool:* Maven (Multi-stage Docker build)

---

## 📋 Prerequisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/macOS) or Docker Engine & Docker Compose v2 (Linux)
* Git

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone [https://github.com/](https://github.com/)<your-username>/<your-repo-name>.git
cd <your-repo-name>

2. Build and Launch the Stack
   - Build the multi-stage Spring Boot image and start all services in detached mode:

docker compose up -d --build

***Startup Order: The bankapp service uses a service_healthy dependency condition on mysql, ensuring the database is fully       initialized before the Spring Boot server connects.***

3. Verify Running Containers
   Check the status of all containers:

docker compose ps

***Expected status:***

  - bankapp: Up

   - bankapp-mysql: Up (healthy)

   - bankapp-ollama: Up (healthy)

    - ollama-pull-model: Exited (0) (Completes once the LLM model is downloaded)

🌐 Accessing the Application
   Once the backend finishes starting, open your browser and navigate to:

http://localhost:8080

To monitor live application logs:

dockor compose logs -f bankapp

🛑 Managing Containers
   - Stop services without removing data:

docker compose stop

- Restart stopped services

docker compose start

- Stop and remove containers and networks

docker compose down

- Full reset (remove containers, networks, and database/model volumes):

docker compose down -v
