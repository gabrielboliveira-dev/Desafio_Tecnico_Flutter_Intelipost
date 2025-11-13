# Desafio Técnico: Busca de Artistas (Intelipost)

## Contexto

Este aplicativo Flutter integra duas APIs públicas distintas (YouTube Data API e Ticketmaster Discovery API) para criar um perfil unificado de um artista. Ao pesquisar por um nome (ex: "Coldplay"), o app exibe seus vídeos mais recentes e sua agenda de shows.

## 🚀 Requisitos Funcionais

1.  **Busca Unificada:** O usuário digita o nome do artista uma única vez.
2.  **Integração YouTube:** Buscar e listar os 5 vídeos mais recentes do artista (Título + Thumbnail). Ao clicar, abrir o vídeo (via link externo).
3.  **Integração Ticketmaster:** Buscar e listar os próximos eventos/shows do artista (Data, Local, Cidade). Ao clicar, abrir a página de ingressos.
4.  **UI com Abas:** Organizar os resultados em duas abas: "Vídeos" e "Eventos".

## 🛠️ Tecnologias Utilizadas

* **Flutter & Dart**
* **Provider** (Gerenciamento de Estado)
* **http** (Requisições REST)
* **url_launcher** (Para abrir os links dos vídeos e ingressos)
* **cached_network_image** (Para cache eficiente de imagens)

## 🔑 Configuração de APIs

Para rodar este projeto, você precisará de chaves para:
1.  **YouTube Data API v3** (Google Cloud Console).
2.  **Ticketmaster Discovery API** (Ticketmaster Developer Portal).
