package com.example.controller;

import com.example.model.Employee;
import com.example.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class EmployeeController {

    private final EmployeeService service;

    public EmployeeController(EmployeeService service) {
        this.service = service;
    }

    @GetMapping("/")
    public String showHome(@RequestParam(required = false) String search,
                           @RequestParam(required = false) String department,
                           @RequestParam(required = false) String role,
                           @RequestParam(required = false) String sort,
                           Model model) {

        model.addAttribute("employees", service.filterAndSort(search, department, role, sort));
        model.addAttribute("search", search);
        model.addAttribute("department", department);
        model.addAttribute("role", role);
        model.addAttribute("sort", sort);
        return "index";
    }

    @GetMapping("/employee/form")
public String showForm(@RequestParam(required = false) Long id, Model model) {
    if (id != null) {
        Employee employee = service.findById(id);
        if (employee != null) {
            model.addAttribute("employee", employee);
        }
    }
    return "form"; // renders form.ftl
}


    @PostMapping("/employee/submit")
    public String submitEmployee(@ModelAttribute Employee employee) {
        service.save(employee);
        return "redirect:/";
    }

    @GetMapping("/employee/delete")
    public String deleteEmployee(@RequestParam Long id) {
        service.delete(id);
        return "redirect:/";
    }
}
