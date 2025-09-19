# DevOps Engineer Portfolio Project

## Overview 🚀

This repository serves as a practical demonstration of my DevOps skills, created as a portfolio piece for DevOps Engineer. It showcases a complete, end-to-end workflow for a simple Go web application, from containerization to deployment, monitoring, and infrastructure management.

It's important to note that my current professional experience is focused on **on-premise** infrastructure. The cloud-native skills demonstrated in this project, especially concerning tools like Terraform for public cloud environments, are the result of my dedicated **self-study and personal project work**.

---
### Core Technologies Demonstrated

| Category | Technology | Purpose |
| :--- | :--- | :--- |
| **Containerization & Orchestration** | Docker, Kubernetes | Containerizing the application and managing its deployment, scaling, and networking. |
| **CI/CD** | GitLab CI | Automating the build, test, and container push pipeline. |
| **Infrastructure as Code (IaC)** | Terraform | Provisioning infrastructure in a declarative, version-controlled manner. |
| **Monitoring & Alerting** | Prometheus, Grafana | Collecting metrics, visualizing system health, and defining alert rules. |
| **Reverse Proxy & Ingress** | NGINX (via K8s Ingress) | Managing external access to the application within the Kubernetes cluster. |

---
### Project Structure

```
.
├── k8s/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── ingress.yaml
│   └── service.yaml
├── monitoring/
│   ├── alert-slack-integration.png
│   ├── grafana dashboard nodes.png
│   ├── sample-alert-rules.yaml
│   └── sample-alert-triggered.png
└── terraform/
    └── main.tf
├── .gitlab-ci.yml
├── Dockerfile
├── README.md
├── get_helm.sh
├── go.mod
└── main.go
```

---
### How to Run Locally 🛠️

**Prerequisites:**
* Docker Desktop (with Kubernetes enabled)
* `kubectl` command-line tool

**Steps:**

1.  **Clone the repository:**
    ```bash
    git clone this repo
    ```

2.  **Build the Docker image locally:**
    *(This command builds the image and makes it available to your local Kubernetes cluster provided by Docker Desktop.)*
    ```bash
    docker build -t my-go-app:latest .
    ```

3.  **Enable the Ingress Controller:**
    (If not already running in your local Kubernetes cluster)
    ```bash
    kubectl apply -f [https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml](https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml)
    ```

4.  **Deploy the Application:**
    Apply all the Kubernetes configuration files.
    ```bash
    kubectl apply -f k8s/
    ```

5.  **Access the Application:**
    Open your web browser and navigate to `http://localhost`. You should see the message: "Hello from Kubernetes ConfigMap! Welcome to DevOps Engineer showcase."

---
## Breakdown of Requirements

This project is designed to directly address the key skills requested in the job description.

### 1. Web Application using Docker and Kubernetes

* **Docker:** The application is containerized using a multi-stage `Dockerfile` to create a lightweight, optimized production image. You can find the configuration here: [`./Dockerfile`](./Dockerfile).
* **Kubernetes:** The application is deployed using several core Kubernetes objects:
    * [`k8s/deployment.yaml`](./k8s/deployment.yaml): Manages the application's pods, ensuring two replicas are running for availability.
    * [`k8s/service.yaml`](./k8s/service.yaml): Provides a stable internal network endpoint for the application pods.
    * [`k8s/configmap.yaml`](./k8s/configmap.yaml): Externalizes application configuration, demonstrating a key 12-factor app principle.

### 2. Infrastructure Provisioning Script (Terraform)

* **Terraform:** To demonstrate Infrastructure as Code (IaC) principles in a cloud-agnostic way, this project uses the Terraform `local` provider. The script in [`terraform/main.tf`](./terraform/main.tf) shows my understanding of Terraform syntax, providers, resources, and the `init`/`plan`/`apply` workflow, which is directly transferable to any cloud environment like AWS or Azure.

### 3. CI/CD Configuration (GitLab CI)

* **GitLab CI:** The CI/CD pipeline is defined in the [`.gitlab-ci.yml`](./.gitlab-ci.yml) file. This configuration demonstrates my ability to structure automated workflows using GitLab's syntax. The pipeline is broken down into logical stages:
    1.  **Build:** Compiles the application and builds the Docker image.
    2.  **Test:** Runs automated tests against the code (this is a placeholder step).
    3.  **Deploy:** Deploys the application to the staging environment (this is a placeholder step).

    This file shows how I would structure a pipeline. To execute it, it would need to be connected to a GitLab instance with a configured GitLab Runner.

### 4. Monitoring, Alerting, and Security Solution

This repository demonstrates alerting with Prometheus and Alertmanager, routed to Slack.

- **Flow:** Prometheus scrapes metrics → evaluates alert rules → fires alerts to Alertmanager → Alertmanager sends notifications to Slack via webhook.
- **What’s included in this repo:**
  - [`monitoring/sample-alert-rules.yaml`](./monitoring/sample-alert-rules.yaml): Example Prometheus alert rules (CPU, memory, node health, etc.).
  - [`monitoring/alert-slack-integration.png`](./monitoring/alert-slack-integration.png): Visual guide of Slack integration via webhook.
  - [`monitoring/sample-alert-triggered.png`](./monitoring/sample-alert-triggered.png): Example of a real alert notification in Slack.
  - [`monitoring/grafana dashboard nodes.png`](./monitoring/grafana%20dashboard%20nodes.png): Grafana dashboard showing cluster/node health used to validate conditions.

**Setup (high level):**
1. Install the kube-prometheus-stack (Prometheus, Alertmanager, Grafana) using Helm (or your preferred method).
2. Create a Slack Incoming Webhook and note the URL.
3. Create the Grafana Contact Point
3. Create a Specific Notification Policy 

Once configured, you should see alerts similar to the screenshot in [`sample-alert-triggered.png`](./monitoring/sample-alert-triggered.png) whenever conditions are met.

**Approach for Identifying Security Flaws:**
My approach integrates security into the CI/CD pipeline (DevSecOps):
1.  **Image Scanning:** I would add a job to the GitLab CI pipeline using a tool like **Sonarqube** to scan the Docker image for known vulnerabilities (CVEs) before pushing it to a registry.


### 5. NGINX as a Reverse Proxy

* **NGINX Ingress:** This requirement is fulfilled using a Kubernetes **Ingress** resource, defined in [`k8s/ingress.yaml`](./k8s/ingress.yaml). The Ingress is managed by an **NGINX Ingress Controller** running in the cluster, which acts as a sophisticated reverse proxy to route external traffic from `http://localhost` to the correct application service.
