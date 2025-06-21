// server.js
import express from 'express';
import dotenv from 'dotenv';
import basicAuth from 'express-basic-auth'; // Using a library for robust basic auth

// Load environment variables from .env file
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Basic Auth configuration
const users = {};
const username = process.env.USERNAME;
const password = process.env.PASSWORD;

if (!username || !password) {
    console.error("Error: USERNAME and PASSWORD must be set in the .env file for basic authentication.");
    // Exit if essential auth credentials are missing to prevent unprotected secret route.
    process.exit(1);
}

users[username] = password;

// Route 1: Home route
app.get('/', (req, res) => {
    res.send('Hello, world!');
});

// Route 2: Secret route, protected by Basic Auth
app.get('/secret', basicAuth({
    users: users,
    challenge: true, // Prompts for credentials
    unauthorizedResponse: (req) => {
        return req.auth ? 'Credentials rejected' : 'No credentials provided';
    }
}), (req, res) => {
    // If authentication is successful, return the secret message
    const secretMessage = process.env.SECRET_MESSAGE || 'No secret message configured.';
    res.send(`Secret Message: ${secretMessage}`);
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
    console.log(`Access home route: http://localhost:${port}/`);
    console.log(`Access secret route: http://localhost:${port}/secret (requires authentication)`);
});
