const LANG = {
  vi:{
    optimize:"🧠 Tối ưu hoá máy tính",
    gaming:"🎮 Gaming"
  },
  en:{
    optimize:"🧠 Optimize PC",
    gaming:"🎮 Gaming"
  }
};

function setLang(lang){
  localStorage.setItem("lang",lang);
  applyLang();
}

function applyLang(){
  let lang = localStorage.getItem("lang") || "vi";
  document.querySelectorAll("[data-key]").forEach(e=>{
    e.innerText = LANG[lang][e.dataset.key];
  });
}

applyLang();