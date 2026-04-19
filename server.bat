const express = require('express');
const path = require('path');

const app = express();

app.use(express.json());

// cho phép load web
app.use(express.static('public'));

let users = [];
let downloads = {};

// đăng ký
app.post('/register', (req,res)=>{
    users.push(req.body);
    res.send("OK");
});

// đăng nhập
app.post('/login', (req,res)=>{
    let u = users.find(x=>x.user===req.body.user && x.pass===req.body.pass);
    res.send(u ? "OK" : "FAIL");
});

// tải file thật
app.get('/download/:id',(req,res)=>{
    let id = req.params.id;
    downloads[id] = (downloads[id]||0)+1;

    res.download(path.join(__dirname,'file.bat'));
});

// lấy lượt tải
app.get('/count/:id',(req,res)=>{
    res.json({count:downloads[req.params.id]||0});
});

app.listen(3000,()=>console.log("🔥 Server chạy: http://localhost:3000"));