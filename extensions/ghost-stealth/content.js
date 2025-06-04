// Executa imediatamente
(() => {

// Função utilitária para sobreescrever propriedades da API do navegador
const override = (prop, value) => {
  Object.defineProperty(navigator, prop, {
    get: () => value,
    configurable: true // permite sobreescrever novamente se necessário
  });
};

// Remove navigator.webdriver
Object.defineProperty(navigator, "webdriver", {
  get: () => false,
});

// Fake languages
Object.defineProperty(navigator, "languages", {
  get: () => ["pt-BR", "pt", "en"],
});

// Fake hardwareConcurrency
Object.defineProperty(navigator, "hardwareConcurrency", {
  get: () => 4,
});

// Fake userAgent (opcional)
Object.defineProperty(navigator, "userAgent", {
  get: () => "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
});

})();
