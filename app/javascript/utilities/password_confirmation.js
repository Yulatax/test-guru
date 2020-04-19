document.addEventListener('turbolinks:load', function () {
    let password_fields = document.querySelectorAll('.password-matching');
    if (password_fields) {
        for (let i = 0; i < password_fields.length; i++) {
            password_fields[i].addEventListener('keyup', checkPasswordMatch)
        }
    }
});

function checkPasswordMatch() {
    let password1 = document.querySelector('#user_password').value;
    let password2 = document.querySelector('#user_password_confirmation').value;

    let issue_opened = document.querySelector('.octicon-issue-opened');
    let issue_closed = document.querySelector('.octicon-issue-closed');

    if (password1 && password2) {
        let res = compareStrings(password1, password2);
        if (!res) {
            issue_opened.classList.remove('hide');
            issue_closed.classList.add('hide');
        } else {
            issue_opened.classList.add('hide');
            issue_closed.classList.remove('hide');
        }
    } else {
        issue_opened.classList.add('hide');
        issue_closed.classList.add('hide');
    }
}

function compareStrings(str1, str2) {
    return str1 === str2;
}