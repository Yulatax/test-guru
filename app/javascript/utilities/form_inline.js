document.addEventListener('turbolinks:load', function () {
    $('.form-inline-link').on('click', formInlineLinkHandler);

    if (!document.contains(document.querySelector('.form-inline-link'))) {
        return;
    }

    let errors = document.querySelector('.resource-errors');
    if (errors) {
        let resourceId = errors.dataset.resourceId;
        console.log(resourceId);
        formInlineHandler(resourceId);
    }
});

function formInlineLinkHandler(event) {
    event.preventDefault();
    let testId = this.dataset.testId;
    formInlineHandler(testId);
}

function formInlineHandler(testId) {
    let link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]');
    let $testTitle = $('.test-title[data-test-id="' + testId + '"]');
    let $formInline = $('.form-inline[data-test-id="' + testId + '"]');

    $testTitle.toggle();
    $formInline.toggle();

    if ($formInline.is(':visible')) {
        link.textContent = 'Cancel'
    } else {
        link.textContent = 'Edit'
    }
}