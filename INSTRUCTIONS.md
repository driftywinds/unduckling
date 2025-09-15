# Deploy Unduckling to Cloudflare Pages

Requirements: - 
- A Cloudflare account
- A PC with access to cli
- npm installed on the PC

Steps: -

### 1. Install Wrangler
```npm install -g wrangler```
### 2. Login to wrangler
```wrangler login```

Follow the link is spouts and login.

### 3. Initialize and build the app
```
npm install
npm run build
```
### 4. Deploy to CF
```wrangler pages deploy dist --project-name=<YOUR_PROJECT_NAME>```

Replace ```<YOUR_PROJECT_NAME>``` with whatever you want to call the URL of your deployment.
