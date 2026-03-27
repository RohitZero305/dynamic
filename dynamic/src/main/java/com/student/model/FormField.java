package com.student.model;

import java.util.ArrayList;
import java.util.List;

public class FormField {
    private String name;
    private String label;
    private String type;
    private boolean isRequired;
    private List<String> options;

    public FormField(String name, String label, String type, boolean isRequired) {
        this.name = name;
        this.label = label;
        this.type = type;
        this.isRequired = isRequired;
        this.options = new ArrayList<>();
    }

    public String getName() { return name; }
    public String getLabel() { return label; }
    public String getType() { return type; }
    public boolean isRequired() { return isRequired; }
    public List<String> getOptions() { return options; }
    public void setOptions(List<String> options) { this.options = options; }
}