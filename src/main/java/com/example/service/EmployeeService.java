package com.example.service;

import com.example.model.Employee;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
public class EmployeeService {

    private final List<Employee> employeeList = new ArrayList<>();
    private final AtomicLong idCounter = new AtomicLong();

    public EmployeeService() {
        // Dummy Data
        save(new Employee(null, "John", "Doe", "john@example.com", "HR", "Manager"));
        save(new Employee(null, "Jane", "Smith", "jane@example.com", "IT", "Engineer"));
        save(new Employee(null, "Charlie", "Lee", "charlie@example.com", "Finance", "Analyst"));

    }

    public List<Employee> findAll() {
        return new ArrayList<>(employeeList);
    }

    public Employee findById(Long id) {
        return employeeList.stream()
                .filter(emp -> emp.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void save(Employee employee) {
        if (employee.getId() == null) {
            employee.setId(idCounter.incrementAndGet());
            employeeList.add(employee);
        } else {
            for (int i = 0; i < employeeList.size(); i++) {
                if (employeeList.get(i).getId().equals(employee.getId())) {
                    employeeList.set(i, employee);
                    return;
                }
            }
        }
    }

    public void delete(Long id) {
        employeeList.removeIf(emp -> emp.getId().equals(id));
    }

    public List<Employee> filterAndSort(String search, String department, String role, String sort) {
        return employeeList.stream()
                .filter(emp -> {
                    boolean matchesSearch = search == null || search.isBlank()
                            || emp.getFirstName().toLowerCase().contains(search.toLowerCase())
                            || emp.getLastName().toLowerCase().contains(search.toLowerCase())
                            || emp.getEmail().toLowerCase().contains(search.toLowerCase());
                    boolean matchesDept = department == null || department.isBlank()
                            || emp.getDepartment().equalsIgnoreCase(department);
                    boolean matchesRole = role == null || role.isBlank()
                            || emp.getRole().equalsIgnoreCase(role);
                    return matchesSearch && matchesDept && matchesRole;
                })
                .sorted((e1, e2) -> {
                    if ("firstName".equalsIgnoreCase(sort)) {
                        return e1.getFirstName().compareToIgnoreCase(e2.getFirstName());
                    } else if ("department".equalsIgnoreCase(sort)) {
                        return e1.getDepartment().compareToIgnoreCase(e2.getDepartment());
                    }
                    return 0;
                })
                .collect(Collectors.toList());
    }
}

       