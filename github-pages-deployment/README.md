# Github pages deployment

Creating a CI/CD Pipeline for my portfolio website. I'm using DevOps principles to automate the deployment of my webiste that I will use to showcase my work. 
There will be good understanding of the following concepts:

    GitHub Actions
    GitHub Pages
    Continuous Integration and Continuous Deployment
    Writing GitHub Actions workflows

Right now, to update your website, you probably have to manually upload your HTML, CSS, and JS files to a server or a web hosting control panel.

We will create a system where you simply push your code changes to GitHub, and a fully automated process will take over, deploying your updated site to the web.

## Step 1: Host your website on Github

1. **Create a New Repository on GitHub:**
    - Log in to GitHub.
    - Click the `+` icon in the top right and select "New repository."
    - Give it a name, like `my-devops-site`.
    - Make it **Public**.
    - Do **not** initialize it with a README, .gitignore, or license yet. We'll add our own files.
    - Click "Create repository"
2. **Push Your Existing Website Code:**
    - Open a terminal, command prompt or vscode terminal on your computer.
    - Navigate into the folder where your website files (`index.html`, `style.css`, etc.) are located.
    - Run the following commands one by one. Replace the URL with your own repository URL from the previous step. 
    
    ```bash
    # Initialize a new Git repository in your project folder
    git init -b main
    
    # Add all your files to be tracked by Git
    git add .
    
    # Make your first commit (a snapshot of your code)
    git commit -m "Initial commit of portfolio website"
    
    # Link your local repository to the one you created on GitHub
    git remote add origin https://github.com/your-username/my-devops-portfolio.git
    
    # Push your code to the 'main' branch on GitHub
    git push -u origin main
    ```
    
    Now, if you refresh your GitHub repository page, you will see all your website files there.


## Step 2: Choose Your Tools

All the tools we will be using for this project are from Github directly so it'll be nice and simple to use

- **CI/CD Platform:** **GitHub Actions**. It's built directly into your GitHub repository and is incredibly easy to get started with.
- **Deployment Target:** **GitHub Pages**. It's a free service from GitHub that hosts static websites directly from a repository.

## Step 3: Configure GitHub Pages for Automation

We need to tell your repository that deployments will be handled by GitHub Actions.

1. In your GitHub repository, click on the **Settings** tab.
2. In the left sidebar, click on **Pages**.
3. Under "Build and deployment," for the **Source**, select **GitHub Actions**.


## Step 4: Create the CI/CD Workflow File

This is the heart of the project. You'll define the steps for your automated pipeline in a YAML file.


1. In your local code editor (like VS Code), same location as your website:
    - Create a new folder called `.github`.
    - Inside `.github`, create another folder called `workflows`.
    - Inside `.github/workflows`, create a new file named `deploy.yml`.
2. Copy and paste the following code into your `deploy.yml` file:
    
    ```bash
    # Name of your workflow
    name: Deploy Portfolio Website
    
    # Controls when the action will run.
    # We'll trigger it on a push to the 'main' branch.
    on:
      push:
        branches: [ "main" ]
      # Allows you to run this workflow manually from the Actions tab
      workflow_dispatch:
    
    # A workflow run is made up of one or more jobs that can run sequentially or in parallel
    jobs:
      # This job is named "deploy"
      deploy:
        # The type of runner that the job will run on
        runs-on: ubuntu-latest
    
        # Grant GITHUB_TOKEN the permissions it needs to deploy to GitHub Pages
        permissions:
          contents: read
          pages: write
          id-token: write
    
        # Steps represent a sequence of tasks that will be executed as part of the job steps: # Step 1: Check out your repository code so the workflow can access it
          - name: Checkout code
            uses: actions/checkout@v4
    
          # Step 2: Configure GitHub Pages
          - name: Setup Pages
            uses: actions/configure-pages@v5
    
          # Step 3: "Build" your site by creating an artifact
          # For a static site, this just means packaging all the files.
          - name: Upload artifact
            uses: actions/upload-pages-artifact@v3
            with:
              # Upload the root directory of your repository
              path: '.'
    
          # Step 4: Deploy the artifact to GitHub Pages
          - name: Deploy to GitHub Pages
            id: deployment
            uses: actions/deploy-pages@v4
    ```
    
3. **Save the file.**

## Step 5: Commit and Push Your New Workflow

This very push will trigger your first-ever automated deployment!

1. Open your terminal in the project directory again.
2. Run these commands:
    
    ```bash 
    # Add the new workflow file
    git add .github/workflows/deploy.yml
    
    # Commit the new file
    git commit -m "feat: Add CI/CD workflow for GitHub Pages"
    
    # Push the commit to GitHub
    git push
    ```

## Step 6: Watch the Magic Happen!

1. Go back to your repository on GitHub and click the **Actions** tab.
2. You will see your workflow, "Deploy Portfolio Website," running. Click on it to see the `deploy` job and watch the steps execute in real time.
3. Once it completes successfully (about a minute), your website is live!
4. To find your website's URL, go back to **Settings > Pages**. You'll see a message at the top saying, "Your site is live at `https://your-username.github.io/my-devops-portfolio/`".
   

### Now everytime you make a change to your website and you do the following git add, commit, push. Your website link from step 6 will automatically update!