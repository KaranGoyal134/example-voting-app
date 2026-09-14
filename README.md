# Azure DevOps CI/CD Pipeline – Example Voting App

This project demonstrates a complete CI/CD workflow built on **Azure DevOps**, using the popular open-source [Example Voting App](https://github.com/KaranGoyal134/example-voting-app.git) as the sample application. The goal of this project is to showcase practical, hands-on experience with Azure DevOps: repository integration, self-hosted agents, Azure Container Registry (ACR), and multi-service build pipelines.

## Project Overview

The Example Voting App is a microservices-based application made up of three main services:

- **vote** – a front-end web app where users cast votes
- **worker** – a background service that processes votes
- **result** – a web app that displays voting results in real time

Each of these services is containerized using Docker, and this project builds a separate CI pipeline for each one.

## What This Project Demonstrates

1. **Source Control Integration**
   The application source code was forked/imported into an Azure DevOps organization and connected to Azure Repos so pipelines could be built directly against it.

2. **Self-Hosted Agent Setup**
   Instead of using Microsoft's hosted agents, a **self-hosted agent** was configured and registered following the official Azure DevOps documentation. The agent is named `azureagent`, is authenticated using a Personal Access Token (PAT), and is currently online and available for running pipeline jobs.

3. **Azure Container Registry (ACR)**
   An Azure Container Registry named `karanazuredevops` was created to store the Docker images built by the pipelines. It contains three repositories, one for each service:
   - `result`
   - `voteapp`
   - `worker`

4. **Custom Build & Push Pipelines**
   Azure Pipelines provides a built-in Docker task/template that combines "build" and "push" into a single step. In this project, that combined step was intentionally **split into two separate steps** — one for building the image and one for pushing it to ACR. This was done to have clearer, more granular control and visibility over each stage of the pipeline.

5. **Three Independent Pipelines**
   Three separate build pipelines were created, one per microservice (`vote`, `worker`, `result`). Each pipeline:
   - Runs on the self-hosted agent (`azureagent`)
   - Builds the Docker image for its respective service
   - Pushes the built image to the corresponding repository in Azure Container Registry

## Architecture Flow

```text
                    ┌──────────────────────────┐
                    │       Azure Repos        │
                    │        (Source Code)     │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │     Azure Pipelines      │
                    │                          │
                    │  ┌────────────────────┐  │
                    │  │   Vote Pipeline    │  │
                    │  └────────────────────┘  │
                    │  ┌────────────────────┐  │
                    │  │  Worker Pipeline   │  │
                    │  └────────────────────┘  │
                    │  ┌────────────────────┐  │
                    │  │  Result Pipeline   │  │
                    │  └────────────────────┘  │
                    └────────────┬─────────────┘
                                 │
                         Self-Hosted Agent
                          Pool: azureagent
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │       Docker Build       │
                    │                          │
                    │   Build Docker Images    │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │       Docker Push        │
                    │                          │
                    │   Push Images to ACR     │
                    └────────────┬─────────────┘
                                 │
                                 ▼
              ┌─────────────────────────────────────┐
              │     Azure Container Registry        │
              │       karanazuredevops              │
              │                                     │
              │  ┌─────────────┐                    │
              │  │    voteapp  │                    │
              │  └─────────────┘                    │
              │  ┌─────────────┐                    │
              │  │    worker   │                    │
              │  └─────────────┘                    │
              │  ┌─────────────┐                    │
              │  │    result   │                    │
              │  └─────────────┘                    │
              └─────────────────────────────────────┘
```

## Screenshots

Screenshots included in this README document each stage of the setup, such as:

- Azure Container Registry showing the three pushed repositories
  <img width="1902" height="657" alt="image" src="https://github.com/user-attachments/assets/d4bc1832-d16a-473d-a7b8-ce512889ddab" />

- The self-hosted agent (`azureagent`) configured and online
  <img width="1916" height="1027" alt="image" src="https://github.com/user-attachments/assets/31bc8891-0cc5-4a07-b5aa-3cb9a2f9a1c7" />

- The three pipelines and their run history
  <img width="1917" height="801" alt="image" src="https://github.com/user-attachments/assets/1b8a9928-6f79-4826-a15d-9547e38f1e50" />

## Tech Stack

- **Azure DevOps** – Repos, Pipelines, Agent Pools
- **Azure Container Registry (ACR)** – Docker image storage
- **Docker** – Containerization of services
- **Self-hosted Agent** – Custom build agent (`azureagent`) instead of Microsoft-hosted agents

## Purpose

This project was built as a learning and portfolio exercise to demonstrate practical Azure DevOps skills, including pipeline design, agent management, and container registry integration, using a real multi-service application as the example workload.
