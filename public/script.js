// ===== LOGIN UI =====
function openLogin(){
    loginBox.style.display="flex";
}

// ===== LOGIN =====
function login(){
    let u=document.getElementById("user").value;
    let p=document.getElementById("pass").value;

    fetch('/login',{
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify({user:u,pass:p})
    })
    .then(r=>r.text())
    .then(d=>{
        alert(d==="OK"?"OK":"FAIL");
    });
}

// ===== REGISTER =====
function register(){
    let u=user.value,p=pass.value;

    fetch('/register',{
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify({user:u,pass:p})
    })
    .then(r=>r.text())
    .then(d=>alert(d));
}

// ===== DOWNLOAD =====
function download(id){
    window.location="/download/"+id;
}

// ===== COUNT =====
function load(){
["clean","ram","fps"].forEach(id=>{
fetch('/count/'+id)
.then(r=>r.json())
.then(d=>document.getElementById(id).innerText=d.count);
});
}

// ===== SEARCH =====
function doSearch(){
let v=search.value.toLowerCase();
document.querySelectorAll(".item").forEach(e=>{
e.style.display=e.innerText.toLowerCase().includes(v)?"block":"none";
});
}

// ===== LANGUAGE =====
const LANG={
vi:{opt:"🧠 Tối ưu",game:"🎮 Gaming"},
en:{opt:"🧠 Optimize",game:"🎮 Gaming"},
ja:{opt:"🧠 最適化",game:"🎮 ゲーム"},
fr:{opt:"🧠 Optimiser",game:"🎮 Jeu"}
};

function setLang(l){
document.querySelectorAll("[data-t]").forEach(e=>{
e.innerText=LANG[l][e.dataset.t];
});
}

// ===== START =====
load();