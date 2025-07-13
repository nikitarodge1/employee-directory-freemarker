<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title><#if employee?? && employee.id??>Edit<#else>Add</#if> Employee</title>
  <link rel="stylesheet" href="/styles/main.css" />
</head>
<body>
  <div class="form-card">
    <h2><#if employee?? && employee.id??>Edit<#else>Add</#if> Employee</h2>

    <form action="/employee/submit" method="post">
      <#if employee?? && employee.id??>
        <input type="hidden" name="id" value="${employee.id}" />
      </#if>

      <div class="form-row">
        <label for="firstName">First Name</label>
        <input type="text" name="firstName" id="firstName" required value="${(employee.firstName)!""}" />
      </div>

      <div class="form-row">
        <label for="lastName">Last Name</label>
        <input type="text" name="lastName" id="lastName" required value="${(employee.lastName)!""}" />
      </div>

      <div class="form-row">
        <label for="email">Email</label>
        <input type="email" name="email" id="email" required value="${(employee.email)!""}" />
      </div>

      <div class="form-row">
        <label for="department">Department</label>
        <select name="department" id="department" required>
          <option value="">Select Department</option>
          <option value="HR" <#if employee?? && employee.department?? && employee.department == "HR">selected</#if>>HR</option>
          <option value="IT" <#if employee?? && employee.department?? && employee.department == "IT">selected</#if>>IT</option>
          <option value="Finance" <#if employee?? && employee.department?? && employee.department == "Finance">selected</#if>>Finance</option>
        </select>
      </div>

      <div class="form-row">
        <label for="role">Role</label>
        <select name="role" id="role" required>
          <option value="">Select Role</option>
          <option value="Manager" <#if employee?? && employee.role?? && employee.role == "Manager">selected</#if>>Manager</option>
          <option value="Engineer" <#if employee?? && employee.role?? && employee.role == "Engineer">selected</#if>>Engineer</option>
        </select>
      </div>

      <div class="form-actions">
        <button type="button" onclick="window.location.href='/'">Cancel</button>
        <button type="submit">Save</button>
      </div>
    </form>
  </div>
</body>
</html>
