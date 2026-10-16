function mostrarTopico(idTopico) {
    document.querySelectorAll('.topico-conteudo').forEach(topico => {
        topico.classList.remove('ativo');
    });

    const topicoSelecionado = document.getElementById(idTopico);
    if (topicoSelecionado) {
        topicoSelecionado.classList.add('ativo');
    }

    document.querySelectorAll('button[data-topico]').forEach(botao => {
        const escolhido = botao.dataset.topico === idTopico;
        botao.classList.toggle('ativo', escolhido);
        botao.setAttribute('aria-pressed', escolhido);
    });
}

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('button[data-topico]').forEach(botao => {
        botao.addEventListener('click', () => mostrarTopico(botao.dataset.topico));
    });

    mostrarTopico('aneis');
});
