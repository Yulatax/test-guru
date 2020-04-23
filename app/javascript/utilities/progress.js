document.addEventListener('turbolinks:load', function () {
    let progressWrapper = document.querySelector('.progress-wrapper');
    if (progressWrapper) {
        addProgressBar(progressWrapper);
    }
});

function addProgressBar(wrapper) {
    let currentQuestion = wrapper.dataset.questionNow;
    let questionsCount = wrapper.dataset.questionsCount;
    let progressBar = createProgressElement(currentQuestion, questionsCount);
    wrapper.appendChild(progressBar);
}

function createProgressElement(current, count) {
    let div = document.createElement('div');
    div.style.height = '100%';
    div.style.width = 100 * current / count + '%';
    div.style.backgroundColor = 'orange';
    return div;
}