document.addEventListener('turbolinks:load', function () {
  let control = document.querySelector('.sort-by-title');
  if (control) { control.addEventListener('click', sortRowsByTitle) }
});

function sortRowsByTitle() {
  let table = document.querySelector('table');

  //NodeList
  //https://developer.mozilla.org/ru/docs/Web/API/NodeList
  let rows = table.querySelectorAll('tr');
  let sortedRows = [];
  //select all table rows except the first one which is a header
  for (let i = 1; i < rows.length; i++) {
    sortedRows.push(rows[i]);
  }

  let arrowUp = this.querySelector('.octicon-arrow-up');
  let arrowDown = this.querySelector('.octicon-arrow-down');

  if (arrowUp.classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc);
    arrowUp.classList.remove('hide');
    arrowDown.classList.add('hide');
  } else {
    sortedRows.sort(compareRowsDesc);
    arrowDown.classList.remove('hide');
    arrowUp.classList.add('hide');
  }

  let sortedTable = document.createElement('table');
  sortedTable.classList.add('table', 'table-striped');
  sortedTable.appendChild(rows[0]);

  for (let i = 0 ; i < sortedRows.length; i++) {
    sortedTable.appendChild(sortedRows[i]);
    if (i%2 !== 0) {
      sortedTable.rows[i].classList.add('dark-stripe')
    } else {
      sortedTable.rows[i].classList.remove('dark-stripe')
    }
  }

  table.parentNode.replaceChild(sortedTable, table);
}

function compareRowsAsc(row1, row2) {
  let testTitle1 = row1.querySelectorAll('td')[1].textContent.toLowerCase();
  let testTitle2 = row2.querySelectorAll('td')[1].textContent.toLowerCase();

  if (testTitle1 < testTitle2) { return -1}
  if (testTitle1 > testTitle2) { return 1}
  return 0
}

function compareRowsDesc(row1, row2) {
  let testTitle1 = row1.querySelectorAll('td')[1].textContent.toLowerCase();
  let testTitle2 = row2.querySelectorAll('td')[1].textContent.toLowerCase();

  if (testTitle1 < testTitle2) { return 1}
  if (testTitle1 > testTitle2) { return -1}
  return 0
}