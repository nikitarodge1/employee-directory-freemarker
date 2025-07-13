<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Employee Directory</title>
  <link rel="stylesheet" href="/styles/main.css" />
</head>
<body>

  <header>
    <h1>Employee Directory</h1>
    <div class="search-add">
      <form action="/" method="get">
        <input type="text" name="search" placeholder="Search by name or email" value="${search!""}" />
        <button type="button" class="add-button" onclick="window.location.href='/employee/form'">Add Employee</button>
      </form>
    </div>
  </header>

  <div class="filters">
    <form action="/" method="get">
      <input type="hidden" name="search" value="${search!""}" />

      <label>
        Department:
        <select name="department" onchange="this.form.submit()">
          <option value="">All</option>
          <option value="HR" <#if (department!"") == "HR">selected</#if>>HR</option>
          <option value="IT" <#if (department!"") == "IT">selected</#if>>IT</option>
          <option value="Finance" <#if (department!"") == "Finance">selected</#if>>Finance</option>
        </select>
      </label>

      <label>
        Role:
        <select name="role" onchange="this.form.submit()">
          <option value="">All</option>
          <option value="Manager" <#if (role!"") == "Manager">selected</#if>>Manager</option>
          <option value="Engineer" <#if (role!"") == "Engineer">selected</#if>>Engineer</option>
        </select>
      </label>

      <label>
        Sort By:
        <select name="sort" onchange="this.form.submit()">
          <option value="">None</option>
          <option value="firstName" <#if (sort!"") == "firstName">selected</#if>>First Name</option>
          <option value="department" <#if (sort!"") == "department">selected</#if>>Department</option>
        </select>
      </label>
    </form>
  </div>

  <section id="employeeList">
    <#if employees?? && employees?size gt 0>
      <#list employees as emp>
        <div class="card">
          <h3>${emp.firstName} ${emp.lastName}</h3>
          <p><strong>Email:</strong> ${emp.email}</p>
          <p><strong>Department:</strong> ${emp.department}</p>
          <p><strong>Role:</strong> ${emp.role}</p>
          <div class="card-actions">
            <a href="/employee/form?id=${emp.id}"><button>Edit</button></a>
            <a href="/employee/delete?id=${emp.id}" onclick="return confirm('Are you sure?');">
              <button style="background-color:#d9534f;color:white;">Delete</button>
            </a>
          </div>
        </div>
      </#list>
    <#else>
      <p>No employees found.</p>
    </#if>
  </section>

  <footer>
    © 2025 Employee Directory App. All rights reserved.
  </footer>

</body>
</html>
