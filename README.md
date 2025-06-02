# **Azure Cloud Resume Challenge**  

### **🚀 Project Overview**
This repository contains the **complete code** for a **cloud-hosted resume** on **Microsoft Azure**, built as part of the [Cloud Resume Challenge](https://cloudresumechallenge.dev/).  

🔹 **Frontend**: Static resume (HTML/CSS/JS) deployed via **Azure Storage + CDN**  
🔹 **Backend**: Visitor counter processing logic powered by **Azure Functions**  
🔹 **Database**: Stores visitor counter in **Azure Cosmos DB (NoSQL)**  
🔹 **CI/CD**: Automated deployments using **GitHub Actions**  
🔹 **Infrastructure**: Provisioned with **Terraform (IaC)**  
🔹 **Testing**: Unit & integration tests for reliability  

📖 **For the full step-by-step guide**, see: **[Build Your Cloud Resume on Azure (Guide)](https://tulip-wallaby-757.notion.site/Azure-Cloud-Resume-Challenge-1877a6cb62e880cba62ce320288606e7)**  

**👨🏻‍💻 View my live azure cloud resume [here](https://www.ranbirnarang.com/)**.

---

### **🔧 Prerequisites**  
- **Azure Account** (free tier works)
- **Visual Studio Code**
- **Custom Domain**
- **.NET 9.0 SDK**
- **Azure Functions Core Tools**
- **Git**
- **GitHub Account**
- **Postman** (optional)
- **Terraform** (optional)

---

### **🛠 Repository Structure**  
```
azure-resume/
├── .github/workflows/           # CI/CD pipelines (GitHub Actions)
│   ├── frontend.build.yml
│   └── function.build.yml
├── AzureResume.Frontend/        # Static website (HTML/CSS/JS)
│   ├── index.html
│   └── 404.html
├── AzureResume.Function/        # Azure Function (C#) for counter API
│   ├── Models/
│   │   └── Counter.cs
│   ├── Services/
│   │   ├── CounterService.cs
│   │   └── ICounterService.cs
│   ├── GetCounter.cs
│   └── Program.cs
├── AzureResume.Function.Tests/  # Unit tests
│   └── CounterServiceTests.cs
├── .gitignore                   # Files and directories to ignore when making a commit
├── main.tf                      # Terraform for Azure infrastructure
└── README.md                    # You are here!
```

---

### **⚡ Quick Start (Deployment)**  
1. **Clone the repo**  
   ```bash
   git clone https://github.com/kanubir/azure-resume.git
   ```
2. **Deploy infrastructure** (Terraform)  
   ```bash
   cd azure-resume
   terraform init
   terraform apply
   ```
3. **Configure CI/CD**  
   - Add Azure credentials to GitHub Secrets  
   - Push changes to trigger workflows  

📌 **Detailed instructions?** Follow the **[full guide](https://tulip-wallaby-757.notion.site/Azure-Cloud-Resume-Challenge-1877a6cb62e880cba62ce320288606e7)**.  

---

### **🔗 Key Components**  
| Component          | Technology Used      | Purpose                          |
|--------------------|----------------------|----------------------------------|
| **Frontend**       | Azure Storage + CDN  | Hosts static resume website      |
| **Backend**        | Azure Functions (C#) | Processes visitor counter logic  |
| **Database**       | Cosmos DB (NoSQL)    | Stores & updates counter value   |
| **CI/CD**          | GitHub Actions       | Auto-deploys code on git push    |
| **Infrastructure** | Terraform            | Manages Azure resources as code  |
| **Testing**        | xUnit                | Unit tests for backend functions |

---

### **📖 Learn More**  
- **[Full Step-by-Step Guide](https://tulip-wallaby-757.notion.site/Azure-Cloud-Resume-Challenge-1877a6cb62e880cba62ce320288606e7)** – How to build this from scratch  
- [Azure Documentation](https://learn.microsoft.com/en-us/azure/)  
- [Cloud Resume Challenge](https://cloudresumechallenge.dev/)  

---

### **📜 License**  
MIT License - See [LICENSE](https://github.com/kanubir/azure-resume?tab=MIT-1-ov-file).  

---

### **💬 Feedback & Contributions**  
- **Issues?** Open a [GitHub Issue](https://github.com/kanubir/azure-resume/issues)  
- **Improvements?** Submit a [Pull Request](https://github.com/kanubir/azure-resume/pulls)!