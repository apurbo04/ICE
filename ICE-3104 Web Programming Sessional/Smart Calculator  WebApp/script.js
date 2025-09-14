let input = document.getElementById('inputBox');
let buttons = document.querySelectorAll('button');
let historyBox = document.getElementById('history');

let string = "";
let arr = Array.from(buttons);

arr.forEach(button => {
  button.addEventListener('click', (e) => {
    if (e.target.innerHTML == '=') {
      try {
        let result = eval(string);
        input.value = result;

        // Save to DB via PHP
        saveHistory(string, result);

        string = result.toString();
      } catch {
        input.value = "Error";
        string = "";
      }
    } else if (e.target.innerHTML == 'AC') {
      string = "";
      input.value = string;
    } else if (e.target.innerHTML == 'DEL') {
      string = string.substring(0, string.length - 1);
      input.value = string;
    } else {
      string += e.target.innerHTML;
      input.value = string;
    }
  });
});

// Save history to DB
function saveHistory(expression, result) {
  fetch("save_history.php", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `expression=${encodeURIComponent(expression)}&result=${encodeURIComponent(result)}`
  })
    .then(() => loadHistory());
}

// Load history from DB
function loadHistory() {
  fetch("get_history.php")
    .then(res => res.json())
    .then(data => {
      historyBox.innerHTML = "";
      data.forEach(row => {
        let li = document.createElement("li");
        li.textContent = `${row.expression} = ${row.result}`;
        historyBox.appendChild(li);
      });
    });
}

// Load history when page starts
loadHistory();
