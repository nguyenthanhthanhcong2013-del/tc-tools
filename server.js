const express = require('express');
const path = require('path');

const app = express();

// ⚠️ QUAN TRỌNG CHO RENDER
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// 👉 FIX LỖI Cannot GET /
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

let users = [];
let downloads = {};

// REGISTER
app.post('/register', (req, res) => {
    let { user, pass } = req.body;

    if (users.find(u => u.user === user)) {
        return res.send("EXIST");
    }

    users.push({ user, pass });
    res.send("OK");
});

// LOGIN
app.post('/login', (req, res) => {
    let { user, pass } = req.body;

    let u = users.find(x => x.user === user && x.pass === pass);
    res.send(u ? "OK" : "FAIL");
});

// DOWNLOAD
app.get('/download/:id', (req, res) => {
    let id = req.params.id;

    downloads[id] = (downloads[id] || 0) + 1;

    res.download(path.join(__dirname, 'file.bat'));
});

// COUNT
app.get('/count/:id', (req, res) => {
    res.json({ count: downloads[req.params.id] || 0 });
});

// 🚀 CHẠY SERVER
app.listen(PORT, () => {
    console.log("🔥 Server chạy trên cổng:", PORT);
});