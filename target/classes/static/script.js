// src/main/resources/static/script.js
const API_URL = "/tasks"; // default base path

async function loadTasks() {
  const response = await fetch(API_URL);
  const tasks = await response.json();

  const list = document.getElementById("taskList");
  list.innerHTML = "";

  tasks.forEach(task => {
    const li = document.createElement("li");
    li.innerHTML = `
      <span style="text-decoration:${task.completed ? 'line-through' : 'none'}">
        ${task.description}
      </span>
      <div>
        <button onclick="toggleComplete(${task.id}, ${task.completed})">✔</button>
        <button onclick="deleteTask(${task.id})">❌</button>
      </div>`;
    list.appendChild(li);
  });
}

async function addTask() {
  const input = document.getElementById("taskInput");
  const description = input.value;

  if (!description) return;

  await fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ description, completed: false }),
  });

  input.value = "";
  loadTasks();
}

async function toggleComplete(id, current) {
  await fetch(`${API_URL}/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ completed: !current }),
  });
  loadTasks();
}

async function deleteTask(id) {
  await fetch(`${API_URL}/${id}`, { method: "DELETE" });
  loadTasks();
}

// Initial load
loadTasks();
