I. A production-ready, multi-stage "Dockerfile" for the Java Calculator application compiles the project using Maven and packages it into a lightweight, secure runtime container.
Save this file as Dockerfile in the root directory of your java-calculator-project folder (next to pom.xml).

Build the container image: docker build -t java-calculator:latest .
Run the container locally: docker run --rm java-calculator:latest

II. Create a a GitHub Actions workflow file (docker-publish.yml), to automatically build and push this image to GitHub Packages or Docker Hub.
It is designed to run automatically on GitHub's cloud servers. Inside this file, the DOCKERHUB_USERNAME & DOCKERHUB_TOKEN secrets are to be added to https://github.com/organizations/MyTechOrg/settings/secrets/actions. Once you add your Docker Hub credentials to your repository's settings, you trigger this automation file through standard Git version control actions. To activate it, run these commands in your terminal:
• git add .github/workflows/docker-publish.yml
• git commit -m "Add Docker Hub publishing workflow"
• git push origin main

As soon as you run git push origin main, GitHub detects the file inside your .github/workflows/ directory, provisions a cloud runner machine, and executes the entire pipeline—building your container and pushing it to Docker Hub—automatically.

Note: You can make these secrets accessible to specific git repositories or all public repositories inside that git-org. By default this functionality works for public repo only. If you want this for any private repo, this is provided in a git paid-subscription only. 
In order to make the git repo visibility from private to public, you can execute the following command from GIT-CLI: 
gh repo edit --visibility public
Alternatively, you can do it from the github.com as well -
• Navigate to your repository on GitHub.
• Click on the Settings tab (the gear icon) in the top menu bar.
• On the General settings page, scroll all the way down to the bottom section called the Danger Zone.
• Click the Change visibility button next to "Change repository visibility".
• Select Change to public.
• Click I want to make this repository public and follow the confirmation prompts (you will be asked to type out the repository path, such as username/repository-name, to confirm).   

III. Create a Docker Compose file (docker-compose.yml), to orchestrate this alongside local logging or monitoring configurations:
a complete production-ready Docker Compose file that orchestrates your Java Calculator container alongside an integrated local logging and monitoring pipeline using Grafana Loki (for log collection) and Prometheus (for system metrics).
1. Create the Required Configuration Files
Before running Docker Compose, you need to create two small configuration files in your project root next to your Dockerfile. 
	- Create prometheus.yml (Metrics Scraper Config)
	- Create loki-config.yml (Log Storage Config)
2. The docker-compose.yml Stack File
Save this file as docker-compose.yml in the root of your project directory.

Access the Monitoring Console:
• Open your browser and go to http://localhost:3000 to load Grafana.
• Log in with Username: admin | Password: admin.
Connect Your Logs (Loki):
• Go to Connections > Data Sources > Add data source.
• Choose Loki.
• Inside the URL field, type http://loki:3100 and click Save & Test.
View Your Java App Logs Live:
• Navigate to the Explore tab in Grafana.
• Select your Loki data source.
• Run the query: {job="docker-logs"} to see your Java application's compilation records and operational output.

One of the primary benefits of Docker Compose is that it handles the entire installation process automatically. When you run the docker compose up command, Docker will look at the image names specified in your configuration file (such as image: prom/prometheus and image: grafana/loki), automatically download those pre-configured tool environments from Docker Hub, and launch them instantly as isolated containers.
The only tool you need installed on your local computer or WSL environment is Docker itself (which includes the Docker Compose plugin).

How to Spin Up and View Your Logs:
Launch the entire stack: docker compose up -d --build

After executing above command, Docker will pull down Prometheus, Loki, Grafana, and Promtail, compile your custom Java Calculator container, and link them all together in an internal network without cluttering your actual computer system.
