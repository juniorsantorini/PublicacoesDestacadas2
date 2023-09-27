function carregarPublicacoes() {
  var listaPublicacoes = document.getElementById('lista-publicacoes');

  // Query para buscar todas as publicações
  var query = 'https://www.borapracima.pro/feeds/posts/default?alt=json';

  // Requisição AJAX para buscar as publicações
  var xhr = new XMLHttpRequest();
  xhr.open('GET', query, true);
  xhr.onreadystatechange = function () {
    if (xhr.readyState == 4 && xhr.status == 200) {
      var data = JSON.parse(xhr.responseText);
      var entries = data.feed.entry;

      if (entries) {
        // Array para armazenar as publicações destacadas
        var publicacoesDestacadas = [];

        for (var i = 0; i < entries.length; i++) {
          var postTitle = entries[i].title.$t;
          var postURL = entries[i].link[4].href;

          // Verifique se a publicação possui a etiqueta "destaque"
          var isDestaque = false;
          if (entries[i].category) {
            for (var j = 0; j < entries[i].category.length; j++) {
              if (entries[i].category[j].term == 'destaque') {
                isDestaque = true;
                break;
              }
            }
          }

          // Se a publicação for destacada, crie uma entrada de lista para ela
          if (isDestaque) {
            var listItem = document.createElement('li');
            var link = document.createElement('a');
            link.href = postURL;
            link.textContent = postTitle;
            listItem.appendChild(link);

            // Adicione a entrada de lista ao array de publicações destacadas
            publicacoesDestacadas.push(listItem);
          }
        }

        // Adicione as publicações destacadas à lista acima das outras publicações
        for (var k = 0; k < publicacoesDestacadas.length; k++) {
          listaPublicacoes.insertBefore(publicacoesDestacadas[k], listaPublicacoes.firstChild);
        }
      } else {
        listaPublicacoes.innerHTML = 'Nenhuma publicação encontrada.';
      }
    }
  };
  xhr.send();
}

// Chame a função para carregar as publicações
carregarPublicacoes();
