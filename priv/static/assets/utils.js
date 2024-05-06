document.getElementById("downloadButton").addEventListener("click", function() {
    // Cria um novo canvas temporário
    let canvas = document.createElement('canvas');
    let context = canvas.getContext('2d');
    canvas.width = 800; // largura da div
    canvas.height = 600; // altura da div
  
    // Desenha o conteúdo da div no canvas
    let divContent = document.getElementById('image_div');
    html2canvas(divContent, {
      allowTaint: true,
      useCORS: true
    }).then(function(canvas) {
      
      let now = new Date().toLocaleString().replaceAll(',', '_').replaceAll(' ', '').replaceAll(':', '_').replaceAll('/', '_') 

      let link = document.createElement('a');
      link.download = 'where_is_your_motivation_' + now + '.png';
      link.href = canvas.toDataURL("image/png");
      link.click();
    });
  });
  